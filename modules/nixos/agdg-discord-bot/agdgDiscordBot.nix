{
  flake.modules.nixos."agdgDiscordBot" =
    {
      config,
      pkgs,
      lib,
      ...
    }:

    let
      # variables
      redbotName = "redbot";
      redbotDataDir = "/var/lib/redbot";
      redbotUID = 2001;
      redbotGID = 2001;
      redbotTokenPath = config.clan.core.vars.generators.redbot-token.files."token.env".path;

      # Adjust to match your pool name
      podmanPool = "zpool";
      podmanDataset = "${podmanPool}/podman/storage";
      redbotDataset = "${podmanPool}/redbot";
    in
    {
      users = {
        groups."redbot" = {
          gid = redbotGID;
        };
        users.${redbotName} = {
          isSystemUser = true;
          createHome = true;
          home = redbotDataDir;
          description = "redbot service user";
          uid = redbotUID;
          autoSubUidGidRange = true;
          group = "redbot";
          shell = pkgs.bashInteractive;
        };
      };

      virtualisation = {
        containers.enable = true;

        podman = {
          enable = true;
          dockerCompat = true; # keep "docker" alias
          defaultNetwork.settings.dns_enabled = true;
          autoPrune.enable = true;
        };

        oci-containers = {
          backend = "podman";
          containers.redbot = {
            image = "phasecorex/red-discordbot";
            autoStart = true;
            user = "${toString redbotUID}:${toString redbotGID}";
            privateUsers = true; # tighter sandbox
            environment = {
              PREFIX = ".";
              PUID = "${toString redbotUID}";
              TZ = "America/Denver";
            };
            environmentFiles = [ redbotTokenPath ];
            volumes = [
              "${redbotDataDir}:/data:rw"
            ];
            extraOptions = [
              "--userns=keep-id"
              "--network-alias=redbot"
              "--log-driver=journald"
            ];
          };
        };
      };

      environment.systemPackages = with pkgs; [
        podman
        podman-tui
        dive
      ];

      # Enable lingering declaratively
      services.logind.lingerUsers = [ redbotName ];

      # Declarative ZFS dataset management
      system.activationScripts.podmanZfs = {
        text = ''
          echo "Ensuring ZFS datasets for Podman and Redbot..."

          # Podman storage dataset
          if ! zfs list -H -o name ${podmanDataset} >/dev/null 2>&1; then
            if ! zfs list -H -o name ${podmanPool}/podman >/dev/null 2>&1; then
              echo "Creating dataset ${podmanPool}/podman..."
              zfs create -o mountpoint=/var/lib/containers ${podmanPool}/podman
            fi

            echo "Creating dataset ${podmanDataset}..."
            zfs create -o acltype=posixacl ${podmanDataset}
          fi
          zfs set acltype=posixacl ${podmanDataset}
          zfs set mountpoint=/var/lib/containers/storage ${podmanDataset}

          # Redbot dataset
          if ! zfs list -H -o name ${redbotDataset} >/dev/null 2>&1; then
            echo "Creating dataset ${redbotDataset}..."
            zfs create \
              -o mountpoint=${redbotDataDir} \
              -o compression=lz4 \
              -o atime=off \
              ${redbotDataset}
          fi
          zfs set mountpoint=${redbotDataDir} ${redbotDataset}
          zfs set compression=lz4 ${redbotDataset}
          zfs set atime=off ${redbotDataset}
        '';
      };
    };
}
