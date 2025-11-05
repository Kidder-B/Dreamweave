{
  flake.modules.nixvim."Brett" =
    { lib, ... }:
    {
      plugins = {
        copilot-lsp = {
          # enable = config.khanelivim.ai.provider == "copilot";
          enable = lib.mkForce false;
        };
      };
    };
}
