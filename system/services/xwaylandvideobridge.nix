{
  pkgs,
  lib,
  ...
}: let
  isWayland = true;
in {
  systemd.user.services = lib.mkIf isWayland {
    xwaylandvideobridge = {
      Unit = {
        Description = "Tool to make it easy to stream wayland windows and screens to existing applications running under Xwayland";
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.xwaylandvideobridge}/bin/xwaylandvideobridge";
        Restart = "on-failure";
      };

      wantedBy = ["default.target"];
    };
  };
}
