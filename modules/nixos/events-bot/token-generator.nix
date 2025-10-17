{
  flake.modules.nixos."eventsBot" =
    { pkgs, ... }:
    {
      clan.core.vars.generators.events-bot-token = {
        share = false;

        prompts.token = {
          description = "Red Discord bot token";
          type = "hidden";
          persist = false;
        };

        files."token" = {
          secret = true;
          mode = "0400";
          owner = "redbot";
          group = "redbot";
        };

        script = ''
          echo -n "TOKEN=" > $out/token
          cat $prompts/token >> $out/token
        '';

        runtimeInputs = [ pkgs.coreutils ];
      };
    };
}
