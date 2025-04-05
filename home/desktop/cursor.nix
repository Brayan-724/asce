{pkgs, ...}: {
  home.pointerCursor.name = "phinger-cursors-light";
  home.pointerCursor.package = pkgs.phinger-cursors;
  gtk.cursorTheme.name = "phinger-cursors-light";
  gtk.cursorTheme.package = pkgs.phinger-cursors;
}
