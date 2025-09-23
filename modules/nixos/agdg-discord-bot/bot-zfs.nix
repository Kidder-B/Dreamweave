{
  flake.modules.nixos."agdgDiscordBot" =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      # Adjust to match your pool name
      podmanPool = "zpool";

      podmanDataset = "${podmanPool}/podman/storage";
      redbotDataset = "${podmanPool}/redbot";
      redbotDataDir = "/var/lib/redbot";

      keepCount = 5;

      podmanZfsScript = pkgs.writeShellScript "podman-zfs-setup" ''
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

      pruneSnapshotsScript = pkgs.writeShellScript "zfs-prune-redbot" ''
        echo "Pruning snapshots for ${redbotDataset}, keeping last ${toString keepCount}..."
        snaps=$(zfs list -H -t snapshot -o name -s creation -r ${redbotDataset} || true)
        count=$(echo "$snaps" | wc -l)

        if [ "$count" -gt ${toString keepCount} ]; then
          remove=$(echo "$snaps" | head -n -${toString keepCount})
          for s in $remove; do
            echo "Destroying snapshot $s"
            zfs destroy "$s"
          done
        fi
      '';
    in
    {
      config = {
        system.activationScripts.podmanZfs = {
          text = ''
            ${podmanZfsScript}
          '';
        };

        systemd.services."zfs-snapshot-redbot" = {
          description = "ZFS snapshot redbot dataset before rebuild";
          before = [ "nixos-rebuild.service" ];
          serviceConfig.Type = "oneshot";
          script = ''
            ts=$(date +%Y%m%d-%H%M%S)
            echo "Creating snapshot: ${redbotDataset}@pre-rebuild-$ts"
            zfs snapshot ${redbotDataset}@pre-rebuild-$ts || true
          '';
        };

        systemd.services."zfs-prune-redbot" = {
          description = "Prune old ZFS snapshots for redbot dataset";
          serviceConfig.Type = "oneshot";
          script = "${pruneSnapshotsScript}";
        };

        systemd.timers."zfs-prune-redbot" = {
          description = "Run snapshot pruning daily";
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnCalendar = "daily";
            Persistent = true;
          };
        };
      };
    };
}
