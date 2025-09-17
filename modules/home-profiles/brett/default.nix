{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      home.username = "Brett";
      home.stateVersion = "25.11";
    };
}
