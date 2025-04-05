{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: {
  xsession.enable = lib.mkDefault config.wayland.windowManager.sway.enable;

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;

    extraConfig = lib.concatStringsSep "\n" [];

    config = lib.mkOptionDefault {
      # Remove the titlebar in stacked/tabbed layouts
      fonts.size = 0.1;

      terminal = "${pkgs.foot}/bin/foot";
      menu = "${pkgs.fuzzel}/bin/fuzzel";

      defaultWorkspace = "workspace number 1";

      # Super
      modifier = "Mod4";

      # (Neo)vim move
      left = "h";
      down = "j";
      up = "k";
      right = "l";

      assigns = {
        "4: Discord" = [{ title = ".*Discord"; }];
      };

      startup = [
        { command = "discord"; }
        { command = "firefox"; }
      ];

      gaps = {
        outer = 7;
        inner = 3;
        smartBorders = "on";
      };

      # Use global xkb configs
      input."*" = with osConfig.services.xserver; {
        xkb_layout = xkb.layout;
        xkb_variant = xkb.variant;
        xkb_options = xkb.options;
      };

      # Use touchpad
      input."type:touchpad" = {
        tap = "enabled";
        natural_scroll = "enabled";
      };

      keybindings = let
        cfg = config.wayland.windowManager.sway.config;
      in
        lib.mkOptionDefault {
          "${cfg.modifier}+Return" = "exec ${cfg.terminal}";
          "${cfg.modifier}+Shift+q" = "kill";
          "${cfg.modifier}+d" = "exec ${cfg.menu}";
        };

      # Wallpaper
      output."*".bg = "${../../../wallpapers/ZeroTwo-DarkSalmon.jpg} fill";

      output."HDMI-A-1" = {
        pos = "0 1920";
        mode = "1280x1024@60Hz";
        transform = "270";
      };
      output."ePD-1" = {
        pos = "0 0";
        mode = "1920x1080@60Hz";
      };

      window = {
        titlebar = false;
        hideEdgeBorders = "both";
        commands = let for_window = criteria: command: {inherit criteria command;}; in [
          (for_window { shell = "xwayland"; } ''title_format "[XWayland] %title"'')
          (for_window { all = true; } ''opacity 0.8'')
          (for_window { all = true; } ''border none'')
          (for_window { all = true; } ''blur enable'')
          (for_window { all = true; } ''blur_radius 1'')
          (for_window { all = true; } ''corner_radius 12'')
        ];
      };
    };
  };
}
