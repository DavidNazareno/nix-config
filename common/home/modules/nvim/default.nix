{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # Configuración Lua personalizada
    extraLuaConfig = ''
      -- Cargar configuración de opciones
      ${builtins.readFile ./options.lua}
      
      -- Cargar configuración de keymaps
      ${builtins.readFile ./keymap.lua}
    '';
    
    # Plugins necesarios
    plugins = with pkgs.vimPlugins; [
      # Telescope y dependencias
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim
      
      # Todo comments para TodoTelescope
      todo-comments-nvim
      
      # Otros plugins útiles
      nvim-web-devicons
    ];
    
    # Configuración adicional para plugins
    extraConfig = ''
      lua << EOF
        -- Configuración de Telescope
        ${builtins.readFile ./plugins/telescope.lua}
      EOF
    '';
  };
  
  # Configurar archivos de configuración adicionales si es necesario
  home.file = {
    ".config/nvim/lua/config/options.lua".source = ./options.lua;
    ".config/nvim/lua/config/keymap.lua".source = ./keymap.lua;
    ".config/nvim/lua/plugins/telescope.lua".source = ./plugins/telescope.lua;
  };
}