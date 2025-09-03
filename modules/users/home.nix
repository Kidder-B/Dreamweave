{ inputs, ... }:
let
  flake.modules.homeManager."Brett" = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users."Brett".imports = with inputs.self.modules.homeManager; [
        home-manager
      ];
    };
  };
in
{
  inherit flake;
}
