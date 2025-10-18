{ inputs, outputs, config, lib, hostname, system, username, pkgs, unstablePkgs, constants, ... }:

{
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
      "libiconv" 
      "switchaudio-osx"
      "nowplaying-cli"
      "fonttools"
      "fzf"
      "nvm"  # Node Version Manager
    ];
    
    # === HOMEBREW TAPS ===
    taps = [
      # "homebrew/services"
      # "FelixKratz/formulae"      # SketchyBar and other tools
    ];
    
    # === GUI APPLICATIONS ===
    casks = [
      # --- PRODUCTIVITY & OFFICE ---
      "omnidisksweeper"           # Disk space analyzer
      "applite"                   # Application launcher
      "appcleaner"
      "bitwarden"                # Application uninstaller
      "anydesk"
      "keka"

      # --- COMMUNICATION ---
      "wechat"                    # Chinese instant messaging
      "discord"                   # Gaming and community chat
      "whatsapp"                  # Instant messaging

      # --- DEVELOPMENT TOOLS ---
      "ghostty"                   # Terminal emulator
      "iterm2"                    # Terminal emulator
      "orbstack"                  # Docker and Linux containers
      "medis"
      "dbngin"
      "github"
      "visual-studio-code"
      "zed"
      "dbeaver-community" 

      
      # --- BROWSERS ---
      "thorium"           # Chromium-based browser
      "arc"
      "brave-browser"               # Arc browser
      
      # --- MEDIA & ENTERTAINMENT ---
      "vlc"                       # Media player
      
      # --- SYSTEM UTILITIES ---
      "music-decoy"               # Prevent accidental music playback
      "balenaetcher"             # USB/SD card imaging
      "ubersicht"                 # Desktop widget platform (required for Simple Bar)

      # --- HARDWARE & PERIPHERALS ---
      "logitech-options"          # Logitech device software
      "betterdisplay"
      
      # --- FONTS ---
      "font-fira-code"            # Fira Code font
      "font-fira-code-nerd-font"  # Fira Code with icons
      "font-fira-mono-for-powerline" # Fira Mono for Powerline
      "font-hack-nerd-font"       # Hack font with icons
      "font-jetbrains-mono-nerd-font" # JetBrains Mono with icons
      "font-meslo-lg-nerd-font"   # Meslo LG with icons
      "sf-symbols"                # System symbols font
      "font-sf-mono"              # System San Francisco Mono font
      "font-sf-pro"               # System San Francisco Pro font
    ];
  };
}