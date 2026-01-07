{
  flake.modules.nixos.emacs =
    { pkgs, ... }:
    {
      services.emacs = {
        package = pkgs.emacs;
        enable = true;
        defaultEditor = true;
      };

      environment.systemPackages = with pkgs; [
        emacsPackages.gsettings
      ];

      environment.variables.PATH = "/home/Brett/.emacs.d/bin:${pkgs.coreutils}/bin:${pkgs.stdenv.shell}/bin:$PATH";
    };
}
