{
  flake.modules.nixos.tree =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        tree
      ];
    };
}
