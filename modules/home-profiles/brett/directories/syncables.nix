{
  flake.modules.homeManager."Brett" =
    { config, lib, ... }:

    let
      syncables = [
        "Blender/Syncable"
        "Clan/Dreamweave"
        "Godot/Syncable"
        ".doom.d/"
        ".config/blender"
        ".config/godot"
      ];

      createSyncableDirs = dirs:
        lib.hm.dag.entryAfter ["writeBoundary"] ''
          for dir in ${lib.concatStringsSep " " dirs}; do
            run mkdir -p $VERBOSE_ARG "$HOME/$dir"

            run chown -R ${config.home.username}:syncthing "$HOME/$dir" 2>/dev/null || true
            run chmod -R g+rwX "$HOME/$dir" 2>/dev/null || true
            run find "$HOME/$dir" -type d -exec chmod g+s {} \; 2>/dev/null || true

            run setfacl -R -m m:rwx,g:syncthing:rwX "$HOME/$dir" 2>/dev/null || true
            run setfacl -R -d -m m:rwx,g:syncthing:rwX "$HOME/$dir" 2>/dev/null || true

            IGNORE_FILE="$HOME/$dir/.stignore"

            verboseEcho "Writing .stignore for $dir"
            run cat <<'EOF' > "$IGNORE_FILE"
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
(?d)result*
EOF
            run chown $VERBOSE_ARG ${config.home.username}:syncthing "$IGNORE_FILE"
            run chmod $VERBOSE_ARG 664 "$IGNORE_FILE"
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
