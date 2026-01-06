{
  flake.modules.nixos.emacs =
    { pkgs, ... }:
    {
      services.emacs = {
        package = pkgs.emacs;
        enable = true;
        defaultEditor = true;
      };
    };
}
