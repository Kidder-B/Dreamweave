{
  flake.modules.homeManager."Brett" = {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        exec-once = waybar
      '';
    };
  };
}
