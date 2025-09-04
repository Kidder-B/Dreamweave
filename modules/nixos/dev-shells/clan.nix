{ inputs, ... }:
{
  perSystem.devshells =
    inputs.nixpkgs.lib.genAttrs
      [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ]
      (system: {
        default = inputs.clan-core.inputs.nixpkgs.legacyPackages.${system}.mkShell {
          packages = [ inputs.clan-core.packages.${system}.clan-cli ];
        };
      });
}
