{ inputs, ... }:
let
  self = self.inputs;
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      home.packages = [
        (
          let
            baseConfig = inputs.khanelivim.packages.${pkgs.system}.default;
            extendedConfig = baseConfig.extendModules {

              modules = [
                {
                  imports = with self.modules.nixvim; [ "Brett" ];
                }
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
