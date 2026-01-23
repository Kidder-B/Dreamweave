{
  flake.modules.homeManager."godot" =
    { config, ... }:
    {
      imports = with config.flake.modules.homeManager; [
        godot
      ];
    };
}
