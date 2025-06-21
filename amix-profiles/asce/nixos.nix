{pkgs, ...}: {
  boot = {
    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    tmp.cleanOnBoot = true;

    # Bootloader
    loader = {
      efi = {
        canTouchEfiVariables = true;
        # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };
}
