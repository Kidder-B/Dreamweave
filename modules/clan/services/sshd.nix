{
  clan.inventory.instances = {
    # By default this service only generates ed25519 host keys
    sshd-basic = {
      module = {
        name = "sshd";
        input = "clan-core";
      };
      roles.server.tags.all = { };
      roles.client.tags.all = { };
    };

    # Also generate RSA host keys for all servers
    sshd-with-rsa = {
      module = {
        name = "sshd";
        input = "clan-core";
      };
      roles.server.tags.all = { };
      roles.server.settings = {
        hostKeys.rsa.enable = true;
      };
      roles.client.tags.all = { };
    };
  };
}
