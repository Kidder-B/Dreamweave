{ inputs, ... }:
{
  imports = with inputs.flake-file.flakeModules; [
    allfollow
  ];
  flake-file.prune-lock = {
    enable = false;
  };
}
