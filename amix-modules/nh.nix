{
  config,
  pkgs,
  amixTypes,
  amixLib,
  profileName,
  ...
}: {
  options.nh = {
    enable = amixTypes.enable;
    pkg = amixTypes.pkg pkgs.nh;
    path = amixTypes.string;
  };

  config = {
    amix.shell.aliases = {
      ns = "${amixLib.getExe config.nh.pkg} os switch --ask -H ${profileName} -- --show-trace";
    };

    # nh default flake
    environment.variables.FLAKE = config.nh.path;

    programs.nh = {
      enable = true;

      # weekly cleanup
      clean = {
        enable = true;
        extraArgs = "--keep-since 15d";
      };
    };
  };
}
