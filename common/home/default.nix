{ config, inputs, pkgs, lib, unstablePkgs, constants, ... }:
{
  imports = [
    ./modules/zsh
    ./modules/git
    ./modules/starship
    ./modules/tmux
    ./modules/ssh
    ./modules/cli-tools
    ./modules/nvim
  ];

  home.stateVersion = constants.versions.stateVersion;
}