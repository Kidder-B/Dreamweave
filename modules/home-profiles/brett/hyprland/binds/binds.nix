{
  flake.modules.homeManager."Brett" =
    { ... }:
    {
      wayland.windowManager.hyprland.settings = {
        binds = [
          "$mod, Q, exec, fish"
        ];

      };
    };
}
