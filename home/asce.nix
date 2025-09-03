{inputs, pkgs, config, ...}: {
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

  programs.sss = {
    enable = true;
    code.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # use NixOs module
    package = null;
    portalPackage = null;
  };

  programs.niri.settings = {
    spawn-at-startup = let
      makeCommand = command: {
        command = [command];
      };
    in [
      (makeCommand "${pkgs.xwayland-satellite}/bin/xwayland-satellite")
    ];

    input = {
      focus-follows-mouse.enable = true;
      keyboard = {
        xkb = {
          layout = "us";
          variant = "altgr-intl";
          options = "grp:alt_space_toggle";
        };
      };
    };
    
    outputs."eDP-1" = {
      mode.width = 1920;
      mode.height = 1080;
      mode.refresh = 60.;
      scale = 1.0;
      position.x = 0;
      position.y = 0;
      focus-at-startup = true;
    };

    outputs."HDMI-A-1" = {
      mode.width = 1280;
      mode.height = 1024;
      mode.refresh = 60.;
      scale = 1.0;
      transform.rotation = 90;
      position.x = 1920;
      position.y = 0;
    };

    binds = with config.lib.niri.actions; {
      "Mod+E".action = quit;

      "Mod+Return".action.spawn = "kitty";
      "Mod+Tab".action.spawn = "fuzzel";

      "Mod+S".action = screenshot-window { write-to-disk = false; };
      "Mod+Print".action = screenshot-window;
      "Mod+Shift+S".action = screenshot;
      
      "Mod+Shift+T".action = toggle-debug-tint;
      
      "Mod+W".action = close-window;
      "Mod+D".action = maximize-column;
      "Mod+F".action = toggle-window-floating;
      "Mod+Shift+F".action = fullscreen-window;

      "Mod+Comma".action = consume-window-into-column;
      "Mod+Semicolon".action = expel-window-from-column;

      "Mod+H".action = focus-column-or-monitor-left;
      "Mod+L".action = focus-column-or-monitor-right;
      "Mod+J".action = focus-window-or-workspace-down;
      "Mod+K".action = focus-window-or-workspace-up;
      
      "Mod+Shift+H".action = move-column-left-or-to-monitor-left;
      "Mod+Shift+L".action = move-column-right-or-to-monitor-right;
      "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
      "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
      
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      "Mod+WheelScrollDown" = {
        action = focus-workspace-down;
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action = focus-workspace-up;
        cooldown-ms = 150;
      };
    };
  };
}
