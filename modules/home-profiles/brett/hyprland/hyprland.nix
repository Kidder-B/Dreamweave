{
  flake.modules.homeManager."Brett" =
    { lib, pkgs, ... }:
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
        enable = lib.mkForce true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      };
    };
}
