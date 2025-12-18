{ config, pkgs, lib, ... }:
{
  # GPG
  programs.gpg.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
      "--color=auto"
    ];
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
    defaultOptions = [
      "--no-mouse"
    ];
  };

  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };

  # LF file manager
  programs.lf.enable = true;

  # Bash
  programs.bash.enable = true;

  # Home Manager
  programs.home-manager.enable = true;

  # Nix index para búsqueda de paquetes
  programs.nix-index.enable = true;

 

  # Bat (mejor cat)
  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
    };
    themes = {
      # Agregar temas personalizados si es necesario
    };
    syntaxes = {
      # Agregar sintaxis personalizadas si es necesario
    };
  };

  # Zoxide para navegación inteligente
  programs.zoxide.enable = true;

  # Carapace - multi-shell completion
  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  # Atuin - shell history in SQLite
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  # Yazi - terminal file manager
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  # Starship is configured in starship.nix module

  # Fish shell
  programs.fish.enable = true;

  # Nushell
  programs.nushell.enable = true;
}