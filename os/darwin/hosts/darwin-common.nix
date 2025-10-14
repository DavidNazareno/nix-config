{ inputs, outputs, config, lib, hostname, system, username, pkgs, unstablePkgs, constants, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
  customPackages = import ../custom-packages { inherit pkgs; };
in
{
  users.users.${constants.user.username}.home = "/Users/${constants.user.username}";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
    channel.enable = false;
  };
  system.stateVersion = 5;

  # Set primary user for system-wide activation
  system.primaryUser = constants.user.username;

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "${system}";
  };

  environment.systemPackages = with pkgs; [
    ## unstable
    unstablePkgs.yt-dlp
    unstablePkgs.get_iplayer
    unstablePkgs.colmena

    ## stable CLI
    pkgs.comma
    pkgs.hcloud
    pkgs.just
    pkgs.lima
    pkgs.nix
    pkgs.aerospace


    ## custom packages
    customPackages.sshpilot
  ];

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.fira-mono
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # pins to stable as unstable updates very often
  nix.registry = {
    n.to = {
      type = "path";
      path = inputs.nixpkgs;
    };
    u.to = {
      type = "path";
      path = inputs.nixpkgs-unstable;
    };
  };

  programs.nix-index.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    promptInit = builtins.readFile ./../../data/mac-dot-zshrc;
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    global.autoUpdate = true;

    # === COMMAND LINE TOOLS ===
    brews = [
      # "neovim"                    # Modern text editor
      # "ollama"                    # Local LLM runner
      #"tailscale"                # VPN mesh network
      "borders"                  # Window borders for macOS
    ];
    
    # === HOMEBREW TAPS ===
    taps = [
      #"FelixKratz/formulae"      # SketchyBar and other tools
    ];
    
    # === GUI APPLICATIONS ===
    casks = [
      
      # --- CREATIVE & DESIGN ---
      # "adobe-creative-cloud"      # Adobe Creative Suite
      # "audacity"                  # Audio editing software
      # "obs"                       # Streaming and recording software
      # "openscad"                  # 3D CAD modeling software
      #"bambu-studio"             # 3D printing slicer
      #"prusaslicer"              # 3D printing slicer
      #"screenflow"               # Screen recording and editing
      #"cleanshot"                # Screenshot and annotation tool
      
      # --- PRODUCTIVITY & OFFICE ---
      # "notion"                    # Note-taking and workspace
      # "obsidian"                  # Knowledge management
      # "raycast"                   # Spotlight replacement and launcher
      # "bentobox"                  # Menu bar organizer
      "jordanbaird-ice"           # Menu bar management
      "omnidisksweeper"           # Disk space analyzer
      #"popclip"                  # Text selection actions
      #"shortcat"                 # Keyboard navigation
      #"clop"                     # Image optimization
      
      # --- COMMUNICATION ---
      "wechat"                    # Chinese instant messaging
      "discord"                   # Gaming and community chat
      # "element"                   # Matrix protocol client
      # "signal"                    # Secure messaging
      # "slack"                     # Team communication
      # "claude"                    # AI assistant
      #"claude-code"              # AI coding assistant
      
      # --- DEVELOPMENT TOOLS ---
      # "visual-studio-code"        # Code editor
      # "zed-editor"                # Code editor
      # "ghostty"                   # Terminal emulator
      # "alacritty"                 # GPU-accelerated terminal
      "iterm2"                    # Terminal emulator
      "orbstack"                  # Docker and Linux containers
      # "mqtt-explorer"             # MQTT client and explorer
      #"docker"                   # Container platform
      #"marta"                    # File manager
      "medis"
      "dbngin"
      
      # --- AI & MACHINE LEARNING ---
      # "lm-studio"                 # Local language model studio
      #"ollama-app"               # Ollama GUI application
      
      # --- BROWSERS ---
      # "firefox"                   # Mozilla Firefox browser
      # "google-chrome"             # Google Chrome browser
      "thorium"           # Chromium-based browser (now installed via Nix)
      "arc"               # Arc browser
      
      # --- MEDIA & ENTERTAINMENT ---
      # "spotify"                   # Music streaming
      # "plexamp"                   # Plex music player
      "vlc"                       # Media player
      # "steam"                     # Gaming platform
      # "openttd"                   # Transport Tycoon Deluxe
      #"iina"                     # Modern media player
      
      # --- SYSTEM UTILITIES ---
      # "hammerspoon"               # macOS automation
      # "karabiner-elements"        # Keyboard customization
      # "easy-move-plus-resize"     # Window management
      # "flameshot"                 # Screenshot tool
      "istat-menus"               # System monitoring
      # "displaylink"               # External display support
      # "macwhisper"                # Speech-to-text transcription
      "music-decoy"               # Prevent accidental music playback
      #"alcove"                   # Window management
      "balenaetcher"             # USB/SD card imaging
      #"nextcloud"                # File synchronization
      #"wireshark"                # Network protocol analyzer
      #"viscosity"                # VPN client
      
      # --- HARDWARE & PERIPHERALS ---
      # "elgato-camera-hub"         # Elgato camera software
      # "elgato-control-center"     # Elgato device control
      # "elgato-stream-deck"        # Stream Deck software
      "logitech-options"          # Logitech device software
      
      # --- FONTS ---
      "font-fira-code"            # Fira Code font
      "font-fira-code-nerd-font"  # Fira Code with icons
      "font-fira-mono-for-powerline" # Fira Mono for Powerline
      "font-hack-nerd-font"       # Hack font with icons
      "font-jetbrains-mono-nerd-font" # JetBrains Mono with icons
      "font-meslo-lg-nerd-font"   # Meslo LG with icons
      
      # --- AUDIO TOOLS (Rogue Amoeba) ---
      # "audio-hijack"              # Audio recording and routing
      # "farrago"                   # Soundboard application
      # "loopback"                  # Audio routing utility
      # "soundsource"               # Audio control and enhancement
      
      # --- WINDOW MANAGEMENT ---
      #"nikitabobko/tap/aerospace" # Tiling window manager
    ];
    masApps = {
      "Amphetamine" = 937984704;
      # "AutoMounter" = 1160435653;
      "PoolsuiteFM" = 1514817810;

      # "Creator's Best Friend" = 1524172135;
      # "DaVinci Resolve" = 571213070;
      # "Disk Speed Test" = 425264550;
      # "Fantastical" = 975937182;
      # "Ivory for Mastodon by Tapbots" = 6444602274;
      # "Home Assistant Companion" = 1099568401;
      # "Microsoft Remote Desktop" = 1295203466;
      # "Perplexity" = 6714467650;
      # "Resize Master" = 1025306797;
      # "rCmd" = 1596283165;
      # "Snippety" = 1530751461;
      #"Tailscale" = 1475387142;
      # "Telegram" = 747648890;
      # "The Unarchiver" = 425424353;
      # "Todoist" = 585829637;
      # "UTM" = 1538878817;
      # "Wireguard" = 1451685025;

      # "Final Cut Pro" = 424389933;

      # these apps only available via uk apple id
      #"Logic Pro" = 634148309;
      #"MainStage" = 634159523;
      #"Garageband" = 682658836;
      #"ShutterCount" = 720123827;
      #"Teleprompter" = 1533078079;

      # "Keynote" = 409183694;
      # "Numbers" = 409203825;
      # "Pages" = 409201541;
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # macOS configuration
  system.defaults = {
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowScrollBars = "Always";
    NSGlobalDomain.NSUseAnimatedFocusRing = false;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
    NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
    NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;
    NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    NSGlobalDomain.InitialKeyRepeat = 25;
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    NSGlobalDomain.NSWindowShouldDragOnGesture = true;
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    LaunchServices.LSQuarantine = false; # disables "Are you sure?" for new apps
    loginwindow.GuestEnabled = false;
    finder.FXPreferredViewStyle = "Nlsv";
  };

  system.defaults.CustomUserPreferences = {
      "com.apple.finder" = {
        ShowExternalHardDrivesOnDesktop = true;
        ShowHardDrivesOnDesktop = false;
        ShowMountedServersOnDesktop = false;
        ShowRemovableMediaOnDesktop = true;
        _FXSortFoldersFirst = true;
        # When performing a search, search the current folder by default
        FXDefaultSearchScope = "SCcf";
        DisableAllAnimations = true;
        NewWindowTarget = "PfDe";
        NewWindowTargetPath = "file://$\{HOME\}/Desktop/";
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        ShowStatusBar = true;
        ShowPathbar = true;
        WarnOnEmptyTrash = false;
      };
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.HIToolbox" = {
        # Completely disable Caps Lock functionality
        AppleFnUsageType = 1; # Enable Fn key functionality
        AppleKeyboardUIMode = 3;
        # Disable Caps Lock toggle entirely
        AppleSymbolicHotKeys = {
          "60" = {
            enabled = false; # Disable Caps Lock toggle hotkey
          };
        };
        # Override modifier key behavior to prevent Caps Lock from functioning
        AppleModifierKeyRemapping = {
          "1452-630-0" = {
            # Map Caps Lock (key code 57/0x39) to nothing (disable it)
            HIDKeyboardModifierMappingSrc = 30064771129; # Caps Lock
            HIDKeyboardModifierMappingDst = 30064771299; # No Action
          };
        };
      };
      "com.apple.dock" = {
        autohide = true;
        launchanim = false;
        static-only = false;
        show-recents = false;
        show-process-indicators = true;
        orientation = "left";
        tilesize = 36;
        minimize-to-application = true;
        mineffect = "scale";
        enable-window-tool = false;
        # Velocidad de aparición/desaparición del dock (en segundos)
        autohide-delay = 0.0;        # Retraso antes de mostrar (0 = instantáneo)
        autohide-time-modifier = 0.2; # Velocidad de animación (más bajo = más rápido)
      };
      "com.apple.ActivityMonitor" = {
        OpenMainWindow = true;
        IconType = 5;
        SortColumn = "CPUUsage";
        SortDirection = 0;
      };
      "com.apple.Safari" = {
        # Privacy: don’t send search queries to Apple
        UniversalSearchEnabled = false;
        SuppressSearchSuggestions = true;
      };
      "com.apple.AdLib" = {
        allowApplePersonalizedAdvertising = false;
      };
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        # Check for software updates daily, not just once per week
        ScheduleFrequency = 1;
        # Download newly available updates in background
        AutomaticDownload = 1;
        # Install System data files & security updates
        CriticalUpdateInstall = 1;
      };
      "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
      # Prevent Photos from opening automatically when devices are plugged in
      "com.apple.ImageCapture".disableHotPlug = true;
      # Turn on app auto-update
      "com.apple.commerce".AutoUpdate = true;
      "com.googlecode.iterm2".PromptOnQuit = false;
      "com.google.Chrome" = {
        AppleEnableSwipeNavigateWithScrolls = true;
        DisablePrintPreview = true;
        PMPrintingExpandedStateForPrint2 = true;
      };
  };

}
