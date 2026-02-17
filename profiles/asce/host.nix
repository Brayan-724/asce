{
  inputs,
  pkgs,
  lib,
  packages,
  ...
}: {
  users.users.apika = {
    shell = pkgs.nushell;

    packages = with pkgs; [
      tree-sitter
      packages.kotlin-lsp
      jetbrains.idea-community-bin

      awscli2
      insomnia
      python3
      uv
      dbeaver-bin
      slack

      pavucontrol
      obsidian
      blender
      easyeffects
      bottom

      discord
      vesktop
      fd
      firefox
      flameshot
      fzf
      gh
      git
      gcc
      nautilus
      ripgrep
      xclip

      alejandra
      nixd

      deno
      typescript-language-server
      svelte-language-server
      vscode-langservers-extracted

      docker-compose
      nix-output-monitor
      ouch
      prismlauncher
      yazi

      # Gitea
      taplo
      tea
      git-credential-manager

      alacritty
      fuzzel
      swaylock
      cmake
      gnumake

      fuzzel
      prismlauncher

      wl-clipboard-rs
      wlx-overlay-s
      wayvr-dashboard
      figma-linux
    ];
  };

  programs.adb.enable = true;
  programs.alvr = {
    enable = false;
    openFirewall = true;
  };
  programs.nix-ld.enable = true;
  programs.obs-studio.enable = true;
  programs.obs-studio.enableVirtualCamera = true;
  programs.steam.enable = true;

  services.postgresql.enable = true;
  services.wivrn = {
    enable = true;
    openFirewall = true;

    # Write information to /etc/xdg/openxr/1/active_runtime.json, VR applications
    # will automatically read this and work with WiVRn (Note: This does not currently
    # apply for games run in Valve's Proton)
    defaultRuntime = true;

    # Run WiVRn as a systemd service on startup
    autoStart = true;

    # If you're running this with an nVidia GPU and want to use GPU Encoding (and don't otherwise have CUDA enabled system wide), you need to override the cudaSupport variable.
    package = pkgs.wivrn.override {cudaSupport = true;};

    config.json = {
      applications = [ pkgs.wlx-overlay-s pkgs.wayvr-dashboard ];
    };
  };

  services.displayManager.sddm = {
    enable = true;
    # wayland = true;
    theme = "catppuccin-mocha-mauve";
    package = pkgs.kdePackages.sddm;
  };

  services.xserver.desktopManager.gnome = {
    enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;

    daemon.settings = {
      log-driver = "local";
    };
  };

  # virtualisation.virtualbox.host.enable = true;

  environment.variables = {
    GCM_CREDENTIAL_STORE = "cache";
    NIXOS_OZONE_WL = "1";
  };

  environment.sessionVariables = {
    GCM_CREDENTIAL_STORE = "cache";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
      # background = "${../../suzume_door.jpg}";
      loginBackground = true;
    })

    inputs.agenix.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];

  programs.niri.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
  };

  # xdg.portal.wlr.enable = lib.mkForce true;
  programs.xwayland.enable = lib.mkForce true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.xserver = {
    enable = true;

    xkb = {
      layout = "us,latam";
      variant = "altgr-intl,";
      options = "grp:alt_space_toggle";
    };

    # windowManager.awesome = {
    #   enable = true;
    #   package = pkgs.awesome-git;
    # };

    windowManager.leftwm.enable = true;
  };
}
