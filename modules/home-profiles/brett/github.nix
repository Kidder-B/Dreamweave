{
  flake.modules.homeManager."Brett" =
    { osConfig, ... }:
    {
      programs.ssh.userKnownHostsFile =
        osConfig.clan.core.vars.generators."github-known-hosts".files."known_hosts".path;
    };
}
