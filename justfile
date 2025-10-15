# Build the system config and switch to it when running `just` with no args
default: switch

hostname := `hostname | cut -d "." -f 1`

### macOS (nix-darwin)
# Build the nix-darwin system configuration without switching to it
[macos]
build target_host=hostname flags="":
  @echo "Building nix-darwin config..."
  nix --extra-experimental-features 'nix-command flakes' build ".#darwinConfigurations.{{target_host}}.system" {{flags}}

# Build the nix-darwin config with the --show-trace flag set
[macos]
trace target_host=hostname: (build target_host "--show-trace")

# Build the nix-darwin configuration and switch to it
[macos]
switch target_host=hostname: (build target_host)
  @echo "Switching to new config for {{target_host}}"
  sudo ./result/sw/bin/darwin-rebuild switch --flake ".#{{target_host}}"

# Clean up old generations (keep last 5)
[macos]
clean:
  @echo "Cleaning up old generations..."
  sudo nix-collect-garbage --delete-older-than 30d
  sudo nix-store --gc

# Update flake inputs
[macos]
update:
  @echo "Updating flake inputs..."
  nix flake update

# Show system info
[macos]
info target_host=hostname:
  @echo "System info for {{target_host}}:"
  nix --extra-experimental-features 'nix-command flakes' eval ".#darwinConfigurations.{{target_host}}.system" --apply 'sys: sys.config.system.stateVersion'

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

