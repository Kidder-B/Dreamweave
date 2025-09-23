{
  flake.modules.nixos."agdgDiscordBot" =
    {
      config,
      pkgs,
      lib,
      ...
    }:

    let
      redbotName = "redbot";
      redbotDataDir = "/var/lib/redbot";
      redbotUID = 2001;
      redbotGID = 2001;
    in
    {
      users = {
        groups."${redbotName}" = {
          gid = redbotGID;
        };

        users."${redbotName}" = {
          isSystemUser = true;
          createHome = true;
          home = redbotDataDir;
          description = "redbot service user";
          uid = redbotUID;
          autoSubUidGidRange = true;
          group = redbotName;
          shell = pkgs.bashInteractive;
          linger = true;
        };
      };
    };
}
