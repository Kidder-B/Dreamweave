{
  flake.modules.nixos.neovim = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
