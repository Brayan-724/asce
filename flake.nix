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

    overlays.default = import ./overlays/awesome.nix;

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

    androidpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    fenix.url = "github:nix-community/fenix";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Configuration Manager
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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

    # Wine, Proton, Rocket League, Osu!, Star Citizen, Viper (Titan Fall 2)
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.flake-parts.follows = "flake-parts";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };
}
