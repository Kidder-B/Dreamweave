{
  flake.modules.nixos."eventsBot" =
    { pkgs, ... }:
    {
      clan.core.vars.generators.eventsBot = {
        share = false;

        prompts.token = {
          description = "Red Discord bot token";
          type = "hidden";
          persist = false;
        };

        files."eventsBotToken" = {
          secret = true;
          mode = "0400";
          owner = "redbot";
          group = "redbot";
        };

        script = ''
          echo -n "TOKEN=" > $out/eventsBotToken
          cat $prompts/token >> $out/eventsBotToken
        '';

        runtimeInputs = [ pkgs.coreutils ];
      };
    };
}
