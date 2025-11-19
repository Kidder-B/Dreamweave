{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        unzip
      ];
      programs.emacs = {
        enable = true;
        package = pkgs.emacs;
      };
    };
}
