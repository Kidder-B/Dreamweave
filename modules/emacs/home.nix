{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      programs.emacs = {
        enable = true;
        package = pkgs.emacs;
      };
    };
}
