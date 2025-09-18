{
  flake.modules.homeManager."Brett" = {
    wayland.windowManager.hyprland.settings = {
      binds = [
        "SUPER, Q, exec, firefox"
      ];

    };
  };
}
