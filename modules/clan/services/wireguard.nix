{
  clan = {
    inventory.instances = {

      vpn = {
        roles.controller.machines."Somno" = {
          settings = {
            endpoint = "vpn1.homevpn.example.com"; # DNS or IP of home server
            port = 51820; # optional, default
          };
        };

        roles.peer.machines."Trance" = {
          settings = {
            controller = "Somno"; # This machine connects via 'home-server'
          };
        };
      };

    };
  };
}
