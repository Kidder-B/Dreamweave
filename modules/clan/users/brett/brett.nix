{ config, inputs, lib, ... }:

let
  name = "Brett";
  lowerName = lib.strings.toLower name;



  clan = {
    modules.${name} = {
      _class = "clan.service";
      manifest.name = "@dreamweave/brett-user";
      manifest.description = ''
        Create the "Brett" system user, its group, and
        Home Manager imports. This is a bespoke service for the Brett user.
      '';

      roles.default = {
        perInstance = {
          nixosModule =
            let
              userName = "Brett";
	      inherit (inputs.self.lib.clan) mkUserPasswordGenerator;
	      generator = mkUserPasswordGenerator userName;
            in
            {
	      
              # Import Home Manager and per-user home-manager module
              imports = [
                inputs.home-manager.nixosModules.home-manager
                inputs.self.modules.nixos.${userName}
              ];


	      clan.core.vars.generators = { generator };

              # Ensure group exists
              users.groups.${userName} = { };

              # System user definition using generated hashed password file
              users.users.${userName} = {
                isNormalUser = true;
                extraGroups = [
                  userName
                  "wheel"
                  "networkmanager"
                  "video"
                  "input"
                ];

                hashedPasswordFile =
                  config.clan.core.vars.generators."user-password-${userName}".files.user-password-hash.path;
              };


              # Home Manager configuration for the user
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                users.${userName} = {
                  imports = [ inputs.self.modules.homeManager.${userName} ];
                };
              };
            };
        };
      };

      perMachine = {
        nixosModule = {
          # Immutable users so this module controls users exclusively.
          users.mutableUsers = false;
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
