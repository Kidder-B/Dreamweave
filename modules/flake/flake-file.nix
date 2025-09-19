{ inputs, ... }:
{
  imports = with inputs.flake-file.flakeModules; [
    nix-auto-follow
  ];
  flake-file.prune-lock = {
    enable = true;
  };
}
