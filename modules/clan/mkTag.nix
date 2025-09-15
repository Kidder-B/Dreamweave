{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;

    tagsDir = ./tags;

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
        roles.default.extraModules = [ (toString tagsDir + "/" + filename) ];
      };
    };

  allInstances = lib.mapAttrsToList mkTagInstance tagFiles;

  mergedInstances = lib.foldl' (acc: inst: acc // inst) { } allInstances;
in
{
  clan.inventory.instances = mergedInstances;
}
