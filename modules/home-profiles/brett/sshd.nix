let
  flake.modules.homeManager."Brett" = {
    programs.ssh = {
      enable = true;
    };
  };
in
{
  inherit flake;
}
