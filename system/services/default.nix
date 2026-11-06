{
  imports = [
    ./backlight.nix
    ./location.nix
    ./power.nix
    ./udev.nix
    # ./xwaylandvideobridge.nix
  ];

  services = {
    dbus.implementation = "broker";

    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    nohang.enable = true;
  };

  # xdg.portal = {
  #   enable = true;
  #   xdgOpenUsePortal = true;
  #
  #   extraPortals = lib.mkForce (with pkgs; [
  #     xdg-desktop-portal-gnome
  #     xdg-desktop-portal-gtk
  #   ]);
  # };

  # programs.xwayland.enable = true;
}
