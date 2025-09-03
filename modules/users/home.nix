{ inputs, ... }:
let
  flake.modules.nixos."Brett" = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users."Brett".imports = with inputs.self.modules.homeManager; [
        home-manager
        firefox
      ];
    };
  };
in
{
  inherit flake;
}
