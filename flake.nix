# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    clan-core = {
      url = "https://git.clan.lol/clan/clan-core/archive/main.tar.gz";
    };
    devshell = {
      url = "github:numtide/devshell";
    };
    flake-aspects = {
      url = "github:vic/flake-aspects";
    };
    flake-file = {
      url = "github:vic/flake-file";
    };
    flake-parts = {
      follows = "clan-core/flake-parts";
      url = "github:hercules-ci/flake-parts";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    import-tree = {
      url = "github:vic/import-tree";
    };
    khanelivim = {
      url = "github:khaneliman/khanelivim";
    };
    nix-auto-follow = {
      url = "github:fzakaria/nix-auto-follow";
    };
    nixpkgs = {
      follows = "clan-core/nixpkgs";
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    nixpkgs-lib = {
      follows = "nixpkgs";
    };
    quadlet-nix = {
      url = "github:SEIAROTg/quadlet-nix";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };
  };

}
