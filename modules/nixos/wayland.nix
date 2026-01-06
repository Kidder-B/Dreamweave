{
  flake.modules.nixos.wayland =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        wayland
      ];
    };
}
