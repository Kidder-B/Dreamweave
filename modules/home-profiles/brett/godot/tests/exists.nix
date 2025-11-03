{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      checks.default = {
        name = "minimal-test";
        nodes.machine = {
          users.users.alice = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            packages = with pkgs; [
              firefox
              tree
            ];
          };
        };

        testScript = ''
          machine.wait_for_unit("default.target")
          machine.succeed("su -- alice -c 'which firefox'")
          machine.fail("su -- root -c 'which firefox'")
        '';
      };
    };
}
