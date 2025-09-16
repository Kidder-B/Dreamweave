{ inputs, ... }:
let
  clan.machines."Trance".imports = (
    with inputs.self.modules.nixos;
    [
      all-firmware
    ]
  );
in
{
  inherit clan;
}
