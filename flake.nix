{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = { url = "github:homebrew/homebrew-core"; flake = false; };
    homebrew-cask = { url = "github:homebrew/homebrew-cask"; flake = false; };
    homebrew-bundle = { url = "github:homebrew/homebrew-bundle"; flake = false; };

    stylix.url = "github:nix-community/stylix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # vscode-marketplace for vscodium extensions
    #nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/fd5c5549692ff4d2dbee1ab7eea19adc2f97baeb";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    inherit (self) outputs;
    constants = import ./common/host/constants.nix;
    stateVersion = constants.versions.stateVersion;
    
    # Módulos comunes que se aplican a TODAS las plataformas (Darwin, Linux, etc.)
    commonModules = [
      ./common/host/default.nix
    ];
    
    darwinLib = import ./darwin/lib/helpers.nix { 
      inherit inputs outputs stateVersion commonModules; 
    };
  in {
    # macOS configuration with nix-darwin
    darwinConfigurations = {
      dnz-mac-mini = darwinLib.mkDarwin { hostname = "dnz-mac-mini"; };
    };
  };
}
