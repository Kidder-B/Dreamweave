{ inputs, ... }:
{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      wayland.windowManager.hyprland = {
        plugins = with inputs; [
          hy3.packages.${pkgs.system}.default
        ];

        # Whether to enable Hyprland wayland compositor
        enable = true;
        # The hyprland package to use
        package = pkgs.hyprland;
        # Whether to enable XWayland
        xwayland.enable = true;

        # Optional
        # Whether to enable hyprland-session.target on hyprland startup
        systemd.enable = true;
      };
    };
}
