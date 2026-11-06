{
  inputs,
  pkgs,
  pkgs-unstable,
  lib,
  packages,
  ...
}: {
  users.users.apika = {
    shell = pkgs.nushell;

    packages = with pkgs; [
      teamtype
      tree-sitter
      packages.kotlin-lsp
      pkgs-unstable.jetbrains.idea
      chromium
      vial
      qmk_hid
      qmk
      via

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

      pkgs-unstable.discord
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

      # Nix
      alejandra
      nixd

      # JS
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

      # asdsd
      alacritty
      fuzzel
      swaylock
      cmake
      gnumake

      fuzzel
      prismlauncher

      wl-clipboard-rs
      wayvr

      figma-linux

      pkgs-unstable.antigravity
      pkgs.android-tools

      pkgs-unstable.claude-code
      qpwgraph
    ];
  };

  programs.alvr = {
    enable = false;
    openFirewall = true;
  };

  virtualisation.waydroid.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv
      libgcc
      libllvm
      portaudio
    ];
  };

  programs.obs-studio.enable = true;
  programs.obs-studio.enableVirtualCamera = true;
  programs.steam.enable = true;

  # services.postgresql.enable = true;
  services.wivrn = {
    enable = true;
    openFirewall = true;
    autoStart = false;

    # If you're running this with an nVidia GPU and want to use GPU Encoding (and don't otherwise have CUDA enabled system wide), you need to override the cudaSupport variable.
    package = pkgs-unstable.wivrn.override {cudaSupport = true;};

    config.json = {
      applications = [pkgs.wayvr];
    };
  };

  services.displayManager.sddm = {
    enable = true;
    # wayland = true;
    theme = "catppuccin-mocha-mauve";
    package = pkgs.kdePackages.sddm;
  };

  services.desktopManager.gnome = {
    enable = true;
  };

  virtualisation.podman = {
    enable = true;
    enableNvidia = true;
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

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
  };

  xdg.portal.wlr.enable = lib.mkForce true;
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

  hardware.keyboard.qmk = {
    enable = true;
    keychronSupport = true;
  };

  networking = {
    hosts = {
      "localhost" = ["local.synapbox.com" ];
    };
    firewall = {
      enable = true;
      trustedInterfaces = ["docker0" "waydroid0"];
    };
  };
}
