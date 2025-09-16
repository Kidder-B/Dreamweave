let
  flake.lib.clan.mkService = name: modules: {
      modules."${name}" = {
        _class = "clan.service";
        manifest.name = name;
        roles.default = { };
        perMachine = {
          nixosModule = {
            imports = modules;
          };
        };
      };

      inventory.instances."${name}" = {
        module.input = "self";
        module.name = name;
        roles.default.tags.${name} = { };
      };
  };
in
{
  inherit flake;
}
