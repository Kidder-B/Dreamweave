let
  flake.modules.homeManager.vic =
    {
      programs.ssh = {
        enable = true;
      };
    };
in
{
  inherit flake;
}
