{
  flake.modules.nixos."agdgDiscordBot" =
    {
      ...
    }:
    {
      users = {
        groups = {
          containers = { };
          redbot = { };
        };

        users.containers = {
          group = "containers";
          isSystemUser = true;
          autoSubUidGidRange = true;
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
