{
  flake.modules.homeManager."Brett" = {
    home.shellAliases = {
      emacs = "emacsclient -c";
    };
    programs.emacs = {
      enable = true;
    };
    services.emacs = {
      enable = true;
    };
  };
}
