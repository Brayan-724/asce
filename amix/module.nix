{modules, ...}: let
  amixLib = import ./lib.nix;

  inherit (amixLib) pipe resolveConfig;
in
  pipe [
    (resolveConfig "module")
    builtins.attrValues
    amixLib.inspect
  ]
  modules
