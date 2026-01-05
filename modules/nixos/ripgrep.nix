{
  flake.modules.nixos.ripgrep =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ripgrep
      ];
    };
}
