{
  description = "Apika's Config for NixOS";

  outputs = inputs @ {
    self,
    nixpkgs,
    hm,
    fenix,
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

    overlays.default = import ./overlays inputs;

    nixosConfigurations = {
      asce = inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;

          config = {
            allowUnfree = true;
          };
        };

        specialArgs = {
          inherit inputs system;

          packages = selfPackages.${system};
        };

        modules = [
          ./system

          {nixpkgs.overlays = [self.overlays.default fenix.overlays.default];}

          inputs.niri.nixosModules.niri

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

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };

    # Palette Manager
    matugen = {
      url = "github:InioX/matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri WM config
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    # Nix Index Updated
    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sss = {
      url = "github:SergioRibera/sss";
      # inputs.nixpkgs.follows = "nixpkgs";
      # inputs.fenix.follows = "fenix";
      inputs.flake-utils.follows = "flake-utils";
    };
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

