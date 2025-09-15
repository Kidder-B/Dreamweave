{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
    flakeRoot = ./.; # this points to the flake directory during evaluation

    tagsDir = "${flakeRoot}/tags";

    tagFiles = lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) (builtins.readDir tagsDir);

  mkTagInstance =
    filename: _:
    let
      tagName = lib.removeSuffix ".nix" filename;

      # all.nix -> base-settings, others -> tag-tools
      instanceName = if tagName == "all" then "base-settings" else "${tagName}-tools";
    in
    {
      ${instanceName} = {
        module.name = "importer";
        roles.default.tags.${tagName} = { };
        roles.default.extraModules = [ ./${filename} ];
      };
    };

  allInstances = lib.mapAttrsToList mkTagInstance tagFiles;

  mergedInstances = lib.foldl' (acc: inst: acc // inst) { } allInstances;
in
{
  clan.instances = mergedInstances;
}
