{
  flake.modules.nixos."agdgDiscordBot" =
    { pkgs, ... }:
    {

      # Generator for Red Discord bot token used by your systemd unit's EnvironmentFile
      clan.core.vars.generators.redbot-token = {
        # Do not share by default. Set to true to share across machines.
        share = false;

        # Prompt for the token (hidden input)
        prompts.token = {
          description = "Red Discord bot token";
          type = "hidden";
          persist = false;
        };

        # Output file; clan will expose .path for use in NixOS config
        files."token.env".secret = false;

        # Script emits a token.env with TOKEN="value" and mode 0400
        script = ''
          umask 077
          # write token quoted to preserve special chars/newlines (strip trailing newline)
          printf 'TOKEN="%s"\n' "$(printf '%s' "$prompts/token" | tr -d '\r\n')" > $out/token.env
        '';

        runtimeInputs = [
          pkgs.coreutils
          pkgs.gnused
        ];
      };
    };

}
