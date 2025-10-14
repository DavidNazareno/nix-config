{ pkgs, ... }:

{

  # SSH connection manager
  sshpilot = import ./sshpilot.nix { 
    inherit pkgs; 
    inherit (pkgs) lib stdenv fetchurl dpkg autoPatchelfHook;
  };
  
  # Add more custom packages here as needed
  # example-app = import ./example-app.nix { inherit pkgs; };
}