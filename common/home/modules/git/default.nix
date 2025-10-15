{ config, pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      merge = {
        conflictStyle = "diff3";
        tool = "meld";
      };
    };
  };
}