{ lib, ... }:
let
  flake.lib.clan = {
    inherit mkTag;
  };

  mkTag =
    name:
    {
      "${name}" = {
        module.input = "self";
        module.name = name;
        roles.default.tags.${name} = {};
      };
    };
in
{
  inherit flake;
}

