{
  flake.modules.homeManager."Brett" =
    { lib, ... }:
    let
      createSyncableDirs = dirs: lib.hm.dag.entryAfter ["writeBoundary"] ''
        for dir in ${toString (lib.attrNames dirs)}; do
          mkdir -p $VERBOSE_ARG "$HOME/$dir"
          chgrp syncthing $VERBOSE_ARG "$HOME/$dir" || echo "Failed to set group for $dir directory."
        done
      '';
    in
    {
      home.activation = {
        syncableDirs = createSyncableDirs {
          # Define Syncables here
          Blender = "Blender/Syncable";
          Clan = "Clan/Dreamweave";
          Godot = "Godot/Syncable";
        };
      };
    };
}
