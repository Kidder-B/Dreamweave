{ inputs, ... }:
let
  inherit (inputs.self.lib.clan) mkTaggedService;

  fragment = mkTaggedService "all" (
    with inputs.self.modules.nixos;

    [
      shared-vars
      systemd-boot
    ]

  );

  clan.modules = fragment.modules;
  clan.inventory.instances = fragment.instances;
in
{
  inherit clan;
}
