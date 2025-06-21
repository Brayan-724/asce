{
  config,
  pkgs,
  amixLib,
  ...
}: {
  enable = config.shell.name == "nushell";

  amix.shell.nushell = rec {
    pkg = pkgs.nushell;
    path = amixLib.getExe' pkg "nu";
  };

  home.programs.carapace.enable = true;

  home.programs.nushell = {
    enable = true;

    shellAliases = config.shell.aliases;

    environmentVariables = {
      SHELL = config.shell.path;
      # EDITOR = config.editor.path;
      GCM_CREDENTIAL_STORE = "cache";
      NIX_OZONE_WL = "1";
    };

    extraConfig = let
      nu_script = path: "source ${pkgs.nu_scripts}/share/nu_scripts/${path}.nu";
      completion = path: nu_script "custom-completions/${path}/${path}-completions";
      custom_menu = path: nu_script "custom-menus/${path}";
    in ''
      ${completion "cargo"}
      ${completion "git"}
      ${custom_menu "zoxide-menu"}

      $env.config.show_banner = false;

      use std;
      std ellie;
    '';
  };
}
