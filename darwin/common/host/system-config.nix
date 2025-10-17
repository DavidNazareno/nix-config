{ inputs, outputs, config, lib, hostname, system, username, pkgs, unstablePkgs, constants, ... }:

{
  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # macOS configuration
  system.defaults = {
    NSGlobalDomain = {
      # Always show file extensions in Finder
      AppleShowAllExtensions = true;
      # Always show scroll bars instead of hiding them
      AppleShowScrollBars = "Always";
      # Disable animated focus ring around UI elements
      NSUseAnimatedFocusRing = false;
      # Expand save dialog by default
      NSNavPanelExpandedStateForSaveMode = true;
      # Expand save dialog by default (secondary setting)
      NSNavPanelExpandedStateForSaveMode2 = true;
      # Expand print dialog by default
      PMPrintingExpandedStateForPrint = true;
      # Expand print dialog by default (secondary setting)
      PMPrintingExpandedStateForPrint2 = true;
      # Prevent new documents from being saved to iCloud by default
      NSDocumentSaveNewDocumentsToCloud = false;
      # Disable press-and-hold for special characters (enables key repeat)
      ApplePressAndHoldEnabled = false;
      # Delay before key repeat starts (lower is faster)
      InitialKeyRepeat = 25;
      # Speed of key repeat (lower is faster)
      KeyRepeat = 2;
      # Enable tap-to-click for mouse
      "com.apple.mouse.tapBehavior" = 1;
      # Allow dragging windows by clicking anywhere on them
      NSWindowShouldDragOnGesture = true;
      # Dark mode
      AppleInterfaceStyle = "Dark";
      # Auto-hide menu bar
       _HIHideMenuBar = false;
      # Disable window animations
      NSAutomaticWindowAnimationsEnabled = false;
      # Set system font (requires logout/restart to take effect)
      # Options: "Helvetica Neue", "SF Pro Display", "FiraCode Nerd Font", etc.
    
    };
    LaunchServices.LSQuarantine = false; # disables "Are you sure?" for new apps
    loginwindow.GuestEnabled = false;
    finder.FXPreferredViewStyle = "Nlsv";

    CustomUserPreferences = {
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
    /*    "com.apple.Safari" = {
        # Privacy: don't send search queries to Apple
        UniversalSearchEnabled = false;
        SuppressSearchSuggestions = true;
      }; */
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
  };
}