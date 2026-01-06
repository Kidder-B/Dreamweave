{
  flake.modules.nixos.clang =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        clang
      ];
    };
}