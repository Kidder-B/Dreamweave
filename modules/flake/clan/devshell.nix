_: {
  perSystem =
    {
      pkgs,
      inputs',
      ...
    }:
    {
      devShells = {
        default = pkgs.mkShell {
          packages = [
            inputs'.clan-core.packages.default
          ];
        };
      };
    };
}
