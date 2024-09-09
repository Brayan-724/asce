{pkgs, ...}: {
  boot = {
    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    
    tmp.cleanOnBoot = true;

    # Bootloader.
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };

    # load modules on boot
    kernelParams = [
      "radeon.modeset=0"
    ];
  };
}
