{ inputs, ... }:
{
  flake-file.inputs = {
    clan-core.url = "https://git.clan.lol/clan/clan-core/archive/main.tar.gz";
    nixpkgs.follows = "clan-core/nixpkgs";
    flake-parts.follows = "clan-core/flake-parts";
  };

  imports = [
    inputs.clan-core.flakeModules.default
  ];
}
