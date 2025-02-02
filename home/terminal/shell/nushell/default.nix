{config, lib, pkgs, ...}: {
  programs.carapace.enable = true;

  programs.nushell = {
    enable = true;

    shellAliases = {
      ns = "${pkgs.nh}/bin/nh os switch --ask -H asce -- --show-trace";
      glol = "${pkgs.git}/bin/git log --graph --all --decorate --format=format:'%C(dim)%h - %C(reset)%C(bold cyan)%ah %C(green)(%ar)%C(yellow)%d%C(reset)%n          %s%C(dim
white) - %an%C(reset)'";
      nix-zellij = "nix develop --impure -c zellij attach --create (basename (pwd))";
    };

    environmentVariables = {
      SHELL = ''${pkgs.nushell}/bin/nu'';
      EDITOR = ''${if config.programs.neovim.enable then "${config.programs.neovim.package}/bin/nvim" else "nano"}'';
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

  programs.starship = {
    enable = true;
    settings = let
      NO_SYMBOL = "";

      theme = {
        cmd = "#DCDFE4";

        directory = {
          fg = "#16151d";
          bg = "#7070f3";
        };
        git = {
          fg = "#16151d";
          bg = "#ac8ca5";
        };
        tech = {
          fg = "#DCDFE4";
          bg = "#16151d";
        };
      };

      langs = {
        aws = "  ";
        buf = " ";
        c = " ";
        conda = " ";
        dart = " ";
        deno = NO_SYMBOL;
        docker_context = " ";
        elixir = " ";
        elm = " ";
        fossil_branch = " ";
        golang = " ";
        guix_shell = " ";
        haskell = " ";
        haxe = "⌘ ";
        hg_branch = " ";
        java = " ";
        julia = " ";
        lua = " ";
        memory_usage = " ";
        meson = "喝 ";
        nim = " ";
        nix_shell = " ";
        nodejs = " ";
        package = " ";
        pijul_channel = "🪺 ";
        python = " ";
        rlang = "ﳒ ";
        ruby = " ";
        rust = "";
        scala = " ";
        spack = "🅢 ";
      };

      mkLangDef = symbol:
        lib.mkMerge [
          {
            style = "fg:${theme.tech.fg} bg:${theme.tech.bg}";
            format = "[ $symbol($version)]($style)";
          }
          (lib.mkIf (symbol != NO_SYMBOL) {inherit symbol;})
        ];

      langsDef =
        builtins.mapAttrs (_: mkLangDef)
        langs;
    in
      langsDef
      // {
        format = lib.concatStrings (
          [
            "[](${theme.directory.bg})"
            "$directory"
            "[ ](${theme.directory.bg})"
            "[](${theme.git.bg})"
            "$git_branch"
            "$git_status"
            "[ ](${theme.git.bg})"
            "[](${theme.tech.bg})"
          ]
          ++ map (lang: "$" + lang) (builtins.attrNames langs)
          ++ [
            "$docker_context"
            "[ ](bg:${theme.tech.bg})"
            "[ ](${theme.tech.bg})"
            "$cmd_duration\n"
            "$character"
          ]
        );

        add_newline = false;

        cmd_duration = {
          show_milliseconds = true;
          min_time = 1000;
          style = "fg:${theme.cmd}";
          format = "[$duration]($style)";
        };

        character = {
          success_symbol = "[❯](purple)";
          error_symbol = "[❯](red)";
          vimcmd_symbol = "[❮](green)";
        };

        directory = {
          style = "fg:${theme.directory.fg} bg:${theme.directory.bg}";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          read_only = " ";
        };

        git_branch = {
          symbol = "";
          style = "fg:${theme.git.fg} bg:${theme.git.bg}";
          format = "[ $symbol $branch ]($style)";
        };
        git_status = {
          style = "fg:${theme.git.fg} bg:${theme.git.bg}";
          format = "[$all_status$ahead_behind ]($style)";
        };
      };
  };
}
