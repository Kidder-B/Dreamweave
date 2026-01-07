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

      environment.etc."environment.d/00-custom-path.conf".text = ''
        PATH="/home/Brett/.emacs.d/bin:$PATH"
      '';
    };
}
