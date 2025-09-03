{
  pkgs,
  ...
}:{
  programs.vscode = {
    enable = false;
    mutableExtensionsDir = true;

    profiles.default = {
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = false;
      extensions =
        (with pkgs.vscode-extensions; [
          dart-code.flutter

          catppuccin.catppuccin-vsc-icons
          catppuccin.catppuccin-vsc
        ]);

      userSettings = {
        "editor.fontFamily" = "GeistMono Nerd Font, Catppuccin Mocha, 'monospace', monospace";
        "editor.fontSize" = 14;
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;

        "file.autoSave" = "afterDelay";

        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
      };
    };
  };
}
