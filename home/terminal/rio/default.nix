{pkgs, ...}: {
  programs.rio = {
    enable = true;

    settings = {
      hide-mouse-cursor-when-typing = true;

      line-height = 0.5;

      padding-x = 12;
      padding-y = [5 0];

      cursor = {
        blinking = true;
        blinking-interval = 100;
      };

      editor = {
        program = "nvim";
        args = [];
      };

      fonts = {
        # family = "Miracode Nerd Font Propo";
        size = 12;
        # weight = 900;
      };

      navigation = {
        use-split = true;
      };

      renderer = {
        target-fps = 40;
      };

      shell = {
        program = "${pkgs.nushell}/bin/nu";
        args = [];
      };

      window = {
        mode = "Maximized";
      };
    };
  };
}
