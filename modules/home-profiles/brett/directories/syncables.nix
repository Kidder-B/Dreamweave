{
  flake.modules.homeManager."Brett" =
    { lib, ... }:

    let
      createSyncableDirs = dirs:
        lib.hm.dag.entryAfter ["writeBoundary"] ''
          for dir in ${lib.concatStringsSep " " dirs}; do
            mkdir -p $VERBOSE_ARG "$HOME/$dir"
            chgrp syncthing $VERBOSE_ARG "$HOME/$dir" \
              || echo "Failed to set group for $dir directory."
            chmod g+rwx $VERBOSE_ARG "$HOME/$dir"
            chmod g+s $VERBOSE_ARG "$HOME/$dir"
          done
        '';
    in
    {
      home.activation.syncableDirs =
        createSyncableDirs [
          "Blender/Syncable"
          "Clan/Dreamweave"
          "Godot/Syncable"
        ];
    };
}
