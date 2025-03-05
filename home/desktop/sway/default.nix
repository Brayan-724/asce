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

    config = lib.mkOptionDefault {
      terminal = "${pkgs.foot}/bin/foot";
      menu = "${pkgs.fuzzel}/bin/fuzzel";

      # Super
      modifier = "Mod4";

      # (Neo)vim move
      left = "h";
      down = "j";
      up = "k";
      right = "l";

      keybindings = let
        cfg = config.wayland.windowManager.sway.config;
      in
        lib.mkOptionDefault {
          "${cfg.modifier}+Return" = "exec ${cfg.terminal}";
          "${cfg.modifier}+Shift+q" = "kill";
          "${cfg.modifier}+d" = "exec ${cfg.menu}";
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

      # Wallpaper
      output."*".bg = "${../../../wallpapers/ZeroTwo-DarkSalmon.jpg} fill";

      window = {
        hideEdgeBorders = "smart";
        commands = [
          {
            command = ''title_format "[XWayland] %title"'';
            criteria.shell = "xwayland";
          }
        ];
      };
    };
  };
}
