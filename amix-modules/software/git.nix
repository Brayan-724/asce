{
  config,
  pkgs,
  amixTypes,
  amixLib,
  ...
}: let
  inherit (amixLib) getExe;
in {
  options.git = {
    enable = amixTypes.enable;
    pkg = amixTypes.pkg pkgs.git;
  };

  amix.aliases = {
    glol = "${getExe config.git.pkg} log --graph --all --decorate --format=format:'%C(dim)%h - %C(reset)%C(bold cyan)%ah %C(green)(%ar)%C(yellow)%d%C(reset)%n          %s%C(dim white) - %an%C(reset)'";
  };

  nixos.environment.systemPackages = [pkgs.git];
}
