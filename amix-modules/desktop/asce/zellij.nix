{
  config,
  amixTypes,
  amixEnums,
  ...
}: {
  enable = config.zellij.theme == amixEnums.zellij-theme.asce;

  amix.enum.zellij-theme = amixTypes.addItem "asce";

  home.programs.zellij.settings = {
    default_layout = "compact";
    pane_frames = false;
  };
}
