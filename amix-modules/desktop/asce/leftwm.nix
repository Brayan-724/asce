{amixTypes, amixEnums, config, ...}: {
  enable = config.leftwm.theme == amixEnums.leftwm-theme.asce;

  options.leftwm.theme = amixTypes.enum amixEnums.leftwm-theme;

  amix.enums.leftwm-theme = amixTypes.defineEnum "LeftWm Theme" ["asce"];

  nixos.services.xserver = {
    enable = true;

    windowManager.leftwm.enable = true;
  };
}
