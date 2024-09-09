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

      packages.thorium
      inputs.zen-browser.packages."${system}".generic
    ];
  };

  services.displayManager.sddm.enable = true;

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
