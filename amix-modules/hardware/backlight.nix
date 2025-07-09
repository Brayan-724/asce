{amixTypes, ...}: {
  options.backlight.enable = amixTypes.enable;

  nixos.hardware.brillo.enable = true;
}
