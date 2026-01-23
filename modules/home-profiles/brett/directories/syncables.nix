{
  flake.modules.homeManager."Brett" =
    { config, lib, ... }:

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

            find "$HOME/$dir" -type d -exec chmod g+s {} + 2>/dev/null || true

            setfacl -R -m m:rwx,g:syncthing:rwX "$HOME/$dir" 2>/dev/null || true
            setfacl -d -m m:rwx,g:syncthing:rwX "$HOME/$dir" 2>/dev/null || true
          done
        '';
    in
    {
      home.activation.syncableDirs = createSyncableDirs syncables;

      programs.git.settings = {
        safe = {
          directory = map (dir: "${config.home.homeDirectory}/${dir}") syncables;
        };
      };
    };
}
