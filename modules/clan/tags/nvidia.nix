{ inputs, ... }:
let
  clan.inventory.instances = {
    example-name = {
      module.name = "importer";
      roles.default.tags."nvidia" = { };
      roles.default.extraModules = with inputs.self.modules.nixos; [
        nvidia
        unfree
      ];
    };
  };
in
{
  inherit clan;
}
