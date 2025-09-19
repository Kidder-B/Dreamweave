{inputs, ...}:
{
  imports = with inputs.flake-file.flakeModules; [ nix-auto-follow allfollow ];
  flake-file = {
    prune-lock.enable = false;
  };
}
