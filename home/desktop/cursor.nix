{pkgs, ...}: {
  pointerCursor.name = "catppuccin-mocha-mauve-cursors";
  pointerCursor.package = pkgs.catppuccin-cursors.mochaMauve;
  gtk.cursorTheme.name = "catppuccin-mocha-mauve-cursors";
  gtk.cursorTheme.package = pkgs.catppuccin-cursors.mochaMauve;
}
