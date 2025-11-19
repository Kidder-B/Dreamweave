{
  flake.modules.homeManager."Brett" = {
    wayland.windowManager.hyprland = {
      settings = {
        "$mod" = "SUPER";
        bind = [
          "$mod, R, exec, rofi -show drun -show-icons"
        ];
      };
    };
  };
}
