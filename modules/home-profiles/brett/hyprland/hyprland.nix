{
  flake.modules.homeManager."Brett" = {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        exec = pkill waybar & sleep 0.5 && waybar
      '';
    };
  };
}
