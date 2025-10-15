# Constantes globales para la configuración de Nix
# Este archivo centraliza valores comunes usados en toda la configuración
{
  # Usuario principal
  user = {
    username = "davidnazareno";
    fullName = "DavidNazareno";
    email = "dnnzareno@gmail.com";
  };

  # Versiones del sistema
  versions = {
    stateVersion = "25.05";
    nixpkgsVersion = "25.05";
  };

  # Sistemas soportados
  systems = {
    darwin = "aarch64-darwin";   # Apple Silicon (M1/M2/M3)
    # darwinIntel = "x86_64-darwin";  # Intel Mac si es necesario
  };

  # Rutas comunes
  paths = {
    homeDir = "/Users";
    configDir = "/Users/davidnazareno/.config";
  };

  # Configuraciones por defecto
  defaults = {
    timezone = "Europe/Madrid";
    locale = "en_US.UTF-8";
    keyboardLayout = "us";
  };

  # 🍎 Constantes específicas de Darwin/macOS
  darwin = {
    homebrew = {
      enable = true;
      brewPrefix = "/opt/homebrew";
      taps = [
        "homebrew/bundle"
        "homebrew/services"
      ];
    };
    
    # Configuraciones del sistema macOS
    system = {
      defaults = {
        dock = {
          autohide = true;
          orientation = "bottom";
          tilesize = 48;
        };
        finder = {
          showExtensions = true;
          showHiddenFiles = false;
        };
        trackpad = {
          clicking = true;
          dragging = true;
        };
      };
    };

    # Rutas específicas de macOS
    paths = {
      applications = "/Applications";
      library = "/Library";
      userLibrary = "/Users/davidnazareno/Library";
    };
  };
}