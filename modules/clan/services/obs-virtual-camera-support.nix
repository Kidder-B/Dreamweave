{ inputs, ... }:
let
  inherit (inputs.self.lib.clan) mkTaggedService;
  fragment = mkTaggedService "obs-virtual-camera-support" (with inputs.self.modules.nixos; [ obs-virtual-camera-support ]);
  clan.modules = fragment.modules;
  clan.inventory.instances = fragment.instances;
in
{
  inherit clan;
}
