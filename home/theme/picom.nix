{pkgs, ...}: {
  services.picom = let
    picom-conf = pkgs.writeText "picom.conf" ''
      active-opacity = 1.000;
      animations = (
        { scale = 1.12; preset = "appear"; triggers = ["open", "show"]; },
        { scale = 1.12; preset = "disappear"; triggers = ["close", "hide"]; },
      );
      backend = "egl";
      detect-client-loader = true;
      detect-trasient = true;
      fade-delta = 10;
      fade-exclude = [  ];
      fade-in-step = 0.028000;
      fade-out-step = 0.030000;
      fading = true;
      inactive-opacity = 1.000;
      rules = (
        { match = "focused"; opacity = 0.925; },
        { match = "focused != 1"; opacity = 0.925; },
        { match = "window_type@ *= 'menu'"; opacity = 1.0; shadow = false; },
        { match = "role *?= 'popup'"; opacity = 1.0; shadow = false; },
        { match = "window_type = 'dock'"; shadow = false; },
      );
      shadow = true;
      shadow-exclude = [  ];
      shadow-offset-x = -15;
      shadow-offset-y = -15;
      shadow-opacity = 0.750000;
      vsync = false;
      xrender-sync-fence = true;
    '';
  in {
    enable = true;

    extraArgs = ["--config" "${picom-conf}"];

    settings = {};
  };
}
