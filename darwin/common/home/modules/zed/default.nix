{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "rose-pine-theme"
      "catppuccin"
      "nix"
      "symbols"
      "toml"
      "java"
      "dockerfile"
      "sql"
      "latex"
      "xml"
      "make"
      "svelte"
      "zig"
      "lua"
      "astro"
      "docker-compose"
      "emmet"
      "swift"
      "kotlin"
      "prisma"
      "env"
      "deno"
      "git-firefly"
      "mcp-server-context7"
      "react-typescript-snippets"
      "min-theme"
    ];
    userSettings = {
      ui_font_family = "SF Pro Display";
      buffer_font_family = "Fira Code";
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      base_keymap = "VSCode";
      theme= {
        mode = "system";
        light = "One Light";
        dark = "Min Dark (Blurred)";
      };
      vertical_scroll_margin = 5;
      vim_mode = true;
      relative_line_numbers = true;
      tab_size = 2;
      show_wrap_guides = true;
      project_panel = {
        git_status = false;
      };
      confirm_quit = false;
      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
        };
        JavaScript = {
          formatter = {
            external = {
              command = "prettier";
              arguments = [
                "--stdin-filepath"
                "{buffer_path}"
              ];
            };
          };
        };
      };
      lsp = {
        nil = {
          initialization_options = {
            formatting = {
              command = [ "nixfmt" ];
            };
            nix = {
              binary = "${pkgs.nix}/bin/nix";
            };
          };
        };
      };
      show_edit_predictions = true;
      formatter = "language_server";
      git = {
        inline_blame = {
          enabled = true;
        };
      };
      terminal = {
        cursor_shape = "underline";
        toolbar.breadcrumbs = false;
      };
    };
  };
}
