{config, ...}: {
  # graphics drivers / HW accel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # boot.loader.grub.configurationLimit = 1;
  services.xserver.videoDrivers = [ "nvidia" ];
  # services.xserver.displayManager.gdm.wayland = true;
  boot.initrd.kernelModules = ["nvidia"];
  boot.extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
  # boot.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
  # boot.kernelParams = ["nvidia_drm.modeset=1" "nvidia_drm.fbdev=1"];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;
    # forceFullCompositionPipeline = true;
    modesetting.enable = false;
    nvidiaSettings = true;
    nvidiaPersistenced = true;
    powerManagement.enable = true;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:6:0:0";
    };
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
