{ inputs, ... }:
let
  moduleImports = with inputs.self.modules.nixvim; [ Brett ];
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      home.packages = [
        (
          let
            baseConfig = inputs.khanelivim.nixvimConfigurations.${pkgs.system}.khanelivim;
            extendedConfig = baseConfig.extendModules {
              modules = [
                { imports = moduleImports; }
              ];
            };

          in
          extendedConfig.config.build.package
        )

      ];
    };
in
{
  inherit flake;
}
