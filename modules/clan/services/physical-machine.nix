{ inputs, ... }:
let
  inherit (inputs.self.lib.clan) mkTaggedService;

  fragment = mkTaggedService "physical-machine" (
    with inputs.self.modules.nixos;

    [
      fish
      all-firmware
      git
      neovim
      tree
      fonts
      emacs
    ]

  );

  clan.modules = fragment.modules;
  clan.inventory.instances = fragment.instances;
in
{
  inherit clan;
}
