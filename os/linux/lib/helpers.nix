{ inputs, outputs, stateVersion, ... }:
let
  constants = import ../../../common/constants.nix;
in
{
  mkNixOS = { hostname, username ? constants.user.username, system ? constants.systems.linux }:
  let
    inherit (inputs.nixpkgs) lib;
    unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
    customConfPath = ./../hosts/${hostname};
    customConf = if builtins.pathExists (customConfPath) then (customConfPath + "/default.nix") else {};
  in
    lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs outputs stateVersion unstablePkgs constants; };
      modules = [
        ../../../common/common-packages.nix
        ./../hosts/nixos-common.nix
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs constants; };
          home-manager.users.${username} = { imports = [ ./../../../common/home/${username}.nix ]; };
        }
      ] ++ lib.optionals (builtins.pathExists customConfPath) [
        customConf
      ];
    };
}