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

      environment.sessionVariables = {
        PATH = [
          "/home/Brett/.emacs.d/bin"
        ];
      };
     };
}
