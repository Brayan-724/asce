{amixShells, ...}: {
  system = "x86_64-linux";
  hardware-configuration = ./hardware-configuration.nix;
  extraNixos = ./nixos.nix;

  user = {
    username = "apika";
  };

  shell = amixShells.nushell {
    prompt = "starship";
  };

  git.enable = true;

  nh = {
    enable = true;
    path = "/home/apika/dotfiles";
  };

  zellij.enable = true;
}
