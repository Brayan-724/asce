{
  inputs,
  packages,
  pkgs,
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
      ouch
      prismlauncher
      yazi

      # Gitea
      taplo
      tea
      git-credential-manager
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

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
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

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
  };

  services.xserver = {
    enable = true;

    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };

    windowManager.awesome = {
      enable = true;
      package = pkgs.awesome-git;
    };
  };
}
