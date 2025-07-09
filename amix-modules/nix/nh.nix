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

  amix.aliases = {
    ns = "${amixLib.getExe config.nh.pkg} os switch --ask -H ${profileName} -- --show-trace";
  };

  # nh default flake
  nixos.environment.variables.FLAKE = config.nh.path;

  nixos.programs.nh = {
    enable = true;

    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 15d";
    };
  };
}
