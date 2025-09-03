{
  clan.inventory.machines = {
    # Define machines here.
    "Trance" = {
      deploy.targetHost = "root@192.168.0.21";
      tags = [ ];
    };
  };
  clan.machines = {
    "Trance" =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.asciinema ];
        users.users.root.openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN+LhElRovxT0LgPhodvbh0TIsEDlRPrAF7JxvcjH0s1 brettk@nixos"
        ];
      };
  };
}
