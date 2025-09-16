{ lib, ... }:
let
  flake.lib.clan.mkService =
    name: opts:
    let
      opts' = lib.defaults opts {
        imports = [ ];
        extraAttrs = { };
      };
      imports = opts'.imports;
      extraAttrs = opts'.extraAttrs;
    in
    {
      clan = {
        modules."${name}" = lib.recursiveUpdate {
          _class = "clan.service";
          manifest.name = name;
          roles.default = { };
          perMachine = {
            nixosModule = {
              imports = imports;
            };
          };
        } extraAttrs;

        inventory.instances."${name}" = {
          module.input = "self";
          module.name = name;
          roles.default.tags.${name} = {};
        };
      };
    };

in
{
  inherit flake;
}
