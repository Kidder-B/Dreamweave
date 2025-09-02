{
  clan = {
    # Ensure this is unique among all clans you want to use.
    meta.name = "Dreamweave";
  
    inventory.machines = {
      # Define machines here.
      "Trance" = {
        deploy.targetHost = "root@192.168.0.21";
        tags = [ ];
      };
    };
  
    # Docs: See https://docs.clan.lol/reference/clanServices
    inventory.instances = {
  
      # Docs: https://docs.clan.lol/reference/clanServices/admin/
      # Admin service for managing machines
      # This service adds a root password and SSH access.
      admin = {
        roles.default.tags.all = { };
        roles.default.settings.allowedKeys = {
          # Insert the public key that you want to use for SSH access.
          # All keys will have ssh access to all machines ("tags.all" means 'all machines').
          # Alternatively set 'users.users.root.openssh.authorizedKeys.keys' in each machine
          "admin-machine-1" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN+LhElRovxT0LgPhodvbh0TIsEDlRPrAF7JxvcjH0s1 brettk@nixos";
        };
      };
  
      # Docs: https://docs.clan.lol/reference/clanServices/zerotier/
      # The lines below will define a zerotier network and add all machines as 'peer' to it.
      # !!! Manual steps required:
      #   - Define a controller machine for the zerotier network.
      #   - Deploy the controller machine first to initilize the network.
      zerotier = {
        # Replace with the name (string) of your machine that you will use as zerotier-controller
        # See: https://docs.zerotier.com/controller/
        # Deploy this machine first to create the network secrets
        roles.controller.machines."Trance" = { };
        # Peers of the network
        # tags.all means 'all machines' will joined
        roles.peer.tags.all = { };
      };
  
      # Docs: https://docs.clan.lol/reference/clanServices/tor/
      # Tor network provides secure, anonymous connections to your machines
      # All machines will be accessible via Tor as a fallback connection method
      tor = {
        roles.server.tags.nixos = { };
      };
  
      jon-user = { # 
  
        module.name = "users";
  
        roles.default.tags.all = { }; # 
  
        roles.default.settings = {
          user = "Brett"; # 
          groups = [
            "wheel" # Allow using 'sudo'
            "networkmanager" # Allows to manage network connections.
            "video" # Allows to access video devices.
            "input" # Allows to access input devices.
          ];
        };
      };
    };
  
    # Additional NixOS configuration can be added here.
    # machines/jon/configuration.nix will be automatically imported.
    # See: https://docs.clan.lol/guides/more-machines/#automatic-registration
    machines = {
      "Trance" = { config, pkgs, ... }: {
        environment.systemPackages = [ pkgs.asciinema ];
        users.users.root.openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN+LhElRovxT0LgPhodvbh0TIsEDlRPrAF7JxvcjH0s1 brettk@nixos"
        ];
      };
    };
  };
}
