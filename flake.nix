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

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";

    # vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    inherit (self) outputs;
    constants = import ./common/constants.nix;
    stateVersion = constants.versions.stateVersion;
    darwinLib = import ./os/darwin/lib { inherit inputs outputs stateVersion; };
    linuxLib = import ./os/linux/lib { inherit inputs outputs stateVersion; };
  in {

      darwinConfigurations = {
        # personal - Apple
        dnz-mac-mini = darwinLib.mkDarwin { hostname = "dnz-mac-mini"; };
      };

      # Home Manager configuration for non-NixOS systems (Ubuntu with Nix)
      homeConfigurations = {
        # personal - Ubuntu with Nix
        "davidnazareno@dnz-linux-lenovo" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.${constants.systems.linux};
          extraSpecialArgs = { 
            inherit inputs constants; 
            unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${constants.systems.linux};
          };
          modules = [
            ./common/home/davidnazareno.nix
            {
              home.username = constants.user.username;
              home.homeDirectory = "/home/${constants.user.username}";
            }
          ];
        };
      };

      
      nixosConfigurations = {
        # personal 
        dnz-linux-lenovo = linuxLib.mkNixOS { hostname = "dnz-linux-lenovo"; };
      };

      colmena = {
        meta = {
          nixpkgs = import inputs.nixpkgs { system = constants.systems.linux; };
          specialArgs = {
            inherit inputs outputs stateVersion self constants;
          };
        };

        defaults = { lib, config, name, ... }: {
          imports = [
            inputs.home-manager.nixosModules.home-manager
          ];
        };

        # No remote hosts configured
      };

    };

}
