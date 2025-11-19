{
  flake.modules.homeManager."Brett" = {
    wayland.windowManager.hyprland = {
      settings = {
        "$mod" = "SUPER";
        bind = [
          "$mod, F, exec, rofi -show drun -show-icons"
        ];
      };
    };
  };
}
