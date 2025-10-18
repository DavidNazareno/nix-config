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
      theme = "agnoster";
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
      
      # Configuraciones adicionales del sistema
      export CLICOLOR=1
      export LSCOLORS=gxfxcxdxbxgggdabagacad
      export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt
      
      # path fix for homebrew
      export PATH=$PATH:/opt/homebrew/bin/
      export PATH=$PATH:/Users/davidnazareno/go/bin
      export PATH=$HOME/.npm-global/bin:$PATH
      export VISUAL=nvim
      export EDITOR=nvim
      export TERM=xterm
      
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      
      # Kubectl completion
      source <(kubectl completion zsh)
      export KUBE_EDITOR="nvim"
      
      # Comma function for nix run
      , () {
        nix run nixpkgs#comma -- "$@"
      }
      
      # Starship prompt (debe ir al final)
      eval "$(starship init zsh)"
    '';
    
    # Variables de entorno
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "brave";
    };
  };
}