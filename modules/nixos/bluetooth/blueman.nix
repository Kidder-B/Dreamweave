{
  flake.modules.nixos.bluetooth =
    { pkgs, ... }:
    {
      services.blueman.enable = true;
    };
}
