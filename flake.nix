{
  description = "Apika's Config for NixOS";

  outputs = inputs @ {amix, ...}:
    import amix {
      inherit inputs;
      hmFlake = inputs.hm;

      pkgsConfig = {
        allowUnfree = true;
      };

      profiles = ./amix-profiles;
      modules = ./amix-modules;

      overlays = ./overlays;
      packages = ./pkgs;

      flakeSystems = ["x86_64-linux"];
      forFlake = system: pkgs: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            nixd
            git
            ripgrep
          ];
        };
      };
    };

  inputs = {
    amix.url = "./amix";

    # global, so they can be `.follow`ed
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-std.url = "github:chessai/nix-std";

    flake-compat.url = "github:edolstra/flake-compat";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # rest of inputs, alphabetical order

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

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };
}
