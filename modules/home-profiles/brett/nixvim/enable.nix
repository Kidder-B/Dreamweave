{ inputs, ... }:
{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      home.packages = [
        # Option A: Use default configuration
        inputs.khanelivim.packages.${pkgs.system}.default
      ];
    };
}
