{
  flake.modules.nixos.polkit =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        polkit
      ];
    };
}
