{
  flake.modules.nixos."agdgDiscordBot" =
    {
      config,
      pkgs,
      ...
    }:

    let
      redbotDataDir = "/var/lib/redbot";
      redbotUID = 2001;
      redbotGID = 2001;
      redbotTokenPath = config.clan.core.vars.generators.redbot-token.files."token.env".path;
    in
    {
      virtualisation = {
        containers.enable = true;

        podman = {
          enable = true;
          dockerCompat = true; # keep "docker" alias
          defaultNetwork.settings.dns_enabled = true;
          autoPrune.enable = true;
        };

        oci-containers = {
          backend = "podman";
          containers.redbot = {
            image = "phasecorex/red-discordbot";
            autoStart = true;
            user = "${toString redbotUID}:${toString redbotGID}";
            environment = {
              PREFIX = ".";
              PUID = "${toString redbotUID}";
              TZ = "America/Denver";
            };
            environmentFiles = [ redbotTokenPath ];
            volumes = [
              "${redbotDataDir}:/data:rw"
            ];
            extraOptions = [
              "--userns=keep-id"
              "--private-users=65536:65536" # enables user namespace remapping
              "--network-alias=redbot"
              "--log-driver=journald"
            ];
          };
        };
      };

      environment.systemPackages = with pkgs; [
        podman
        podman-tui
        dive
      ];
    };
}
