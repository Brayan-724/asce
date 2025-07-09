{
  # TODO: nvidia setting

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
