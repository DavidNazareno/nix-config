# Paquetes globales del sistema para todas las plataformas
# Este archivo define los paquetes que estarán disponibles en todo el sistema
{ inputs, pkgs, unstablePkgs, system ? pkgs.system, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  environment.systemPackages = with pkgs; [

    # === NAVEGADORES Y APLICACIONES ===
    neovim                                                # Modern Vim-based editor
    redis                                                 # In-memory data structure store

    # === MONITORING & SYSTEM TOOLS ===
    nixpkgs-unstable.legacyPackages.${system}.beszel    # Modern server monitoring dashboard
    btop                                                     # Resource monitor (htop alternative)
    fastfetch                                               # System information tool
    smartmontools                                           # Hard drive monitoring utilities
    ipmitool                                                # IPMI management utility

    # === MODERN UNIX REPLACEMENTS ===
    diffr                                                   # Modern Unix `diff` with syntax highlighting
    difftastic                                              # Structural diff tool for code
    dust                                                    # Modern Unix `du` - disk usage analyzer (renamed from du-dust)
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
    typescript
    nodejs                                                  # Node.js runtime
    bun                                                     # Fast JavaScript runtime
    cargo                                                   # Rust package manager
    nil                                                     # Nix language server
    unstablePkgs.nixd                                       # Nix language server (unstable)
    tree-sitter                                             # Parser generator tool
    gcc                                                     # GNU Compiler Collection
    lazygit                                                 # Terminal UI for git
    volta                                                   # JavaScript tool manager
    bash                                                    # Bourne Again Shell
    unstablePkgs.yt-dlp                                     # YouTube downloader
    unstablePkgs.get_iplayer                                # BBC iPlayer downloader
    unstablePkgs.colmena                                    # NixOS deployment tool
    comma                                                    # Run commands without installing
    hcloud                                                   # Hetzner Cloud CLI
    lima                                                     # Linux virtual machines (macOS)
    nix                                                      # Nix package manager
    # === CONTAINER & CLOUD TOOLS ===
    nixpkgs-unstable.legacyPackages.${system}.talosctl # Talos Linux management CLI
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
    lua54Packages.lua
    tmux                                                   # Terminal multiplexer
    fish                                                   # Friendly interactive shell
    zsh                                                    # Z shell
    nushell                                                # Modern shell


    # === PROPRIETARY SOFTWARE (requires allowUnfree) ===
    vscode-extensions.ms-vscode-remote.remote-ssh          # VS Code remote SSH extension


    # === FONTS ===
    nerd-fonts.caskaydia-cove
    nerd-fonts.iosevka-term


    # === COMMENTED OUT / OPTIONAL ===
    # ansible                                              # IT automation platform
    # hugo                                                 # Static site generator
  ];
}
