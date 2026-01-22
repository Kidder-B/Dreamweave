{
  flake.modules.nixos.systemd-boot = {
    boot.loader.systemd-boot.configurationLimit = 25;
  };
}
