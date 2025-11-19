{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = ''
          exec-once = waybar
        '';
      };
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        config = {
          hyprland = {
            default = [
              "hyprland"
              "gtk"
            ];
            "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
          };
        };
      };
    };
}
