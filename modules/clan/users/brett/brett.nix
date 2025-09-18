{ inputs, lib, ... }:

let
  name = "Brett";
  lowerName = lib.strings.toLower name;

  clan = {
    modules.${name} = {
      _class = "clan.service";
      manifest.name = name;

      roles.default = { };

      perMachine.nixosModule = {
        # Define system user with extra groups
        users.groups.${name} = { };
        users.users.${name} = {

          initialPassword = "password";
          isNormalUser = true;
          extraGroups = [
            name
            "wheel"
            "networkmanager"
            "video"
            "input"
          ];
        };

        # Import Home Manager and configure user
        imports = [
          inputs.home-manager.nixosModules.home-manager
          inputs.self.modules.nixos.${name}
        ];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${name} = {
            imports = [ inputs.self.modules.homeManager.${name} ];
          };
        };
      };
    };

    inventory.instances."${lowerName}-user" = {
      module.input = "self";
      module.name = name;
      roles.default.tags.${lowerName} = { };
    };
  };
in
{
  inherit clan;
}
