{
  flake.modules.nixos.desktop-portal =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
}
