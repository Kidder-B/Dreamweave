{
  flake.modules.nixos."Brett" = {pkgs, ...}: {
    users.users."Brett".shell = pkgs.fish;
  };
}
