{ inputs, ... }:
let
  inherit (inputs.self.lib.clan) mkTaggedService;

  fragment = mkTaggedService "all" (
    with inputs.self.modules.nixos;

    [
      fish
      network-manager
      all-firmware
      git
      neovim
      shared-vars
    ]

  );

  clan.modules = fragment.modules;
  clan.inventory.instances = fragment.instances;
in
{
  inherit clan;
}
