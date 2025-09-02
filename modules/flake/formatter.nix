{
  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs = {
      nixfmt.enable = true;
      nixfmt.excludes = [ ".direnv" ];
      deadnix.enable = true;
    };
    settings = {
      global.excludes = [
        "vars/**"
        "sops/**"
        "machines/**"
      ];
    };
  };
}
