{
  flake.modules.nixos.emacs =
    { pkgs, ... }:
    {
      services.emacs.enable = true;
      
      programs.emacs = {
        enable = true;
        defaultEditor = true;
      };
    };
}
