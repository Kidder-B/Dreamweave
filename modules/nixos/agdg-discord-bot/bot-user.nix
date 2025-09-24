{
  flake.modules.nixos."agdgDiscordBot" = {
    users = {
      groups = {
        redbot = {
          gid = 210;
        };
      };

      extraUsers.redbot = {
        isSystemUser = true;
        group = "redbot";
        uid = 210;
        home = "/var/lib/redbot";
      };
    };
  };
}
