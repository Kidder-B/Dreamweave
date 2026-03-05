{
  flake.modules.homeManager."Brett" = {
    programs.git = {
      enable = true;
      settings = {
        userName = "Kidder-B";
        userEmail = "kidderbrett@gmail.com";
      };
    };
  };
}
