{
  boot.initrd.systemd = {
    enable = true;
  };

  # uncomment this if you want to be asked for the decryption password on login
  #users.root.shell = "/bin/systemd-tty-ask-password-agent";

  boot.initrd.network = {
    enable = true;

    ssh = {
      enable = true;
      port = 7172;
      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN+LhElRovxT0LgPhodvbh0TIsEDlRPrAF7JxvcjH0s1 brettk@nixos"
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
  boot.initrd.kernelModules = [ "e1000e" ];
}
