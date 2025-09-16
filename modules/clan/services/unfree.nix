{ inputs, ... }:
let
  modules = with inputs.self.modules.nixos; [ unfree ];
in
{
  clan = {
    modules."unfree" = {
      _class = "clan.service";
      manifest.name = "unfree";

      roles.default = { };
      perMachine = {
        nixosModule = {
          imports = modules;
        };
      };
    };

    inventory.instances."unfree" = {
      module.input = "self";
      module.name = "unfree";
      roles.default.tags.unfree = { };
    };
  };
}
