{
  flake.modules.nixvim."Brett" = {
    plugins = {
      copilot-lsp = {
        # enable = config.khanelivim.ai.provider == "copilot";
        enable = false;
      };
    };
  };
}
