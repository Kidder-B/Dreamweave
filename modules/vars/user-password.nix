{
  flake.modules.nixos.user-password =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      clan.core.vars.generators."user-password" = {
        share = false;
        files."user-password-hash".neededFor = "users";
        files."user-password-hash".restartUnits =
          lib.optional (config.services.userborn.enable) "userborn.service";
        files."user-password".secret = true; # plain password is secret
        files."user-password-hash".secret = true;
        runtimeInputs = [
          pkgs.coreutils
          pkgs.xkcdpass
          pkgs.mkpasswd
        ];

        script = ''
          # generate a 4-word xkcd-style password and write it (no newline)
          xkcdpass --numwords 4 --delimiter - --count 1 | tr -d "\n" > "$out"/user-password
          # create hashed password for users.*.hashedPasswordFile
          mkpasswd -s -m sha-512 < "$out"/user-password | tr -d "\n" > "$out"/user-password-hash
        '';
      };
    };

}
