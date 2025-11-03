{ config, ... }:
{
  flake.modules.homeManager."Brett" = {
    imports = with config.flake.modules.homeManager; [
      godot
    ];
  };
}
