{ inputs, ... }:
let
  clan.inventory.instances = {
    brett-user = {

      module.name = "users";

      roles.default.tags.all = { };

      roles.default.settings = {
        user = "Brett";
        groups = [
          "wheel" # Allow using 'sudo'
          "networkmanager" # Allows to manage network connections.
          "video" # Allows to access video devices.
          "input" # Allows to access input devices.
        ];
      };
      roles.default.extraModules = [
        inputs.self.modules.nixos."Brett"
      ];
    };
  };
in
{
  inherit clan;
}
