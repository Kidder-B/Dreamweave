{ inputs, ... }:
let
  clan.machines."Trance".imports = [
    inputs.self.modules.nixos.gnome-desktop
  ];
in
{
  inherit clan;
}
