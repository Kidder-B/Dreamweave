{ inputs, lib, ... }:

let
  name = "Brett";
  lowerName = lib.strings.toLower name;

  clan = {
    modules.${name} = {
      _class = "clan.service";
      manifest.name = "@dreamweave/brett-user";
      manifest.description = ''
        Create the "Brett" system user, its group, initial password and
        Home Manager imports. This is a bespoke service for the Brett user.
      '';

      roles.default = {
        perInstance = {
          nixosModule =
            let
              userName = "Brett";
            in
            {
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

                #hashedPasswordFile =
                #  config.clan.core.vars.generators."user-password-${userName}".files.user-password-hash.path;
              };

              # Import Home Manager and per-user home-manager module
              imports = [
                inputs.home-manager.nixosModules.home-manager
                inputs.self.modules.nixos.${userName}
                inputs.self.modules.nixos.user-password
              ];

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
