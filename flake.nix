# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    clan-core.url = "https://git.clan.lol/clan/clan-core/archive/main.tar.gz";
    devshell.url = "github:numtide/devshell";
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      follows = "clan-core/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    import-tree.url = "github:vic/import-tree";
    nixpkgs = {
      follows = "clan-core/nixpkgs";
    };
    nixpkgs-lib.follows = "nixpkgs";
    quadlet-nix.url = "github:SEIAROTg/quadlet-nix";
    systems.url = "github:nix-systems/default";
  };

}
