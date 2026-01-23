{
  flake.modules.homeManager."Brett" =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
        godot-mono
      ];
    };
}
