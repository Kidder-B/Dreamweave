{ inputs, ... }:
let
      nvidia-tools = {
        module.name = "importer";
        roles.default.tags."nvidia" = { };
        roles.default.extraModules = [
	  {
	    imports = with inputs.self.modules.nixos [ 
	      nvidia
	    ];
	  }
	];
      };
in
{
  clan.inventory.instances = {
    nvidia-tools
  };
}
