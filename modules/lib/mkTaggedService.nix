let
  flake.lib.clan.mkTaggedService = 
  name: modules: {
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

    instances."${name}" = {
      module.input = "self";
      module.name = name;
      roles.default.tags.${name} = { };
    };
  };

in
{
  inherit flake;
}
