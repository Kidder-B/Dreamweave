{ inputs, ... }:
{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      wayland.windowManager.hyprland = {
        plugins = with pkgs.hyprlandPlugins; [
          hy3
        ];

        # Whether to enable Hyprland wayland compositor
        enable = true;
        # The hyprland package to use
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
        # Whether to enable XWayland
        xwayland.enable = true;

        # Optional
        # Whether to enable hyprland-session.target on hyprland startup
        systemd.enable = true;
      };
    };
}
