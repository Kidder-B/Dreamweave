{
  flake.modules.homeManager."Brett" =
    {
      pkgs,
      ...
    }:
    {
      home.pointerCursor = {
        enable = true;

        package = pkgs.phinger-cursors;
        name = "phinger-cursors-dark";
        size = 24;

        # Desktops
        hyprcursor.enable = true;
        gtk.enable = true;
        x11.enable = true;
      };
    };
}
