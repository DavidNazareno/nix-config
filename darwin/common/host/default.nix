{ inputs, outputs, config, lib, hostname, system, username, pkgs, unstablePkgs, constants, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
  customPackages = import ./packages/custom-packages { inherit pkgs; };
in
{
  imports = [
    ./modules/aerospace/default.nix
    ./modules/borders/default.nix
    ./packages/appstore.nix
    ./packages/brew.nix
    ./system-config.nix
  ];

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
    promptInit = builtins.readFile ../data/mac-dot-zshrc;
  };

}