{ inputs, ... }:
let
  inherit (inputs.self.lib.clan) mkTaggedService;
  fragment = mkTaggedService "hyprland" (
    with inputs.self.modules.nixos;
    [
      hyprland
      waybar
    ]
  );

  clan = {
    modules = fragment.modules // {
      hyprland = (fragment.modules."hyprland" or { }) // {
        roles.nvidia = { };
        roles.nvidia.perInstance = {
          nixosModule = {
            boot.kernelParams = [
              "nvidia-drm.modeset=1"
              "nouveau.modeset=0"
            ];
          };
        };
      };
    };

    inventory.instances = fragment.instances // {
      "hyprland" = (fragment.instances."hyprland" or { }) // {
        roles.nvidia.tags."nvidia" = { };
      };
    };
  };
in
{
  inherit clan;
}
