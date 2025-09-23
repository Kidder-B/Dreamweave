{
  flake.modules.nixos."agdgDiscordBot" =
    {
      config,
      pkgs,
      lib,
      ...
    }:

    let
      # change these variables to relocate persistent data and user name/ids
      redbotName = "redbot";
      redbotDataDir = "/var/lib/redbot";
      redbotUID = 2001;
      redbotGID = 2001;
      redbotTokenPath = config.clan.core.vars.generators.redbot-token.files."token.env".path;
      dockerBin = "${pkgs.docker}/bin/docker";
      loginctl = "${pkgs.systemd}/bin/loginctl";
    in
    {

      users = {
        groups."redbot" = {
          gid = redbotGID;
        };
        users.${redbotName} = {
          isSystemUser = true;
          createHome = true;
          home = "${redbotDataDir}";
          description = "redbot service user";
          uid = redbotUID;
          group = "redbot";
          extraGroups = [
            "docker"
          ];
        };
      };

      virtualisation.docker = {
        enable = true;
        rootless.enable = true;
        rootless.setSocketVariable = true;
      };

      environment.systemPackages = with pkgs; [
        docker
      ];

      systemd = {
        tmpfiles.rules = lib.mkIf false [ ];
        services."redbot-docker.service" = {
          description = "Red Discord bot container (rootless docker, per-user)";
          serviceConfig = {
            Type = "simple";
            Environment = ''
              DOCKER_HOST=unix:///run/user/${toString redbotUID}/docker.sock
              PREFIX="."
              PUID="${toString redbotUID}"
              TZ="America/Denver"
            '';
            EnvironmentFile = "${redbotTokenPath}";
            ExecStartPre = lib.mkForce ''
              set -eux
              dir=${redbotDataDir}
              uid=${toString redbotUID}
              gid=${toString redbotGID}
              mode=0755

              if [ ! -d "$dir" ]; then
                echo "Creating $dir"
                mkdir -p -- "$dir"
                chown -- "$uid:$gid" "$dir"
                chmod -- "$mode" "$dir"
              fi

              sock=/run/user/${toString redbotUID}/docker.sock

              # Wait up to 30s for the rootless docker socket to appear
              for i in 1 2 3 4 5 6; do
                if [ -S "$sock" ]; then break; fi
                echo "Waiting for rootless docker socket..."
                sleep 5
              done

              # Prefer checking daemon responsiveness once socket exists
              if [ -S "$sock" ]; then
                ${dockerBin} --host "$DOCKER_HOST" info >/dev/null 2>&1 || true
              fi

              ${dockerBin} --host "$DOCKER_HOST" network inspect redbot_default >/dev/null 2>&1 || \
                ${dockerBin} --host "$DOCKER_HOST" network create redbot_default || true
            '';
            ExecStart = lib.mkForce ''
              exec ${dockerBin} --host "$DOCKER_HOST" run --rm \
                --name redbot \
                --network-alias=redbot \
                --network=redbot_default \
                --user "${toString redbotUID}:${toString redbotGID}" \
                -e PREFIX="$PREFIX" \
                -e PUID="$PUID" \
                -e TOKEN="$TOKEN" \
                -e TZ="$TZ" \
                -v "${redbotDataDir}:/data:rw" \
                --log-driver=journald \
                phasecorex/red-discordbot
            '';
            ExecStop = lib.mkForce ''
              ${dockerBin} --host "$DOCKER_HOST" stop -t 30 redbot || true
              ${dockerBin} --host "$DOCKER_HOST" rm -f redbot || true
            '';
            Restart = "always";
            RestartSec = "5s";
            KillMode = "control-group";
            KillSignal = "SIGTERM";
            TimeoutStartSec = "60s";
            TimeoutStopSec = "60s";
            ProtectSystem = "strict";
            PrivateTmp = "yes";
            NoNewPrivileges = "yes";
          };
          wantedBy = [ "default.target" ];
        };
      };

      systemd.services."enable-redbot-lingering" = {
        description = "Enable lingering for redbot and start user units at boot";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
        };
        preStart = ''
          ${loginctl} enable-linger ${redbotName}
        '';
        script = ''
          ${pkgs.systemd}/bin/systemd-run --uid=${redbotName} --scope ${pkgs.systemd}/bin/systemctl --user daemon-reload || true
          ${pkgs.systemd}/bin/systemd-run --uid=${redbotName} --scope ${pkgs.systemd}/bin/systemctl --user enable --now redbot-docker.service || true
        '';

      };

    };
}
