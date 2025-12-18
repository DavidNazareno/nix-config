{ inputs, outputs, config, lib, hostname, system, username, pkgs, unstablePkgs, constants, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
  customPackages = import ./packages/custom-packages { inherit pkgs; };
in
{
  imports = [
    # Módulos específicos de Darwin
    # NO importamos common/host/ aquí - eso lo hace el helper/flake
    ./modules/aerospace/default.nix
    ./modules/borders/default.nix
    ./system-config.nix
    
    # Paquetes específicos de Darwin
    ./packages/appstore.nix
    ./packages/brew.nix
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
    ## Darwin-specific packages only
    # Los paquetes crossplatform ahora están en common/host/packages.nix
    
    ## GUI packages (Darwin-specific)
    zsh-autopair
    jankyborders
   
    ## Custom packages (Darwin-specific)
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
  };
}