{
  flake.modules.nixos.emacs =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
      ];

      environment.systemPackages = [
        pkgs.emacsGcc  # Installs Emacs 28 + native-comp
      ];
    };
}
