{ inputs, ... }:
let
  clan.machines."Trance".imports = (
    with inputs.self.modules.nixos;
    [
      gnome-desktop
      unfree
      nvidia
      all-firmware
    ]
  );
in
{
  inherit clan;
}
