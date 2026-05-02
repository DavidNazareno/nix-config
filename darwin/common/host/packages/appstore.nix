{ inputs, outputs, config, lib, hostname, system, username, pkgs, unstablePkgs, constants, ... }:

{
  homebrew.masApps = {
    #"Amphetamine" = 937984704;
    #"Poolsuite FM" = 1514817810;
    # "WebSSH" = 497714887;  # Keep MAS apps optional; failed installs should not block system switch
  };
}
