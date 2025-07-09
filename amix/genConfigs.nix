config @ {profiles, ...}: let
  amixLib = import ./lib.nix;

  inherit (builtins) attrNames attrValues catAttrs elem getAttr hasAttr head listToAttrs length concatMap mapAttrs;
  inherit (amixLib) attrsToList deepForce filterAttrs forceList getPkgs mapCompactAttrs pipe optionalFieldAttr optionalFieldList reduceMergeAttrs resolveConfig;

  modulesPkgs = import ./module.nix config;
  genConfig = profileName: _profile: let
    profile = _profile.value {inherit pkgs amixLib amixShells;};

    pkgs = getPkgs config profile.system {config = optionalFieldAttr "pkgsConfig" profile;};

    amixTypes = import ./types.nix pkgs;

    user = profile.user;

    commonModuleDef = {
      inherit pkgs amixLib amixTypes profileName;
      lib = pkgs.lib;
    };

    modulesDefs =
      pipe [
        (mapAttrs (_: f: f (commonModuleDef // {config = throw "Should not access to config in options";})))
      ]
      modulesPkgs;

    getModuleDef = field: mapCompactAttrs field modulesDefs;

    modulesAmix = getModuleDef "amix";

    modulesOptions =
      getModuleDef "options";

    modulesOptionsExt =
      pipe [
        (mapAttrs (mod: v: let
          justEnables = attrNames (mapCompactAttrs "enable" v.options);
        in rec {
          enabledKey =
            if length justEnables == 0
            then null
            else if elem mod justEnables
            then mod
            else (head justEnables);
          hasEnabled = enabledKey != null;
        }))
      ]
      modulesOptions;

    modulesConfigs = let
      isEnabled = mod:
        if hasAttr mod modulesOptionsExt && modulesOptionsExt.${mod}.hasEnabled
        then userConfig.${modulesOptionsExt.${mod}.enabledKey}.enable
        else false;
    in
      pipe [
        (mapAttrs (mod: f:
          f (commonModuleDef
            // {
              config =
                userConfig
                // {
                  shell =
                    userConfig.shell
                    // {
                      aliases = modulesShellAliases;
                    };
                };
            })))
        (filterAttrs (mod: v: v.enable or (isEnabled mod)))
      ]
      modulesPkgs;

    modulesConfigsAmix = catAttrs "amix" (attrValues modulesConfigs);
    modulesConfigsHome = catAttrs "home" (attrValues modulesConfigs);
    modulesConfigsNixos = catAttrs "nixos" (attrValues modulesConfigs);

    modulesShellAliases = pipe [(catAttrs "aliases") reduceMergeAttrs] modulesConfigsAmix;

    amixShells =
      pipe [
        (mapAttrs (_: getAttr "amix"))
        (mapCompactAttrs "shell")
        attrsToList
        (concatMap ({value, ...}: attrsToList value.shell))
        listToAttrs
        (mapAttrs (name: v: v // {inherit name;}))
        (mapAttrs (name: v: v // {__functor = self: extra: self // extra;}))
      ]
      modulesAmix;

    userConfig =
      (pkgs.lib.evalModules {
        modules =
          [
            {
              options.shell = {
                name = amixTypes.string;
                pkg = amixTypes.pkg;
                path = amixTypes.string;
                __functor = amixTypes.__functor;
              };
            }
          ]
          ++ (attrValues modulesOptions)
          ++ [
            (removeAttrs profile ["system" "hardware-configuration" "extraNixos" "user"])
          ];
      })
      .config;
  in
    #
    assert profile ? "system" || abort "Should set system in amix profile";
    assert profile ? "hardware-configuration" || abort "Should set hardware-configurations in amix profile";
    assert profile ? "user" || abort "Should set user in amix profile";
    #
      (config.pkgsLib.nixosSystem {
        inherit pkgs;

        modules =
          [
            profile.hardware-configuration
            config.hmFlake.nixosModules.home-manager
            {
              users.users.${user.username} = {
                shell = userConfig.shell.pkg;

                description = user.username;
                isNormalUser = true;
                extraGroups = [
                  "wheel"
                ];
              };

              system.stateVersion = "25.05";
            }
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                extraSpecialArgs = {};

                users.${user.username} = {
                  imports = modulesConfigsHome ++ pipe [(optionalFieldList "extraHome") forceList] profile;

                  home.stateVersion = "25.05";
                };
              };
            }
          ]
          ++ modulesConfigsNixos
          ++ pipe [(optionalFieldList "extraNixos") forceList] profile;
      });
in
  mapAttrs genConfig (resolveConfig "profile" profiles)
