# Constantes globales para la configuración de Nix
# Este archivo centraliza valores comunes usados en toda la configuración
{
  # Usuario principal
  user = {
    username = "davidnazareno";
    fullName = "DavidNazareno";
    email = "dnnzareno@gmail.com"; # Actualizar con email real
  };

  # Versiones del sistema
  versions = {
    stateVersion = "25.05";
    nixpkgsVersion = "25.05";
  };

  # Sistemas soportados
  systems = {
    darwin = "aarch64-darwin";   # Apple Silicon (M1/M2/M3)
    linux = "x86_64-linux";     # Intel/AMD 64-bit
    # Agregar más sistemas si es necesario
    # darwinIntel = "x86_64-darwin";  # Intel Mac
    # linuxArm = "aarch64-linux";     # ARM Linux
  };

  # Rutas comunes
  paths = {
    homeDir = {
      darwin = "/Users";
      linux = "/home";
    };
    configDir = {
      darwin = "/Users/davidnazareno/.config";
      linux = "/home/davidnazareno/.config";
    };
  };

  # Configuraciones por defecto
  defaults = {
    timezone = "Europe/Madrid"; # Actualizar según ubicación
    locale = "en_US.UTF-8";
    keyboardLayout = "us";
  };
}