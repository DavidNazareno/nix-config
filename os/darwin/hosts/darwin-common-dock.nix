{ config, ... }:
{
  system.defaults.dock = {
    persistent-apps = [
      # === BROWSERS ===
      "/Applications/Arc.app"
      
      # === COMMUNICATION ===
      "/Applications/Discord.app"
      
      # === PRODUCTIVITY ===
      
      # === DEVELOPMENT ===
      "/Applications/Visual Studio Code.app"
      "/Applications/Zed.app"
      "/Applications/Ghostty.app"
      "/Applications/iTerm.app"
      "/Applications/OrbStack.app"
      "/Applications/DBeaver.app"
      "/Applications/Medis 2.app"
      "/Applications/DBngin.app"
      
      # === MEDIA ===
      
      # === UTILITIES ===
      "/Applications/Bitwarden.app"
      "/Applications/iStat Menus.app"
      "/Applications/OmniDiskSweeper.app"
      "/Applications/BalenaEtcher.app"
    ];
  };
}
