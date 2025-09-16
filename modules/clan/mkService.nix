let
  flake.lib.clan.mkService = 
    name: opts:
      let
        opts' = lib.defaults opts {
	  imports = [];
	  tags = {};
	  extraAttrs = {};
	}
      imports = opts'.imports;
      tags = opts'.tags;
      extraAttrs = opts'.extraAttrs;
      in
      {
      clan = {
        modules."${name}" = lib.deepMerge
          {
            _class = "clan.service";
            manifest.name = name;
            roles.default = {};
            perMachine = {
              nixosModule = {
                imports = imports;
              };
            };
          } extraAttrs;

        inventory.instances."${name}" = {
          module.input = "self";
          module.name = name;
          roles.default.tags.${name} = tags;
        };
      };
    };
in
{
  inherit flake;
}
