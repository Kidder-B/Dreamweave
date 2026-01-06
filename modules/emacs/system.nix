{
  flake.modules.nixos.emacs =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.emacs
      ];

      services.emacs.enable = true;
      
      programs.emacs = {
        enable = true;
        defaultEditor = true;
      };
    };
}
