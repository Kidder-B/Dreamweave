{ inputs, ... }:
let
  inherit (inputs.self.lib.clan) mkTaggedService;
  fragment = mkTaggedService "trance" (
    with inputs.self.modules.nixos;
    [
      trance
      emacs
    ]
  );
  clan.modules = fragment.modules;
  clan.inventory.instances = fragment.instances;
in
{
  inherit clan;
}
