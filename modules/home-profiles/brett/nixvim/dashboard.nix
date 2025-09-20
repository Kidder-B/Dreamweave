{ lib, ... }:

{
  flake.modules.nixvim."Brett" = {
    plugins = {
      mini-starter = {
        enable = lib.mkForce false;
      };
    };
  };
}
