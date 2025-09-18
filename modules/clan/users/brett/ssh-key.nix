{ config, pkgs, ... }: {
  clan.core.vars.generators.brett-ssh-key = {
    share = true; # Omit if you want unique keys per machine
    files."id_ed25519" = {
      secret = true;
      owner = "Brett";
      group = "Brett";
      mode = "0600";
    };
    files."id_ed25519.pub" = {
      secret = false;
      owner = "Brett";
      group = "Brett";
      mode = "0644";
    };
    runtimeInputs = [ pkgs.openssh ];
    script = ''
      ssh-keygen -t ed25519 -N "" -f $out/id_ed25519
    '';
  };
}
