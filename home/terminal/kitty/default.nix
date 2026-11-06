{packages, ...}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "MiracodeNerd Font";
      size = 10;
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
