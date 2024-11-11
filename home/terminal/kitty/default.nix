{packages, pkgs, ...}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "Miracode Nerd Font";
      size = 9;
      package = packages.miracode;
    };

    settings = {
      # Theme
      background = "#100e23";

      allow_remote_control = true;
      enable_audio_bell = false;
      window_padding_width = "12 12 5";
    };
  };
}
