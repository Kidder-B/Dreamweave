{
  flake.modules.nixvim."Brett" =
    { lib, ... }:
    {
      plugins.mini-starter = {
        settings = {
          content_hooks = {
            "__unkeyed-1.adding_bullet".__raw = lib.mkForce ''require('mini.starter').gen_hook.bullet(" ")'';
          };
        };
      };
    };
}
