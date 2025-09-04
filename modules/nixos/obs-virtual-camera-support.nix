let
  flake.modules.nixos.obs-virtual-camera-support =
    { config, ... }:
    {
      # OBS Virtual camera support
      boot.extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
      ];
      boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
      security.polkit.enable = true;
    };
in
{
  inherit flake;
}
