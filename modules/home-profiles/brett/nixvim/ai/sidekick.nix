{
  flake.modules.nixvim."Brett" =
    { lib, ... }:
    {
      config = {
        plugins = {
          sidekick = {
            enable = lib.mkForce false;
          };
        };
      };
    };
}
