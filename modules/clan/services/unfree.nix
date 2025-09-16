{ inputs, ... }:
let
  inherit (inputs.self.lib.clan)
    mkService
    mkTag
    ;

  clan.modules = mkService "unfree" (with inputs.self.modules.nixos; [ unfree ]);
  clan.inventory.instances = mkTag "unfree";
in
{
  inherit clan;
}
