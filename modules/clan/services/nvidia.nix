{ inputs, ... }:
let
  modules = with inputs.self.modules.nixos; [ nvidia ];
in
{
  clan = {
    modules."nvidia" = {
      _class = "clan.service";
      manifest.name = "nvidia";

      roles.default = { };
      perMachine = {
        nixosModule = {
          imports = modules;
        };
      };
    };

    inventory.instances."nvidia" = {
      module.input = "self";
      module.name = "nvidia";
      roles.default.tags.nvidia = { };
    };
  };
}
