{
  flake.modules.homeManager."godot" =
    { pkgs, config, ... }:
    {
      imports = with config.flake.modules.homeManager; [
        godot
      ];
      home.packages = with pkgs; [
        godot
      ];
    };
}
