{
  flake.modules.homeManager."Brett" = {
    programs.git = {
      enable = true;
      settings.user = {
        name = "Kidder-B";
        email = "kidderbrett@gmail.com";
      };
    };
  };
}
