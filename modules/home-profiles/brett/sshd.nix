{
  flake.modules.homeManager."Brett" =
    { osConfig, ... }:
    let
      clanSshKey = osConfig.clan.core.vars.generators.brett-ssh-key.files."id_ed25519".path;
      githubKnownHosts = osConfig.clan.core.vars.generators."github-known-hosts".files."known_hosts".path;
    in
    {

      programs.ssh = {
        enable = true;

        enableDefaultConfig = false;

        services.ssh-agent.enable = true;

        # Declare a Match block for GitHub (and/or others)
        matchBlocks."github.com" = {
          addKeysToAgent = "yes";
          identityFile = [ clanSshKey ];
          identitiesOnly = true;
          user = "git";
          userKnownHostsFile = githubKnownHosts;
        };
      };
    };
}
