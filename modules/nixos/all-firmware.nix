{
  flake.modules.nixos.all-firmware = {
    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;
  };
}
