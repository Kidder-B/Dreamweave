{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:

    {
      programs.rofi = {
        enable = true;
      };
    };
}
