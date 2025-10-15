{ config, inputs, pkgs, lib, unstablePkgs, constants, ... }:
{

  imports = [
    ../default.nix
  ];

  programs.git = {
    userEmail = constants.user.email;  # Usar email de constants
    userName = constants.user.fullName;
  };

}