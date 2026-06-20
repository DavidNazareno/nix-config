{ lib, ... }:
{
  # Habilitar neovim
  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
    force = true;
  };
}
