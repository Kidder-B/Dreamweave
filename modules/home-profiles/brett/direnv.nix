{
flake.modules.homeManager."Brett" = {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
};
}
