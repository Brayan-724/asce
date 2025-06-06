{pkgs, ...}: {
  imports = [
    ./base

    ./desktop/cursor.nix
    ./desktop/eww
    ./desktop/leftwm
    ./desktop/sway
    ./editor/neovim
    ./editor/vscode
    ./terminal/foot
    ./terminal/kitty
    ./terminal/rio
    ./terminal/gadgets/gitui.nix
    ./terminal/gadgets/zoxide.nix
    ./terminal/gadgets/zellij.nix
    ./terminal/shell/nushell
    ./theme/picom.nix
  ];

  home.packages = with pkgs; [
    fenix.stable.toolchain
  ];
}
