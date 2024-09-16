{pkgs, packages, lib, ...}: {
  boot = {
    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    
    tmp.cleanOnBoot = true;

    # Bootloader.
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;

      theme = pkgs.catppuccin-grub;
    };

    # Boot progress bar
    plymouth = {
      enable = true;
      theme = "mac-style";
      themePackages = [ packages.mac-style ];
    };

    # load modules on boot
    kernelParams = [
      "radeon.modeset=0"
    ];
  };
}
