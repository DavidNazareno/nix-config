{ config, inputs, pkgs, lib, unstablePkgs, constants, system, ... }:
{
  # Import common configuration
  imports = [
    ../../../common/home/default.nix
    ./modules/ghostty.nix
    #./modules/simplebar/default.nix

  ];

  # Darwin-specific configurations

  # Darwin-specific file configurations
  # Note: Aerospace configuration is handled by services.aerospace in host configuration
  # Note: Zsh configuration (including macOS-specific plugins) is handled in common/home/modules/zsh.nix

  # Configuraciones específicas del usuario para Darwin
  programs.git.settings = {
    user = {
      email = constants.user.email;
      name = constants.user.fullName;
    };
  };
}
