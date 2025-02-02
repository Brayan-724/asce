{pkgs, ...}: {
  home.pointerCursor.name = "catppuccin-mocha-mauve-cursors";
  home.pointerCursor.package = pkgs.catppuccin-cursors.mochaMauve;
  gtk.cursorTheme.name = "catppuccin-mocha-mauve-cursors";
  gtk.cursorTheme.package = pkgs.catppuccin-cursors.mochaMauve;
}
