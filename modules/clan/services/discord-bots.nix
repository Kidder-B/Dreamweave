{ inputs, ... }:
let
  inherit (inputs.self.lib.clan) mkTaggedService;

  fragment = mkTaggedService "discord-bots" (
    with inputs.self.modules.nixos;
    [
      agdgDiscordBot
      eventsBot
    ]

  );

  clan.modules = fragment.modules;
  clan.inventory.instances = fragment.instances;
in
{
  inherit clan;
}
