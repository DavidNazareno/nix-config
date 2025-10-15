{ pkgs, ... }:

{
  # Custom packages for macOS/Darwin
  
  # SSH connection manager
  sshpilot = import ./sshpilot.nix { 
    inherit pkgs; 
    inherit (pkgs) lib stdenv fetchurl undmg;
  };
  
  # Add more custom packages here as needed
  # example-app = import ./example-app.nix { inherit pkgs; };
}