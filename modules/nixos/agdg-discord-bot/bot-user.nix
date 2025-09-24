{
  flake.modules.nixos."agdgDiscordBot" =
    {
      pkgs,
      ...
    }:

    let
      redbotDataDir = "/var/lib/redbot";
    in
    {
      users = {
        groups = {
          containers = { };
          redbot = { };
        };

        users.users.redbot = {
          isSystemUser = true;
          group = "redbot";
          uid = 210;
          home = "/var/lib/redbot";
        };

        users.groups.redbot = { };
      };

      users.extraUsers.containers = {
        group = "containers";
        isSystemUser = true;
        autoSubUidGidRange = true;
      };
    };
}
