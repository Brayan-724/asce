{modules, ...}: let
  amixLib = import ./lib.nix;

  inherit (builtins) listToAttrs map mapAttrs;
  inherit (amixLib) attrsToList pipe removeSuffix resolveConfig const toFunction;
in
  pipe [
    (resolveConfig "module")
    (mapAttrs (const toFunction))
    attrsToList
    (map ({
      name,
      value,
    }: {
      inherit value;
      name = removeSuffix ".nix" name;
    }))
    listToAttrs
  ]
  modules
