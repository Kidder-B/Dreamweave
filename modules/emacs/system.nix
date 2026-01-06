{
  flake.modules.nixos.emacs =
    { pkgs, ... }:
    {
      services.emacs.enable = true;
      
      nixpkgs.overlays = [
        (import (builtins.fetchTarball {
	  url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
	  sha256 = "7b7d24b82fcc577e64808cc5dd60a51b4403b4d74e6d0dab833ab8a9effc6b92";
	}))
      ];

      environment.systemPackages = [
        pkgs.emacsGcc  # Installs Emacs 28 + native-comp
      ];
    };
}
