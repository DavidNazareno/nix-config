{ config, pkgs, lib, inputs, system, unstablePkgs ? pkgs, constants ? (import ./constants.nix), ... }:
let
  # Importar los paquetes globales
  globalPackages = import ./packages.nix { inherit inputs pkgs unstablePkgs system; };
in
{
  # Las constantes vienen desde helpers.nix como specialArgs, no las re-exportamos aquí
  
  # Importar configuraciones de paquetes globales
  imports = [
    globalPackages
  ];
  
  # Configuraciones globales del host que aplican a todos los usuarios
  # Los paquetes del sistema se definen en packages.nix
  # Cada plataforma (darwin, linux, etc.) importa esto + sus paquetes específicos
}