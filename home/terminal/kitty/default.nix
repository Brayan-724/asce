{packages, ...}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "Miracode Nerd Font";
      size = 8;
      package = packages.miracode;
    };

    settings = {
      # Theme
      background = "#100e23";

      enable_audio_bell = false;
      window_padding_width = "12 12 5";
    };
  };
}
