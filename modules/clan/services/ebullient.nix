{ inputs, ... }:
let
  inherit (inputs.self.lib.clan) mkTaggedService;
  fragment = mkTaggedService "ebullient" (with inputs.self.modules.nixos; [ ebullient ]);
  clan.modules = fragment.modules;
  clan.inventory.instances = fragment.instances;
in
{
  inherit clan;
}
