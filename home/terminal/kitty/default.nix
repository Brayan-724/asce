{...}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "VictorMono";
      size = 9;
    };

    settings = {
      # Theme
      background = "#100e23";

      enable_audio_bell = false;
      window_padding_width = "12 12 5";
    };
  };
}
