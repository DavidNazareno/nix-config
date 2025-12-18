{ inputs, outputs, stateVersion, commonModules, ... }:
let
  constants = import ../../common/host/constants.nix;
in
{
  mkDarwin = { hostname, username ? constants.user.username, system ? constants.systems.darwin,}:
  let
    inherit (inputs.nixpkgs) lib;
    unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
    customConfPath = ./../${hostname};
    customConf = if builtins.pathExists (customConfPath) then (customConfPath + "/default.nix") else ./../common/host/dock.nix;
  in
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit system inputs username unstablePkgs constants; };
      modules = commonModules ++ [
        # commonModules viene del flake.nix y contiene la configuración común de TODAS las plataformas
        
        # Importar configuración específica de Darwin
        ./../common/host/default.nix
        # Importar configuración específica del host (dnz-mac-mini, etc.)
        customConf
        inputs.home-manager.darwinModules.home-manager {
            networking.hostName = hostname;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs constants system unstablePkgs; };
            home-manager.users.${username} = { 
              imports = [ ./../common/home/${username}.nix inputs.stylix.homeModules.stylix ]; 
              # Configurar nixpkgs dentro de home-manager para evitar conflictos
              nixpkgs.overlays = [
                (final: prev: {
                  nodejs = prev.nodejs_22;
                  nodejs-slim = prev.nodejs-slim_22;
                })
              ];
            };
        }
        inputs.nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            autoMigrate = true;
            mutableTaps = true;
            user = "${username}";
            taps = with inputs; {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };
          };
        }
      ];
    };
}