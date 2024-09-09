{pkgs, ...}: {
  users.users.apika = {
    description = "Apika Luca";
    isNormalUser = true;
    extraGroups = [
      "adbusers"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "transmission"
      "video"
      "wheel"
    ];
  };
}
