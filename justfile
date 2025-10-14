# Build the system config and switch to it when running `just` with no args
default: switch

hostname := `hostname | cut -d "." -f 1`

### macos
# Build the nix-darwin system configuration without switching to it
[macos]
build target_host=hostname flags="":
  @echo "Building nix-darwin config..."
  nix --extra-experimental-features 'nix-command flakes'  build ".#darwinConfigurations.{{target_host}}.system" {{flags}}

# Build the nix-darwin config with the --show-trace flag set
[macos]
trace target_host=hostname: (build target_host "--show-trace")

# Build the nix-darwin configuration and switch to it
[macos]
switch target_host=hostname: (build target_host)
  @echo "switching to new config for {{target_host}}"
  sudo ./result/sw/bin/darwin-rebuild switch --flake ".#{{target_host}}"

### linux (NixOS)
# Build the NixOS configuration without switching to it
[linux]
build target_host=hostname flags="":
	nixos-rebuild build --flake .#{{target_host}} {{flags}}

# Build the NixOS config with the --show-trace flag set
[linux]
trace target_host=hostname: (build target_host "--show-trace")

# Build the NixOS configuration and switch to it.
[linux]
switch target_host=hostname:
  sudo nixos-rebuild switch --flake .#{{target_host}}

### home-manager (Ubuntu/Linux with Nix)
# Build Home Manager configuration without switching to it
home-build user_host="davidnazareno@dnz-linux-lenovo" flags="":
  @echo "Building Home Manager config for {{user_host}}..."
  nix --extra-experimental-features 'nix-command flakes' build ".#homeConfigurations.{{user_host}}.activationPackage" {{flags}}

# Build Home Manager config with the --show-trace flag set
home-trace user_host="davidnazareno@dnz-linux-lenovo": (home-build user_host "--show-trace")

# Build and switch to Home Manager configuration
home-switch user_host="davidnazareno@dnz-linux-lenovo":
  @echo "Switching to Home Manager config for {{user_host}}..."
  home-manager switch --flake ".#{{user_host}}"

## colmena
cbuild:
  colmena build

capply:
  colmena apply

# Update flake inputs to their latest revisions
update:
  nix flake update

# Check flake configuration for errors
check:
  @echo "Checking flake configuration..."
  nix flake check

## remote nix vm installation
install IP:
  ssh -o "StrictHostKeyChecking no" nixos@{{IP}} "sudo bash -c '\
    nix-shell -p git --run \"cd /root/ && \
    if [ -d \"nix-config\" ]; then \
        rm -rf nix-config; \
    fi && \
    git clone https://github.com/ironicbadger/nix-config.git && \
    cd nix-config/lib/install && \
    sh install-nix.sh\"'"

## ubuntu nix installation
install-ubuntu:
  @echo "Installing Nix and Home Manager on Ubuntu..."
  @echo "Please follow the instructions in install-ubuntu-nix.md"
  @echo "Or run the following commands manually:"
  @echo "1. Install Nix: sh <(curl -L https://nixos.org/nix/install) --daemon"
  @echo "2. Enable flakes: mkdir -p ~/.config/nix && echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf"
  @echo "3. Clone this repo and run: home-manager switch --flake .#davidnazareno@dnz-linux-lenovo"


# Garbage collect old OS generations and remove stale packages from the nix store
gc:
  nix-collect-garbage -d
  nix-collect-garbage --delete-older-than 7d
  nix-store --gc

## manual command for initial bootstrapping
## sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
## nix --extra-experimental-features 'nix-command flakes' run nixpkgs#just

