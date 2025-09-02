{
  perSystem.treefmt.projectRootFile = "flake.nix";
  perSystem.treefmt.programs = {
    nixfmt.enable = true;
    nixfmt.excludes = [ ".direnv" "sops/*" "vars/*" "machines/*" ];
    deadnix.enable = true;
  };
}
