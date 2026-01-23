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
            run mkdir -p $VERBOSE_ARG "$HOME/$dir"

            run chgrp $VERBOSE_ARG syncthing "$HOME/$dir" 2>/dev/null || true
            run chmod $VERBOSE_ARG g+s "$HOME/$dir" 2>/dev/null || true

            run setfacl -R -m m:rwx,g:syncthing:rwX "$HOME/$dir" 2>/dev/null || true
            run setfacl -d -m m:rwx,g:syncthing:rwX "$HOME/$dir" 2>/dev/null || true

            IGNORE_FILE="$HOME/$dir/.stignore"
            IGNORE_CONTENT="
            IGNORE_CONTENT="
                (?d).git/
                (?d).jj/
                (?d).git/*.lock
                (?d).DS_Store
                (?d).Trash-*

                (?d).godot/
                (?d).tmp/

                (?d)*.blend[0-9]*

                (?d)*~
                (?d).*.swp
                (?d).*.swo
                (?d)#*#
                (?d).elc

                (?d).*.kra~
                (?d)*.xcf~
                (?d)*_data/

                (?d)bin/
                (?d)obj/
                (?d)target/
                (?d)result*"
      
            if [[ ! -f "$IGNORE_FILE" ]] || [[ "$(< "$IGNORE_FILE")" != "$IGNORE_CONTENT" ]]; then
              verboseEcho "Updating .stignore for $dir"
              run echo "$IGNORE_CONTENT" > "$IGNORE_FILE"
              run chown $VERBOSE_ARG ${config.home.username}:syncthing "$IGNORE_FILE"
              run chmod $VERBOSE_ARG 664 "$IGNORE_FILE"
            fi
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
