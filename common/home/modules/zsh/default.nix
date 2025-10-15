{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Oh My Zsh configuration
    oh-my-zsh = {
      enable = true;
      plugins = [
        # Desarrollo y Git
        "git"
        "github"
        "gitignore"
        
        # Node.js y desarrollo web
        "nvm"
        
        # Navegación y utilidades
        "z"
        "sudo"
        "history-substring-search"
        "web-search"
        "copypath"
        "copyfile"
        "extract"
        
        # Herramientas de desarrollo
        "jsontools"
        "encode64"
        "urltools"
        "colored-man-pages"
        
        # Productividad
        "aliases"
        "common-aliases"
      ];
    };
    
    # Configuración adicional
    initExtra = ''
      # Aliases personalizados
      alias ll='eza -la'
      alias la='eza -la'
      alias l='eza -l'
      alias tree='eza --tree'
      
      # Configuración de autosuggestions
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    '';
    
    # Variables de entorno
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "brave";
    };
  };
}