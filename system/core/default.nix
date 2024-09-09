{lib, ...}:
# default configuration shared by all hosts
{
  imports = [
    ./boot.nix
    ./security.nix
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "es_MX.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "es_MX.UTF-8";
      LC_NUMERIC = "es_MX.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # don't touch this
  system.stateVersion = lib.mkDefault "24.11";

  time.timeZone = lib.mkForce "America/Hermosillo";
  time.hardwareClockInLocalTime = lib.mkDefault false;

  services.pipewire.enable = lib.mkForce false;
  hardware.pulseaudio.enable = lib.mkForce true;

  # services.flatpak.enable = true;

  # TODO: compresses half the ram for use as swap
#  zramSwap = {
#    enable = true;
#    algorithm = "zstd";
#  };
}
