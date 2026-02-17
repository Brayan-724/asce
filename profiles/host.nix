{
  # probe-rs-tools - embedded
  users.groups.plugdev = {};

  users.users.apika = {
    description = "Apika Luca";
    isNormalUser = true;
    extraGroups = [
      "plugdev"

      "adbusers"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "transmission"
      "video"
      "wheel"
      "docker"
    ];
  };
}
