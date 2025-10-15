{ 
  config, 
  lib, 
  pkgs, 
  ... 
}: 
let 
  inherit (lib) mkIf mkEnableOption; 

  cfg = config.programs.sketchybar; 
in 
{ 
  options.programs.sketchybar = { 
    enable = mkEnableOption "sketchybar desktop bar"; 
  }; 

  config = mkIf cfg.enable { 
    environment.systemPackages = with pkgs; [ 
      sketchybar 
    ]; 

    # Copy the existing sketchybar configuration
    environment.etc."sketchybar" = {
      source = ./.;
      recursive = true;
    };

    # Create the main sketchybarrc that uses the Lua configuration
    environment.etc."sketchybar/sketchybarrc" = {
      text = ''
        #!/usr/bin/env lua

        -- Add the sketchybar module to the package cpath
        package.cpath = package.cpath .. ";${pkgs.sketchybar}/lib/lua/5.4/?.so"

        -- Load the existing Lua configuration
        dofile("/etc/sketchybar/init.lua")
      '';
      mode = "0755";
    };
  }; 
}
