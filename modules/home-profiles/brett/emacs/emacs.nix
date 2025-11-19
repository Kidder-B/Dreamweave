{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      programs.emacs = {
        enable = true;
        package = pkgs.emacs;
        defaultEditor = true;
        extraConfig = ''
          (setq standard-indent 2)
        '';
      };
    };
}
