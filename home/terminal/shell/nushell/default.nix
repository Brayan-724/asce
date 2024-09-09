{lib, ...}: {
  programs.nushell = {
    enable = true;
  };

  programs.carapace.enable = true;

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
