{
  flake.modules.homeManager."Brett" = {
home.file.".ssh/known_hosts".source =
  config.clan.core.vars.generators.github-known-hosts.files."known_hosts".path;
  };
}
