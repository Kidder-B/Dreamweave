{ inputs, ... }:
let
inherit (inputs.self.lib.clan) mkService;
clan = mkService "unfree" (with inputs.self.modules.nixos; [ unfree ]);
in
{
 inherit clan;
 }
