{
  lib,
  inputs,
  ...
}:
let
  clan.modules."dreamweave-user" = {
    _class = "clan.service";
    manifest.name = "@dreamweave/user";
    manifest.description = ''
      An instance of this module will create a user account on the added machines,
      along with a generated password that is constant across machines and user settings.
    '';
    manifest.categories = [ "System" ];

    roles.default = {
      interface =
        { lib, ... }:
        {
          options = {
            user = lib.mkOption {
              type = lib.types.str;
              example = "alice";
              description = "The user the password should be generated for.";
            };
            prompt = lib.mkOption {
              type = lib.types.bool;
              default = true;
              example = false;
              description = ''
                Whether the user should be prompted for a password.

                Effects:

                - *enabled* (`true`) - Prompt for a password during the machine installation or update workflow.
                - *disabled* (`false`) - Generate a password during the machine installation or update workflow.

                The password can be shown in two steps:

                - `clan vars list <machine-name>`
                - `clan vars get <machine-name> <name-of-password-variable>`
              '';
            };
            groups = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
              example = [
                "wheel"
                "networkmanager"
                "video"
                "input"
              ];
              description = ''
                Additional groups the user should be added to.
                You can add any group that exists on your system.
                Make sure these group exists on all machines where the user is enabled.
              '';
            };
            share = lib.mkOption {
              type = lib.types.bool;
              default = false;
              example = true;
              description = ''
                Whether the user should have the same password on all machines.
              '';
            };
          };
        };

      perInstance =
        { settings, ... }:
        {
          nixosModule =
            { config, pkgs, ... }:
            let
              user = settings.user;
            in
            {
              # Import Home Manager and per-user home-manager module (module name matches the username)
              imports = [
                inputs.home-manager.nixosModules.home-manager
                inputs.self.modules.nixos.${user}
              ];

              # Ensure group exists
              users.groups.${user} = { };

              users.users.${user} = {
                isNormalUser = if user == "root" then false else true;
                extraGroups = lib.concatLists [
                  settings.groups
                  [ user ]
                ];

                hashedPasswordFile =
                  config.clan.core.vars.generators."user-password-${user}".files.user-password-hash.path;
              };

              clan.core.vars.generators."user-password-${user}" = {
                files.user-password-hash.neededFor = "users";
                files.user-password-hash.restartUnits = lib.optional (config.services.userborn.enable) "userborn.service";
                files.user-password.deploy = false;

                prompts.user-password = lib.mkIf settings.prompt {
                  display = {
                    group = user;
                    label = "password";
                    required = false;
                    helperText = ''
                      Your password will be encrypted and stored securely using the secret store you've configured.
                    '';
                  };
                  type = "hidden";
                  persist = true;
                  description = "Leave empty to generate automatically";
                };

                runtimeInputs = [
                  pkgs.coreutils
                  pkgs.xkcdpass
                  pkgs.mkpasswd
                ];

                share = settings.share;

                script =
                  (
                    if settings.prompt then
                      ''
                        prompt_value=$(cat "$prompts"/user-password)
                        if [[ -n "''${prompt_value-}" ]]; then
                          echo "$prompt_value" | tr -d "\n" > "$out"/user-password
                        else
                          xkcdpass --numwords 4 --delimiter - --count 1 | tr -d "\n" > "$out"/user-password
                        fi
                      ''
                    else
                      ''
                        xkcdpass --numwords 4 --delimiter - --count 1 | tr -d "\n" > "$out"/user-password
                      ''
                  )
                  + ''
                    mkpasswd -s -m sha-512 < "$out"/user-password | tr -d "\n" > "$out"/user-password-hash
                  '';
              };

              # Per-user Home Manager configuration (imports the module with the same username)
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                users.${user} = {
                  imports = [ inputs.self.modules.homeManager.${user} ];
                };
              };
            };
        };
    };

    perMachine = {
      nixosModule = {
        # Immutable users to ensure that this module has exclusive control over the users.
        users.mutableUsers = false;
      };
    };
  };
in
{
  inherit clan;
}
