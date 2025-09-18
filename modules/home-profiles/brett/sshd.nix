{
flake.modules.homeManager."Brett" =
{ osConfig, ... }:
let
  clanSshKey = osConfig.clan.core.vars.generators.openssh.files."ssh.id_ed25519".path;
in
{
  # Enable SSH client config
  programs.ssh.enable = true;

  # Enable the SSH agent for the user
  services.ssh-agent.enable = true;

  # Add the Clan-managed key to the agent on login
  programs.ssh.addKeysToAgent = "yes";

  # Declare a Match block for GitHub (and/or others)
  programs.ssh.matchBlocks."github.com" = {
    identityFile = [ clanSshKey ];
    identitiesOnly = true;
    user = "git";
  };

};
}
