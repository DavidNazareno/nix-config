{ config, pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      init = {
        defaultBranch = "main";
      };
      merge = {
        conflictStyle = "diff3";
        tool = "meld";
      };
    };
  };

  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.lazygit = {
    enable = true;
  };
}