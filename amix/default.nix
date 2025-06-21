{
  inputs,
  pkgsFlake ? inputs.nixpkgs,
  pkgsConfig ? {},
  hmFlake ? inputs.home-manager,
  ...
} @ _config: let
  inherit (builtins) foldl' map removeAttrs;
  inherit (import ./lib.nix) getPkgs mergeMap pipe optionalFieldAttr;

  config =
    _config
    // {
      inherit pkgsFlake pkgsConfig hmFlake;
      pkgsLib = pkgsFlake.lib;
    };

  genFlake = userFlake:
    (removeAttrs userFlake ["devShells" "packages" "system"])
    // {
      devShells.${userFlake.system} = optionalFieldAttr "devShells" userFlake;
      packages.${userFlake.system} = optionalFieldAttr "packages" userFlake;
    };

  userFlake =
    if _config ? "forFlake"
    then
      pipe [
        (map (system: {inherit system;}))
        (map (mergeMap ({system}: (_config.forFlake system (getPkgs config system {})))))
        (map genFlake)
        (foldl' (pkgsFlake.lib.recursiveUpdate) {})
      ]
      _config.flakeSystems
    else {};
in
  #
  assert _config ? "inputs" || abort "Should set inputs in amix config";
  assert _config ? "profiles" || abort "Should set profiles in amix config";
  assert _config ? "modules" || abort "Should set modules in amix config";
  assert (_config ? "forFlake" -> _config ? "flakeSystems") || abort "Should set flakeSystems in amix config if want forFlake";
  #
    userFlake
    // {
      nixosConfigurations = import ./genConfigs.nix config;
    }
