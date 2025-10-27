{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jjui
      ];
      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "Brett Kidder";
            email = "30retton@gmail.com";
          };
        };
      };
    };
}
