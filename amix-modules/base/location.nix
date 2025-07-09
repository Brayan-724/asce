{amixTypes, ...}: {
  options.location.enable = amixTypes.enable;

  # enable location service
  nixos.location = {
    provider = "geoclue2";
    latitude = -38.38;
    longitude = -60.26;
  };

  # provide location
  nixos.services.geoclue2.enable = true;
}
