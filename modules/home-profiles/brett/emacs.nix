{
  flake.modules.homeManager."Brett" = {
    programs.emacs = {
      enable = true;
    };
    services.emacs = {
      enable = true;
    };
  };
}
