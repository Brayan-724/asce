{
  description = "Apika's Config for NixOS";

  outputs = inputs @ {
    self,
    nixpkgs,
    hm,
    ...
  }: let
    hostName = "asce";
    system = "x86_64-linux";
    systems = ["x86_64-linux"];

    forEachSystem = nixpkgs.lib.genAttrs systems;
    selfPackages = forEachSystem (
      system:
        import ./pkgs {pkgs = import nixpkgs {inherit system;};}
    );

    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages = selfPackages;

    nixosConfigurations = {
      asce = inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;

          overlays = import ./overlays/default.nix inputs;

          config = {
            allowUnfree = true;
          };
        };

        specialArgs = {
          inherit inputs system;

          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit system;

            config = {
              allowUnfree = true;
            };
          };

          packages = selfPackages.${system};
        };

        modules = [
          ./system

          inputs.agenix.nixosModules.default

          ./profiles/host.nix
          ./profiles/${hostName}/host.nix

          hm.nixosModules.home-manager
          ./profiles/${hostName}/home.nix
        ];
      };
    };

    devShells.${system} = {
      default = pkgs.mkShell {
        packages = [pkgs.alejandra pkgs.nil pkgs.git pkgs.ripgrep];
        name = "nixland";
        DIRENV_LOG_FORMAT = "";
      };
    };
  };

  inputs = {
    # global, so they can be `.follow`ed
    systems.url = "github:nix-systems/default-linux";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-std.url = "github:chessai/nix-std";

    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # rest of inputs, alphabetical order

    agenix.url = "github:ryantm/agenix";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Configuration Manager
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
    };

    # Palette Manager
    matugen = {
      url = "github:InioX/matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Index Updated
    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    simplemoji = {
      url = "github:SergioRibera/simplemoji";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    sss = {
      url = "github:SergioRibera/sss";
      # inputs.nixpkgs.follows = "nixpkgs";
      # inputs.fenix.follows = "fenix";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  nixConfig = {
    substituters = [
      # high priority since it's almost always used
      "https://cache.nixos.org?priority=10"
      "https://fufexan.cachix.org"
      "https://helix.cachix.org"
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://fortuneteller2k.cachix.org"
      "https://cosmic.cachix.org/"
      "https://hyprland.cachix.org"
      "https://noctalia.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "fufexan.cachix.org-1:LwCDjCJNJQf5XD2BV+yamQIMZfcKWR9ISIFy5curUsY="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
#
# {
#   description = "Apika's Config for NixOS";
#
#   outputs = inputs @ {amix, ...}:
#     import amix {
#       inherit inputs;
#       hmFlake = inputs.hm;
#
#       pkgsConfig = {
#         allowUnfree = true;
#       };
#
#       profiles = ./amix-profiles;
#       modules = import ./amix-modules;
#
#       overlays = ./overlays;
#       packages = ./pkgs;
#
#       flakeSystems = ["x86_64-linux"];
#       forFlake = system: pkgs: {
#         devShells.default = pkgs.mkShell {
#           packages = with pkgs; [
#             alejandra
#             nixd
#             git
#             ripgrep
#           ];
#         };
#       };
#     };
#
#   inputs = {
#     amix.url = "./amix";
#
#     # global, so they can be `.follow`ed
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#     nix-std.url = "github:chessai/nix-std";
#
#     flake-compat.url = "github:edolstra/flake-compat";
#     flake-utils.url = "github:numtide/flake-utils";
#     flake-parts.url = "github:hercules-ci/flake-parts";
#
#     # rest of inputs, alphabetical order
#
#     fenix.url = "github:nix-community/fenix";
#
#     firefox-addons = {
#       url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#
#     # Configuration Manager
#     hm = {
#       url = "github:nix-community/home-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#
#     # Palette Manager
#     matugen = {
#       url = "github:InioX/matugen";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#
#     # Nix Index Updated
#     nix-index-db = {
#       url = "github:nix-community/nix-index-database";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#
#     nix-vscode-extensions = {
#       url = "github:nix-community/nix-vscode-extensions";
#       inputs.nixpkgs.follows = "nixpkgs";
#       inputs.flake-utils.follows = "flake-utils";
#     };
#
#     zen-browser.url = "github:MarceColl/zen-browser-flake";
#   };
# }

