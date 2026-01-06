{ pkgs, ... }:
{
  services.aerospace = {
    enable = true;
    package = pkgs.aerospace;

    settings = {
      after-login-command = [ ];
      after-startup-command = [
        "workspace 1" # Siempre empezar en workspace 1
      ];

      key-mapping.preset = "qwerty";

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      accordion-padding = 14;

      default-root-container-layout = "tiles";
      default-root-container-orientation = "horizontal";

      gaps = {
        outer = {
          top = 2;
          bottom = 2;
          left = 2;
          right = 2;
        };
        inner = {
          horizontal = 2;
          vertical = 2;
        };
      };

      on-window-detected = [
        ####### Floating Windows #######
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.apple.finder";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.apple.Passwords";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.bitwarden.desktop";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.orbstack.OrbStack";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.bjango.istatmenus";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.BetterDisplay.BetterDisplay";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.logitech.manager";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.freemacsoft.AppCleaner";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.PhilippeRemy.OmniDiskSweeper";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.apple.systempreferences";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.apple.SystemPreferences";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.apple.ActivityMonitor";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.apple.calculator";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.apple.Console";
          };
          run = [
            "layout floating"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.apple.DigitalColorMeter";
          };
          run = [
            "layout floating"
          ];
        }

        ####### Workspace 1: Navegadores #######
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "company.thebrowser.Browser";
          };
          run = [
            "move-node-to-workspace 1"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.brave.Browser";
          };
          run = [
            "move-node-to-workspace 1"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.alex313031.thorium";
          };
          run = [
            "move-node-to-workspace 1"
          ];
        }

        ####### Workspace 2: Desarrollo #######
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.microsoft.VSCode";
          };
          run = [
            "move-node-to-workspace 2"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "dev.zed.Zed";
          };
          run = [
            "move-node-to-workspace 2"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.mitchellh.ghostty";
          };
          run = [
            "move-node-to-workspace 2"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.googlecode.iterm2";
          };
          run = [
            "move-node-to-workspace 2"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.github.GitHubDesktop";
          };
          run = [
            "move-node-to-workspace 2"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "org.dbeaver.dbeaver-ce";
          };
          run = [
            "move-node-to-workspace 2"
          ];
        }

        ####### Workspace 3: Comunicación #######
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.hnc.Discord";
          };
          run = [
            "move-node-to-workspace 3"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "net.whatsapp.WhatsApp";
          };
          run = [
            "move-node-to-workspace 3"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.tencent.xinWeChat";
          };
          run = [
            "move-node-to-workspace 3"
          ];
        }

        ####### Workspace 4: Productividad #######
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "md.obsidian";
          };
          run = [
            "move-node-to-workspace 4"
          ];
        }

        ####### Workspace 5: Media #######
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "org.videolan.vlc";
          };
          run = [
            "move-node-to-workspace 5"
          ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.poolsuite.fm";
          };
          run = [
            "move-node-to-workspace 5"
          ];
        }
      ];

      mode.main.binding = {
        # Disable conflicting macOS shortcuts
        cmd-alt-h = [ ];
        cmd-h = [ ];

        # Workspace navigation
        alt-tab = "workspace-back-and-forth";
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";

        # Sequential workspace navigation
        alt-left = "workspace prev";
        alt-right = "workspace next";

        # Focus navigation (Vim-style)
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        # Circular window navigation (DFS traversal)
        alt-n = "focus dfs-next";
        alt-p = "focus dfs-prev";

        # Move windows (Vim-style)
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # Move windows to workspaces (and follow)
        alt-shift-1 = [
          "move-node-to-workspace 1"
          "workspace 1"
        ];
        alt-shift-2 = [
          "move-node-to-workspace 2"
          "workspace 2"
        ];
        alt-shift-3 = [
          "move-node-to-workspace 3"
          "workspace 3"
        ];
        alt-shift-4 = [
          "move-node-to-workspace 4"
          "workspace 4"
        ];
        alt-shift-5 = [
          "move-node-to-workspace 5"
          "workspace 5"
        ];
        alt-shift-6 = [
          "move-node-to-workspace 6"
          "workspace 6"
        ];

        # Monitor navigation
        alt-comma = "focus-monitor left";
        alt-period = "focus-monitor right";

        # Move windows between monitors
        alt-shift-comma = "move-node-to-monitor left";
        alt-shift-period = "move-node-to-monitor right";

        # Window resizing (more intuitive)
        alt-ctrl-h = "resize width -50"; # Hacer ventana más estrecha
        alt-ctrl-l = "resize width +50"; # Hacer ventana más ancha
        alt-ctrl-j = "resize height +50"; # Hacer ventana más alta
        alt-ctrl-k = "resize height -50"; # Hacer ventana más baja

        # Smart resize (mantener el original también)
        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        # Balance all windows
        ctrl-cmd-shift-0 = "balance-sizes";

        # Layout controls
        alt-shift-space = "layout floating tiling"; # Toggle floating/tiling
        alt-slash = "layout horizontal vertical"; # Toggle orientation
        alt-w = "layout accordion horizontal vertical"; # Accordion/tabbed layout
        alt-e = "layout tiles"; # Back to tiles
        alt-shift-f = "fullscreen"; # Toggle fullscreen

        # Window management
        alt-shift-q = "close"; # Close window
        alt-shift-backslash = "flatten-workspace-tree"; # Flatten workspace

        # Splits manuales - DESHABILITADO: no funciona con enable-normalization-flatten-containers
        # En su lugar, usa join-with (alt-[ y alt-]) para controlar la estructura
        # alt-v = "split vertical";
        # alt-s = "split horizontal";

        # Config management
        alt-shift-ctrl-r = "reload-config";

        # Join windows
        alt-leftSquareBracket = "join-with left";
        alt-rightSquareBracket = "join-with right";

        # Quick app launchers
        alt-t = "exec-and-forget open -a Ghostty.app";
        alt-c = "exec-and-forget open -a Zed.app";
        alt-b = "exec-and-forget open -a Arc.app";
        alt-f = "exec-and-forget open -a Finder.app";

        # Mode switching for advanced operations
        alt-r = "mode resize";
      };

      # Resize mode for fine-grained window control
      mode.resize.binding = {
        # Resize with arrow keys or vim keys
        h = "resize width -50";
        j = "resize height +50";
        k = "resize height -50";
        l = "resize width +50";

        left = "resize width -50";
        down = "resize height +50";
        up = "resize height -50";
        right = "resize width +50";

        # Fine adjustments
        shift-h = "resize width -10";
        shift-j = "resize height +10";
        shift-k = "resize height -10";
        shift-l = "resize width +10";

        # Balance and reset
        b = "balance-sizes";
        r = "flatten-workspace-tree";

        # Exit resize mode
        esc = "mode main";
        enter = "mode main";
      };

      on-focus-changed = [
        "exec-and-forget osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
      ];

      exec-on-workspace-change = [
        "/bin/zsh"
        "-c"
        "/usr/bin/osascript -e \"tell application id \\\"tracesOf.Uebersicht\\\" to refresh widget id \\\"simple-bar-index-jsx\\\"\""
      ];

    };
  };
}
