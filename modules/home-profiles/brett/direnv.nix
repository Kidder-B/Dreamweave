{
flake.modules.homeManager."Brett" = {
  programs = {
    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };
  };
};
}
