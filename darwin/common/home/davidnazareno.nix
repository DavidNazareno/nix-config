{ config, inputs, pkgs, lib, unstablePkgs, constants, system, ... }:
{
  # Import common configuration
  imports = [
    ../../../common/home/default.nix
    ./modules/ghostty/default.nix
    ./modules/zed/default.nix
    ./modules/simplebar/default.nix

  ];

  # Darwin-specific configurations

  # Darwin-specific file configurations
  # Note: Aerospace configuration is handled by services.aerospace in host configuration

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
