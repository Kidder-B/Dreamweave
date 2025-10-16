{
  flake.modules.nixos."somno" = {
    boot.initrd.systemd = {
      enable = true;
    };

    #users.root.shell = "/bin/systemd-tty-ask-password-agent";

    boot.initrd.network = {
      enable = true;

      ssh = {
        enable = true;
        port = 7172;
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOG1j99Pbv8XbbpbkJVMThRo05gFeR/26W+0vXMUecN nixbld@Trance"

          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEfOhubXnAeYNgXq+XQG87RD/rvT8p0euZdTbxB0X+gd nixbld@nixos"
        ];
        hostKeys = [
          "/var/lib/initrd_host_ed25519_key"
          "/var/lib/initrd_host_rsa_key"
        ];
      };
    };
    boot.initrd.availableKernelModules = [
      "xhci_pci"
    ];

    # Find out the required network card driver by running `lspci -k` on the target machine
    boot.initrd.kernelModules = [ "r8169" ];
  };
}
