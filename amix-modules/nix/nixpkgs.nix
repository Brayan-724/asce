{
  # home.xdg.configFile = {
  #   "nixpkgs/config.nix" = {
  #     text = "{ allowUnfree = true; android_sdk.accept_license = true; }";
  #   };
  # };

  nixos.nixpkgs.config = {
    allowUnfree = true;
    # TODO: Move to flutter or android module
    android_sdk.accept_license = true;
  };
}
