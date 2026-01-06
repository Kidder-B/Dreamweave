{
  flake.modules.nixos.glib =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        glib
      ];
    };
}
