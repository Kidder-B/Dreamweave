{
  flake.modules.nixos."agdgDiscordBot" =
    { pkgs, ... }:
    {
      clan.core.vars.generators.redbot-token = {
        share = false;

        prompts.token = {
          description = "Red Discord bot token";
          type = "hidden";
          persist = false;
        };

        files."token-env" = {
          secret = true;
          mode = "0400";
          owner = "redbot";
          group = "redbot";
        };

        script = ''
          echo -n "TOKEN=" > $out/token-env
          cat $prompts/token >> $out/token-env
        '';

        runtimeInputs = [ pkgs.coreutils ];
      };
    };
}
