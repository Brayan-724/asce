{lib, ...}: {
  programs.gitui = {
    enable = true;

    theme = let
      Rgb = r: g: b: "Rgb(${r}, ${g}, ${b})";
      Indexed = index: "Indexed(${index})";
      Reset = "Reset";
      Black = "Black";
      Red = "Red";
      Green = "Green";
      Yellow = "Yellow";
      Blue = "Blue";
      Magenta = "Magenta";
      Cyan = "Cyan";
      Gray = "Gray";
      DarkGray = "DarkGray";
      LightRed = "LightRed";
      LightGreen = "LightGreen";
      LightYellow = "LightYellow";
      LightBlue = "LightBlue";
      LightMagenta = "LightMagenta";
      LightCyan = "LightCyan";
      White = "White";

      attrs = {
        selected_tab = Reset;
        command_fg = White;
        selection_bg = Blue;
        selection_fg = White;
        cmdbar_bg = Blue;
        cmdbar_extra_lines_bg = Blue;
        disabled_fg = DarkGray;
        diff_line_add = Green;
        diff_line_delete = Red;
        diff_file_added = LightGreen;
        diff_file_removed = LightRed;
        diff_file_moved = LightMagenta;
        diff_file_modified = Yellow;
        commit_hash = Magenta;
        commit_time = LightCyan;
        commit_author = Green;
        danger_fg = Red;
        push_gauge_bg = Blue;
        push_gauge_fg = Reset;
        tag_fg = LightMagenta;
        branch_fg = LightYellow;
      };
    in ''
      (
        ${lib.strings.concatLines (lib.attrsets.mapAttrsToList (key: value: "${key}: ${value},") attrs)}
      )
    '';
  };
}
