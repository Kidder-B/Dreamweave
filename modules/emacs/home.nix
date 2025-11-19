{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # For use with TLDR
        unzip
      ];
      programs.emacs = {
        enable = true;
        package = pkgs.emacs;
      };
    };
}
