{ config, lib, pkgs, constants, ... }: {
  # Configuración específica para dnz-linux-lenovo
  
  # Sistema de archivos básico
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  # Configuración del bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Habilitar zsh a nivel del sistema
  programs.zsh.enable = true;

  # Configuración del usuario
  users.users.${constants.user.username} = {
    isNormalUser = true;
    group = constants.user.username;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };

  users.groups.${constants.user.username} = {};

  # Habilitar NetworkManager
  networking.networkmanager.enable = true;

  # Configuración básica del sistema
  networking.hostName = "dnz-linux-lenovo";
}