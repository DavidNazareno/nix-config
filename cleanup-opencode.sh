#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)/common/home/modules/opencode"
rm -rf "$DIR/agents" "$DIR/runtime-config.json"
find "$DIR/agents-new" -name ".DS_Store" -delete 2>/dev/null || true
echo "✅ Limpio. Corre: darwin-rebuild switch --flake .#dnz-mac-mini"
rm -- "$0"
