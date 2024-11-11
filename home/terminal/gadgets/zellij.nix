{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    settings = {
      default_layout = "compact";
      default_shell = "${pkgs.nushell}/bin/nu";
      pane_frames = false;
    };
  };
}
