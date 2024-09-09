{pkgs, ...}: {
  imports = [
    ./base
    ./theme/picom.nix

    ./editor/neovim
    ./editor/vscode

    ./terminal/shell/nushell
    ./terminal/kitty/default.nix
    ./terminal/gadgets/zoxide.nix
    ./terminal/gadgets/zellij.nix
  ];

  home.packages = with pkgs; [
    fenix.stable.toolchain
  ];
}
