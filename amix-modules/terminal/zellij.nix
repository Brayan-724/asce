{
  config,
  pkgs,
  amixTypes,
  amixLib,
  amixEnums,
  ...
}: {
  amix.enum.zellij-theme = amixTypes.defineEnum "Zellij Theme" [];

  options.zellij = with amixTypes; {
    inherit enable;
    pkg = pkg pkgs.zellij;
    theme = enum amixEnums.zellij-theme;
  };

  amix.aliases = {
    nix-zellij = let
      nixBin =
        if config.nom.enable
        then amixLib.getExe config.nom.pkg
        else "nix";
    in "${nixBin} develop --impure -c ${amixLib.getExe config.zellij.pkg} attach --create";
  };

  home.programs.zellij = {
    enable = true;
    settings = {
      default_layout = "compact";
      default_shell = config.shell.path;
      pane_frames = false;
    };
  };
}
