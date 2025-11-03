{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      checks.default = pkgs.testers.runNixOSTest {
        imports = [
          inputs.home-manager.nixosModules.home-manager
        ];
        name = "godot-exists-test";
        nodes.machine = {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            users.alice = {
              imports = [ inputs.self.modules.homeManager."godot" ];
            };
          };
          users.users.alice = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
          };
        };

        testScript = ''
          machine.wait_for_unit("default.target")
          machine.succeed("su -- alice -c 'which godot'")
          machine.fail("su -- root -c 'which godot'")
        '';
      };
    };
}
