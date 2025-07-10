{...}: {
  # graphics drivers / HW accel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # boot.loader.grub.configurationLimit = 1;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.displayManager.gdm.wayland = true;
  boot.initrd.kernelModules = ["nvidia"];
  # boot.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
  # boot.kernelParams = ["nvidia_drm.modeset=1" "nvidia_drm.fbdev=1"];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    nvidiaPersistenced = false;
    open = true;
    forceFullCompositionPipeline = true;
  };

  # services.xserver.videoDrivers = ["nvidia"];
  # boot.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
  # boot.kernelParams = ["nvidia_drm.modeset=1" "nvidia_drm.fbdev=1"];
  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   nvidiaSettings = true;
  #   open = false;
  #   nvidiaPersistenced = true;
  #   #powerManagement.enable = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.beta;
  #   forceFullCompositionPipeline = true;
  # };

  # # TODO:
  #
  # extraPackages = with pkgs; [
  #   libva
  #   vaapiVdpau
  #   libvdpau-va-gl
  # ];
  # extraPackages32 = with pkgs.pkgsi686Linux; [
  #   vaapiVdpau
  #   libvdpau-va-gl
  # ];
  # };
}
