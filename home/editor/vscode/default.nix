{inputs, pkgs, ...}:
let
  marketplace = inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
in 
{
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = false;
    mutableExtensionsDir = true;
    extensions = 
      (with pkgs.vscode-extensions; [
        dart-code.flutter

	catppuccin.catppuccin-vsc-icons
	catppuccin.catppuccin-vsc
      ])
      ++ (with marketplace; [
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
}
