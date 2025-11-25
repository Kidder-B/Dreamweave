{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.freetype
      ];
    };
}
