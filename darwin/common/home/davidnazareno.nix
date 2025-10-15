{ config, inputs, pkgs, lib, unstablePkgs, constants, ... }:
{
  # Import common configuration
  imports = [
    ../../../common/home/default.nix
    ./modules/ghostty/default.nix
    ./modules/sketchybar/default.nix
    ./modules/vscode/default.nix
    ./modules/zed/default.nix

  ];

  # Darwin-specific configurations
  
  # Darwin-specific file configurations
  home.file = lib.mkMerge [
    # Aerospace configuration (macOS tiling window manager)
    (lib.mkIf pkgs.stdenv.isDarwin {
      ".config/aerospace/aerospace.toml".text = builtins.readFile ../host/modules/aerospace/aerospace.toml;
      # Ghostty configuration (terminal emulator)
      ".config/ghostty/config".text = builtins.readFile ../host/modules/ghostty/config;
    })
  ];

  # macOS-specific zsh plugins and configurations
  programs.zsh = {
    oh-my-zsh = {
      # Solo agregar plugins específicos de macOS a los ya definidos en common
      plugins = [
        "macos"
        "brew"
      ];
    };
  };

  # Configuraciones específicas del usuario para Darwin
  programs.git = {
    userEmail = constants.user.email;
    userName = constants.user.fullName;
  };
}