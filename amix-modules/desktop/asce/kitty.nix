{pkgs, ...}: {
  home.programs.kitty = {
    font = {
      name = "Miracode Nerd Font";
      size = 9;
      package = pkgs.miracode;
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
