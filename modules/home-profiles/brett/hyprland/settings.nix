{
  flake.modules.homeManager."Brett" = {
    wayland.windowManager.hyprland = {
      settings = {
        misc = {
          force_default_wallpaper = 0;
        };
        "$mod" = "SUPER";
        bind = [
          "$mod, Q, exec, kitty -e fish"
          ", Print, exec, grimblast copy area"
          "$mod, C, killactive"
          "$mod, M, exit"
          "$mod, F, fullscreen"
          "$mod, V, togglefloating"
          "$mod, P, pseudo" # dwindle
          "$mod, J, togglesplit" # dwindle
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );
      };
    };
  };
}
