{lib, ...}: {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi.powersave = true;
  };

  programs = {
    ssh = {
      enable = true;
      extraConfig = ''
        # Add any extra raw config lines here
        ServerAliveInterval 60
      '';
    };
  };

  services = {
    gnome.glib-networking.enable = true;

    # DNS resolver
    resolved.enable = true;
  };

  # Don't wait for network startup
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
