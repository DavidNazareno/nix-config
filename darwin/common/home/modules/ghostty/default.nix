{
  pkgs,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    package = null;
    enableZshIntegration = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    installBatSyntax = false;

    settings = {
      shell-integration = "zsh";
      shell-integration-features = "no-cursor";
      background-blur = 255;
      font-family = "FiraCode Nerd Font Mono";
      theme = "nord";
      font-thicken = true;
      cursor-style = "block";
      mouse-hide-while-typing = true;
      window-colorspace = "display-p3";
      adjust-cell-height = "30%";
      macos-titlebar-style = "hidden";
      macos-window-shadow = true;
      macos-option-as-alt = "left";
      window-inherit-working-directory = false;
      window-padding-balance = true;
      window-width = 122;
      window-height = 30;
      window-padding-x = 6;
      window-padding-y = 6;
      # Quick Terminal
      keybind = "global:cmd+grave_accent=toggle_quick_terminal";
      quick-terminal-position = "right";
    };
  };
}
