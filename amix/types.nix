{lib, ...}: let
  mkOption = def:
    lib.mkOption def
    // {
      __functor = self: extends:
        if builtins.typeOf extends == "set" && !extends ? outPath
        then mkOption (def // extends)
        else mkOption (def // {default = extends;});
    };
in {
  enable = mkOption {
    default = false;
    type = lib.types.bool;
  };

  string = mkOption {
    type = lib.types.str;
  };

  pkg = mkOption {
    type = lib.types.package;
  };

  __functor = mkOption {
    type = lib.types.nullOr lib.types.unspecified;
    default = null;
  };
}
