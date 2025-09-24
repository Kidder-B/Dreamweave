{
  flake.modules.nixos."agdgDiscordBot" =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      redbotName = "redbot";
      redbotDataDir = "/var/lib/redbot";
      redbotToken = config.clan.core.vars.generators.redbot-token.files."token".value;
    in
    {
      users = {
        groups = {
          containers = { };
          "${redbotName}" = { };
        };

        users."${redbotName}" = {
          isSystemUser = true;
          createHome = true;
          home = redbotDataDir;
          description = "redbot service user";
          group = redbotName;
          autoSubUidGidRange = true;
          linger = true;
        };
      };

      users.extraUsers.containers = {
        group = "containers";
        isSystemUser = true;
        autoSubUidGidRange = true;
      };

      environment.systemPackages = with pkgs; [
        podman
        podman-tui
        dive
      ];

      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
        autoPrune.enable = true;
      };

      systemd.user.services.redbot = {
        description = "Red Discord Bot (rootless Podman)";
        after = [ "network.target" ];

        serviceConfig = {
          User = "redbot";
          RuntimeDirectory = "redbot";
          Type = "notify";
          Restart = "always";
          ExecStart = ''
            ${pkgs.podman}/bin/podman run \
              --name redbot \
              --network redbot_default \
              --network-alias redbot \
              -v ${redbotDataDir}:/data:rw \
              -e TZ="America/Denver" \
              -e TOKEN = ${redbotToken}  \
              phasecorex/red-discordbot
          '';
          Environment = "PREFIX=.";
        };

        # Environment variables in NixOS format
        environment = lib.mkForce {
          PATH = "${pkgs.coreutils}/bin:${pkgs.podman}/bin:$PATH";
          PODMAN_SYSTEMD_UNIT = "%n";
        };

        wantedBy = [ "default.target" ];
      };

      systemd.services."podman-network-redbot_default" = {
        path = [ pkgs.podman ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStop = "podman network rm -f redbot_default";
        };
        script = ''
          podman network inspect redbot_default || podman network create redbot_default
        '';
      };
    };
}
