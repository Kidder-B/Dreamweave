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

      systemd.user.extraConfig = ''
        DefaultEnvironment="PATH=~/.emacs.d/bin:$PATH"
      '';
     };
}
