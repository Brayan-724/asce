{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./base

    ./desktop/cursor.nix
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

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    fenix.complete.toolchain
  ];

  programs.sss = {
    enable = true;
    code.enable = true;
  };

  xdg.enable = true;

  programs.ssh = {
    enable = true;
    # matchBlocks = {
    #   "ovh-hackalakin" = {
    #     hostname = builtins.readFile config.age.secrets.apika.path;
    #     user = "apika";
    #     identityFile = config.home + "/.ssh/ovh-hackalakin/ssh-key-nophrase";
    #   };
    # };

    enableDefaultConfig = false;

    # Default Config
    settings."*" = {
      ForwardAgent = true;
      AddKeysToAgent = "yes";
      Compression = false;
      ServerAliveInterval = 60;
      ServerAliveCountMax = 3;
      HashKnownHosts = false;
      UserKnownHostsFile = "~/.ssh/known_hosts";
      ControlMaster = "no";
      ControlPath = "~/.ssh/master-%r@%n:%p";
      ControlPersist = "no";
    };

    settings."git.apika.me" = {
      hostname = "git.apika.me";
      User = "git";
      Port = "10002";
      PreferredAuthentications = "publickey";
      IdentityFile = "~/.ssh/apika.key";
      IdentitiesOnly = "yes";
    };
  };

  services.hyprpolkitagent.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    # use NixOs module
    package = null;
    portalPackage = null;
    configType = "lua";

    plugins = [inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors];

    extraLuaFiles.config.content = ./desktop/hyprland.lua;

    settings = {
      bind = let
        luaValue = str: lib.generators.toLua {} str;
        mkBindC = cfg: k: cmd: {
          _args = [
            k
            (lib.generators.mkLuaInline cmd)
            cfg
          ];
        };
        mkBind = mkBindC {};
        mkBindM = mkBindC {mouse = true;};

        exec = cmd: "hl.dsp.exec_cmd(${luaValue cmd})";
        focus = direction: "hl.dsp.focus(${luaValue {inherit direction;}})";
        workspace = workspace: "hl.dsp.focus(${luaValue {inherit workspace;}})";
        windowMove = direction: "hl.dsp.window.move(${luaValue {inherit direction;}})";
        windowDrag = "hl.dsp.window.drag()";
        windowResize = "hl.dsp.window.resize()";
        killActive = "hl.dsp.window.close()";
        fullscreen = "hl.dsp.window.fullscreen({ action = \"toggle\"})";
        toggleFloating = "hl.dsp.window.float({ action = \"toggle\"})";
        forceKillActive = "hl.dsp.window.kill()";
        windowWorkspace = workspace: "hl.dsp.window.move(${luaValue {inherit workspace;}})";

        swapActiveWorkspaces = "hl.dsp.workspace.swap_monitors({monitor1 = 0; monitor2 = 1;})";

        wl-copy = "${pkgs.wl-clipboard-rs}/bin/wl-copy";
      in
        [
          (mkBind "SUPER + Return" (exec "${pkgs.foot}/bin/foot"))
          (mkBind "SUPER + P" (exec "${pkgs.sherlock-launcher}/bin/sherlock"))
          (mkBind "SUPER + SHIFT + P" (exec "${pkgs.flameshot}/bin/flameshot gui"))
          (mkBind "SUPER + S" (exec "${pkgs.sss}/bin/sss --area \"$(${pkgs.slurp}/bin/slurp -d)\" -o raw | ${wl-copy}"))
          # "SUPER, Period, exec, ${pkgs.simplemoji}/bin/simplemoji -t medium-light -soc '${wl-copy}'"

          # Discord keybind
          # ", mouse:276, sendshortcut, CTRL_SHIFT, M, class:^(discord)$"

          # Window bindings
          (mkBind "SUPER + Q" killActive)
          (mkBind "SUPER + SHIFT + Q" forceKillActive)
          (mkBind "SUPER + F" toggleFloating)
          (mkBind "SUPER + D" fullscreen)
          (mkBind "SUPER + O" swapActiveWorkspaces)

          (mkBind "SUPER + H" (focus "left"))
          (mkBind "SUPER + J" (focus "down"))
          (mkBind "SUPER + K" (focus "up"))
          (mkBind "SUPER + L" (focus "right"))

          (mkBind "SUPER + SHIFT + H" (windowMove "left"))
          (mkBind "SUPER + SHIFT + J" (windowMove "down"))
          (mkBind "SUPER + SHIFT + K" (windowMove "up"))
          (mkBind "SUPER + SHIFT + L" (windowMove "right"))

          (mkBindM "SUPER + mouse:272" windowDrag)
          (mkBindM "SUPER + mouse:273" windowResize)
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                (mkBind "SUPER + ${toString i}" (workspace ws))
                (mkBind "SUPER + SHIFT + ${toString i}" (windowWorkspace ws))
              ]
            )
            10)
        );
      config = {
        binds = {
          drag_threshold = 10;
        };

        decoration = {
          rounding = 5;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
          enforce_permissions = false;
        };

        input = {
          kb_layout = "us";
          kb_variant = "altgr-intl";
          kb_options = "grp:alt_space_toggle";

          mouse_refocus = false;

          touchpad = {
            disable_while_typing = true;
            natural_scroll = true;
            middle_button_emulation = true;
          };
        };

        plugin.dynamic_cursors = {
          enabled = true;
          mode = "rotate";
        };
      };

      monitor = [
        {
          output = "eDP-1";
          mode = "1920x1080@60";
          position = "0x0";
          scale = 1;
        }
        {
          output = "HDMI-A-1";
          mode = "1280x1024@60";
          position = "1920x0";
          scale = 1;
          transform = 1;
        }
      ];
    };
  };
}
