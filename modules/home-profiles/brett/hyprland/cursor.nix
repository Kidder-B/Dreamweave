{
  flake.modules.homeManager."Brett" = {
    wayland.windowManager.hyprland = {
      settings =
        let
          cursorSize = "24";
          cursorName = "Fuchsia-Pop";
        in
        {
          env = [
            # Cursors
            "XCURSOR_SIZE,${cursorSize}"
            "HYPRCURSOR_SIZE,${cursorSize}"
            "HYPRCURSOR_THEME,${cursorName}"
            "XCURSOR_THEME,${cursorName}"
          ];
        };
    };
  };
}
