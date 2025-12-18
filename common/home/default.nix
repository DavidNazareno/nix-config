{ config, inputs, pkgs, lib, unstablePkgs, constants, ... }:
{
  imports = [
    ./modules/zsh.nix
    ./modules/git
    ./modules/starship.nix
    ./modules/tmux.nix
    ./modules/ssh
    ./modules/cli-tools
    ./modules/nvim.nix
    ./modules/wezterm.nix
    ./modules/zed.nix
    ./modules/nushell.nix
    ./modules/zellij.nix
    ./modules/fish.nix
    ./modules/claude.nix
    ./modules/oil-scripts.nix
    ./modules/opencode.nix
  ];

  home.stateVersion = constants.versions.stateVersion;
}