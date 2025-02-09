{
  # smooth backlight control
  hardware.brillo.enable = true;

  services.clight = {
    enable = false;
    settings = {
      verbose = true;
      backlight.disabled = true;
      dpms.timeouts = [900 300];
      dimmer.timeouts = [870 270];
      gamma.long_transition = true;
      keyboard.disabled = true;
      screen.disabled = true;
      daytime = { # TODO:
        latitud = "-38.38";
        longitude = "-60.26";
      };
    };
  };
}
