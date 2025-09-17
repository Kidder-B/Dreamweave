{
  flake.modules.nixos.shared-vars =
    { pkgs, ... }:
    {
      clan.core.vars.generators.github-known-hosts = {
        share = true;
        files."known_hosts".secret = false;
        runtimeInputs = [
          pkgs.jq
          pkgs.curl
        ];

        script = ''
          curl -fsS https://api.github.com/meta | jq -r '.ssh_keys[]' > "$out/known_hosts"
        '';
      };
    };
}
