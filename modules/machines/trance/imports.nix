{ inputs, ... }:
let
  clan.machines."Trance".imports = (
    with inputs.self.modules.nixos;
    [
      gnome-desktop
      all-firmware
      obs-virtual-camera-support
    ]
  );
in
{
  inherit clan;
}
