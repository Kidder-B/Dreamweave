{ inputs, ... }:
let
  inherit (inputs.self.lib.clan) mkTaggedService;

  fragment = mkTaggedService "physical-machine" (
    with inputs.self.modules.nixos;

    [
      fish
      all-firmware
      git
      tree
      fonts
      emacs
      ripgrep
      fd
      unzip
      glib
      wlroots
      wayland
      desktop-portal
      polkit
    ]

  );

  clan.modules = fragment.modules;
  clan.inventory.instances = fragment.instances;
in
{
  inherit clan;
}
