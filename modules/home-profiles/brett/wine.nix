{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # winetricks (all versions)
        winetricks

        # native wayland support (unstable)
        wineWowPackages.waylandFull
      ];
    };
}
