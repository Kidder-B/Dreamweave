{
  flake.modules.nixos.gnome-desktop = {
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };
}
