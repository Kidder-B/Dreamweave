let
  flake.lib.clan = {
    inherit mkService;
  };

  mkService = name: modules: {
    "${name}" = {
      _class = "clan.service";
      manifest.name = name;
      roles.default = { };
      perMachine = {
        nixosModule = {
          imports = modules;
        };
      };
    };
  };
in
{
  inherit flake;
}
