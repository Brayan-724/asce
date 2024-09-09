{
  # nh default flake
  environment.variables.FLAKE = "/home/apika/dotfiles";

  programs.nh = {
    enable = true;

    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };
}
