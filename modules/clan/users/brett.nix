{ inputs, ... }:
let
  clan.inventory.instances = {
    brett-user = {
      module.name = "users";

      roles.default.tags.all = { };

      roles.default.settings = {
        user = "Brett";
        groups = [
          "wheel"
          "networkmanager"
          "video"
          "input"
        ];
      };

      roles.default.extraModules = [
        {
          imports = [ inputs.home-manager.nixosModules.home-manager ];
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."Brett" = {
              imports = [ inputs.self.modules.homeManager."Brett" ];
            };
          };
        }
      ];
    };
  };
in
{
  inherit clan;
}
