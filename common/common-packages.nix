{ inputs, pkgs, unstablePkgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [


    brave                                                  # Brave browser
    # github-desktop  # Not available for aarch64-darwin (Apple Silicon)
    dbeaver-bin
    bitwarden-desktop
    # bitwarden-cli  # Marked as broken in current nixpkgs
    neovim
    zed-editor
    vscode
    # ghostty  # Not available for aarch64-darwin (Apple Silicon)
    redis

    # === MONITORING & SYSTEM TOOLS ===
    nixpkgs-unstable.legacyPackages.${pkgs.system}.beszel    # Modern server monitoring dashboard
    btop                                                     # Resource monitor (htop alternative)
    fastfetch                                               # System information tool
    smartmontools                                           # Hard drive monitoring utilities
    ipmitool                                                # IPMI management utility
    
    # === MODERN UNIX REPLACEMENTS ===
    diffr                                                   # Modern Unix `diff` with syntax highlighting
    difftastic                                              # Structural diff tool for code
    du-dust                                                 # Modern Unix `du` - disk usage analyzer
    dua                                                     # Interactive disk usage analyzer
    duf                                                     # Modern Unix `df` - disk free space
    entr                                                    # Modern Unix `watch` - run commands on file changes
    fd                                                      # Modern Unix `find` - fast file finder
    ripgrep                                                 # Modern Unix `grep` - fast text search
    zoxide                                                  # Modern Unix `cd` - smart directory jumper
    
    # === DEVELOPMENT TOOLS ===
    act                                                     # Run GitHub Actions locally
    gh                                                      # GitHub CLI tool
    git-crypt                                              # Transparent file encryption in git
    go                                                      # Go programming language
    just                                                    # Command runner (make alternative)
    # terraform                                               # Infrastructure as code tool
    uv                                                      # Fast Python package installer
    
    # === CONTAINER & CLOUD TOOLS ===
    nixpkgs-unstable.legacyPackages.${pkgs.system}.talosctl # Talos Linux management CLI
    # skopeo                                                  # Container image manipulation tool
    # kubectl                                               # Kubernetes command-line tool
    
    # === NETWORK TOOLS ===
    drill                                                   # DNS lookup tool (dig alternative)
    iperf3                                                  # Network performance measurement
    mosh                                                    # Mobile shell (SSH alternative)
    nmap                                                    # Network discovery and security auditing
    wget                                                    # Web content retriever
    wireguard-tools                                         # VPN tools for WireGuard
    
    # === MEDIA & CONTENT ===
    ffmpeg                                                  # Multimedia framework for audio/video
    figurine                                                # ASCII art text generator
    television                                              # Terminal-based media player
    
    # === SYSTEM UTILITIES ===
    coreutils                                              # Basic file, shell and text utilities
    esptool                                                # ESP32/ESP8266 flashing tool
    gnused                                                 # GNU stream editor
    jetbrains-mono                                         # Monospace font for developers
    jq                                                     # JSON processor and query tool
    mc                                                     # Midnight Commander file manager
    qemu                                                   # Machine emulator and virtualizer
    stow                                                   # Symlink farm manager
    tree                                                   # Directory tree viewer
    unzip                                                  # Archive extraction utility
    watch                                                  # Execute programs periodically
    
    # === PROPRIETARY SOFTWARE (requires allowUnfree) ===
    vscode-extensions.ms-vscode-remote.remote-ssh          # VS Code remote SSH extension
    
    # === COMMENTED OUT / OPTIONAL ===
    # ansible                                              # IT automation platform
    # hugo                                                 # Static site generator
  ];
}
