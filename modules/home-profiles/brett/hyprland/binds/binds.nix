{
  flake.modules.homeManager."Brett" =
    { osConfig, ... }:
    {
      wayland.windowManager.hyprland.settings = {
        binds = [
          "mod, Return, exec, fish"
        ];

      };
    };
}
