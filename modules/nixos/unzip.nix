{
  flake.modules.nixos.unzip =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        unzip
      ];
    };
}
