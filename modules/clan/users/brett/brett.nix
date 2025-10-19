{
  clan.inventory.instances = {
    user-brett = {
      module = {
        name = "dreamweave-user";
        input = "self";
      };
      roles.default.tags."brett" = { };
      roles.default.settings = {
        user = "Brett";
        prompt = true;
        groups = [
          "wheel"
          "networkmanager"
          "video"
          "input"
        ];
        share = true;
      };
    };
  };
}
