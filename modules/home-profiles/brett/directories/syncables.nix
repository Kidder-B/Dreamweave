{
  flake.modules.homeManager."Brett" =
    { lib, ... }:

    let
      syncables = [
        "Blender/Syncable"
        "Clan/Dreamweave"
        "Godot/Syncable"
      ];

      createSyncableDirs = dirs:
        lib.hm.dag.entryAfter ["writeBoundary"] ''
          for dir in ${lib.concatStringsSep " " dirs}; do
            mkdir -p $VERBOSE_ARG "$HOME/$dir"

            chgrp -R syncthing "$HOME/$dir" 2>/dev/null || true

            find "$HOME/$dir" -type d -exec chmod u+rwx,g+rwx,g+s {} + 2>/dev/null || true
            find "$HOME/$dir" -type f -exec chmod u+rw,g+rw {} + 2>/dev/null || true

            chmod g+rwx "$HOME/$dir" 2>/dev/null || true
            chmod g+s "$HOME/$dir" 2>/dev/null || true

            setfacl -R -m g:syncthing:rwX "$HOME/$dir" 2>/dev/null || true
            setfacl -d -m g:syncthing:rwX "$HOME/$dir" 2>/dev/null || true
          done
        '';
    in
    {
      home.activation.syncableDirs =
        createSyncableDirs syncables;

      programs.git.settings = {
        "safe.directory" = syncables;
      };
    };
}
