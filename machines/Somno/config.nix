{
  users.root.shell = "/bin/systemd-tty-ask-password-agent";

  boot = {
    kernelModules = [ "r8169" ];
    kernelParams = [ "loglevel=7" ];

    initrd = {
      kernelModules = [ "r8169" ];
      availableKernelModules = [
        "xhci_pci"
      ];
      systemd.enable = true;

      network = {
        enable = true;

        ssh = {
          enable = true;
          port = 7171;
          authorizedKeys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEfOhubXnAeYNgXq+XQG87RD/rvT8p0euZdTbxB0X+gd nixbld@nixos"
          ];
          hostKeys = [
            "/var/lib/initrd_host_ed25519_key"
            "/var/lib/initrd_host_rsa_key"
          ];
        };
      };
    };
  };

  # Networking setup post-decryption
  networking = {
    useDHCP = true; # Enable DHCP for network configuration during boot
    networkmanager.enable = false; # Disable NetworkManager to avoid conflicts with initrd network setup
  };
}
