{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        shellcheck
      ];
    };
}
