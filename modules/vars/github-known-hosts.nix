{ pkgs, lib, config, ... }:

{
  clan.core.vars.generators.github-known-hosts = {
    share = true;
    files."known_hosts".secret = false;
    runtimeInputs = [ pkgs.jq pkgs.curl ];
    script = ''
      # Fetch GitHub host keys
      response=$(curl -s https://api.github.com/meta)

      if [ -z "$response" ]; then
        echo "❌ Failed to fetch GitHub SSH keys" >&2
        exit 1
      fi

      echo "" > $out/known_hosts

      for key in $(echo "$response" | jq -r '.ssh_keys[]'); do
        # Extract key type (first word) and match host key
        key_type=$(echo "$key" | cut -d' ' -f1)
        case "$key_type" in
          ssh-rsa|ecdsa-sha2-nistp256|ssh-ed25519)
            echo "github.com $key" >> $out/known_hosts
            ;;
          *)
            echo "⚠️ Unknown key type: $key_type" >&2
            ;;
        esac
      done
    '';
  };
}
