{
  flake.modules.homeManager."Brett" = {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
    };
  };
}
