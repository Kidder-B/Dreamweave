{
  flake.modules.nixos.wlroots =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        wlroots
      ];
    };
}
