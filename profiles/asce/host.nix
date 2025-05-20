{
  inputs,
  packages,
  pkgs,
  lib,
  system,
  ...
}: {
  imports = [../../home/base/nix-ld.nix];

  users.users.apika = {
    shell = pkgs.nushell;

    packages = with pkgs; [
      discord
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

      flatpak

      packages.thorium
      inputs.zen-browser.packages."${system}".generic

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
    ];
  };

  programs.adb.enable = true;
  programs.obs-studio.enable = true;
  programs.obs-studio.enableVirtualCamera = true;
  programs.steam.enable = true;

  services.postgresql.enable = true;

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };

  services.xserver.desktopManager.gnome = {
    enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  environment.variables = {
    GCM_CREDENTIAL_STORE = "cache";
    NIX_OZONE_WL = "1";
  };

 environment.sessionVariables = {
    GCM_CREDENTIAL_STORE = "cache";
    NIX_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "mocha";
      font  = "Noto Sans";
      fontSize = "9";
      # background = "${../../suzume_door.jpg}";
      loginBackground = true;
    })
  ];

  programs.niri.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
  };

  xdg.portal.wlr.enable = lib.mkForce true;
  programs.xwayland.enable = lib.mkForce true;

  services.xserver = {
    enable = true;

    xkb = {
      layout = "us,latam";
      variant = "altgr-intl,";
      options = "grp:alt_space_toggle";
    };

    windowManager.awesome = {
      enable = true;
      package = pkgs.awesome-git;
    };

    windowManager.leftwm.enable = true;
  };
}
