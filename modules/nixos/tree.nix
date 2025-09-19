{pkgs, ...}:
{
  flake.modules.nixos.tree = {
    environment.systemPackages = with pkgs; [
  tree
];
  };
}
