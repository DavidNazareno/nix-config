{ config, pkgs, lib, inputs, ... }:
let
  constants = import ./constants.nix;
  # Importar los paquetes globales
  globalPackages = import ./packages.nix { inherit inputs pkgs; unstablePkgs = pkgs; };
in
{
  # Exportar las constantes para que estén disponibles en otros módulos
  _module.args.constants = constants;
  
  # Importar configuraciones de paquetes globales
  imports = [
    globalPackages
  ];
  
  # Configuraciones globales del host que aplican a todos los usuarios
  # Los paquetes del sistema se definen en packages.nix
}