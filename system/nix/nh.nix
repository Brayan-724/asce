{
  # nh default flake
  environment.variables.FLAKE = "/home/apika/asce";

  programs.nh = {
    enable = true;

    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 15d";
    };
  };
}
