{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
        extraConfig = ''
          exec-once = waybar
        '';
      };
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      };
    };
}
