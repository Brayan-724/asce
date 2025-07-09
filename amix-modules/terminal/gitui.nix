{
  amixEnums,
  amixLib,
  amixTypes,
  ...
}: {
  amix.enum.gitui-theme = amixLib.defineEnum "Gitui Theme" [];

  options.gitui.theme = amixTypes.enum amixEnums.gitui-theme;

  programs.gitui.enable = true;
}
