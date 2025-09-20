{ inputs, ... }:
let
  inherit (inputs.self.lib.clan) mkTaggedService;
  fragment = mkTaggedService "client" (with inputs.self.modules.nixos; [ network-manager ]);
  clan.modules = fragment.modules;
  clan.inventory.instances = fragment.instances;
in
{
  inherit clan;
}
