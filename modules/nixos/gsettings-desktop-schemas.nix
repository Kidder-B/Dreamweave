{
  flake.modules.nixos.gsettings-desktop-schemas =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gsettings-desktop-schemas
      ];
    };
}
