{
  # Docs: See https://docs.clan.lol/reference/clanServices
  clan.inventory.instances = {

    # Docs: https://docs.clan.lol/reference/clanServices/admin/
    # Admin service for managing machines
    # This service adds a root password and SSH access.
    admin = {
      roles.default.tags.all = { };
      roles.default.settings.allowedKeys = {
        # Insert the public key that you want to use for SSH access.
        # All keys will have ssh access to all machines ("tags.all" means 'all machines').
        # Alternatively set 'users.users.root.openssh.authorizedKeys.keys' in each machine
        "admin-machine-1" =
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOG1j99Pbv8XbbpbkJVMThRo05gFeR/26W+0vXMUecN nixbld@Trance";
      };
    };

  };

}
