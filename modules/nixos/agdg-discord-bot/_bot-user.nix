{
  flake.modules.nixos."agdgDiscordBot" =
    {
      pkgs,
      ...
    }:

    let
      redbotName = "redbot";
      redbotDataDir = "/var/lib/redbot";
    in
    {
      users = {
        groups = {
          containers = { };
          "${redbotName}" = { };
        };

        users."${redbotName}" = {
          isSystemUser = true;
          createHome = true;
          home = redbotDataDir;
          description = "redbot service user";
          group = redbotName;
          autoSubUidGidRange = true;
        };
      };

      users.extraUsers.containers = {
        group = "containers";
        isSystemUser = true;
        autoSubUidGidRange = true;
      };
    };
}
