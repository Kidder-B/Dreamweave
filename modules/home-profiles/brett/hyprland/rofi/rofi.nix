{
  flake.modules.homeManager."Brett" =
    { ... }:

    {
      programs.rofi = {
        enable = true;
      };
    };
}
