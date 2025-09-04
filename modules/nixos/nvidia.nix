{
  # Source: https://github.com/vic/vix/blob/5075c9ca6484274f228e350b51ee98e29c2734a4/modules/community/features/nvidia.nix#L3
  flake.modules.nixos.nvidia =
    { config, ... }:
    {
      boot.initrd.kernelModules = [ "nvidia" ];
      boot.blacklistedKernelModules = [ "nouveau" ];
      boot.extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.graphics.enable = true;
      hardware.nvidia = {
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
        powerManagement.enable = true;
        powerManagement.finegrained = false;
        modesetting.enable = true;
      };
    };
}
