{
  clan.inventory.instances = {
    user-brett = {
      module = {
        name = "dreamweave-users";
        input = "self";
      };
      roles.default.tags.all = { };
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
}
