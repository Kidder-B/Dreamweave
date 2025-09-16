{ inputs, ... }:
let
  self = inputs.self;
  inherit (self.lib.clan) mkTaggedService;
  fragment = mkTaggedService "all" (
    (with self.modules.homeManager; [ home-manager ])
  );

  clan.modules = fragment.modules;
  clan.inventory.instances = fragment.instances;
in
{
  inherit clan;
}
