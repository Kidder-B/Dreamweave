{ inputs, ... }:
let
  mkService = inputs.self.lib.clan.mkService;
  modules = with inputs.self.modules.nixos; [ unfree ];
in
mkService "unfree" { imports = modules; }
