{lib, ...}: {
  nixos.networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi.powersave = true;
  };

  nixos.services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };
    gnome.glib-networking.enable = true;

    # DNS resolver
    resolved.enable = true;
  };

  # Don't wait for network startup
  nixos.systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
