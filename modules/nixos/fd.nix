{
  flake.modules.nixos.fd =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        fd
      ];
    };
}
