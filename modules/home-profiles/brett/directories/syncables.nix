{
  flake.modules.homeManager."Brett" =
    { lib, ... }:
    let
      createSyncableDirs = dirs: lib.hm.dag.entryAfter ["writeBoundary"] ''
        for dir in ${lib.toString (lib.attrNames dirs)}; do
          mkdir -p $VERBOSE_ARG "$HOME/Brett/$dir"
          chgrp syncthing $VERBOSE_ARG "$HOME/Brett/$dir" || echo "Failed to set group for $dir directory."
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
