{
  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs = {
      nixfmt.enable = true;
      nixfmt.excludes = [ ".direnv" ];
    };
    settings = {
      global.excludes = [
        "vars/**"
        "sops/**"
      ];
    };
  };
}
