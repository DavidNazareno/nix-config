{ pkgs, lib, unstablePkgs, ... }:

{
  # OpenCode via nixpkgs-unstable (auto-updated, no curl scripts)
  home.packages = [
    unstablePkgs.opencode
    pkgs.gh
  ];

  # GitHub CLI
  programs.gh = {
    enable = true;
    settings = {
      version = "1";
    };
  };

  # Install headroom (context compression MCP — 60-95% token savings on tool outputs)
  home.activation.installHeadroom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if ! command -v headroom &>/dev/null; then
      $DRY_RUN_CMD ${pkgs.uv}/bin/uv tool install "headroom-ai[mcp,ml]" --quiet || true
    fi
  '';

  # Config files
  home.file.".config/opencode/opencode.json".source = ./opencode/opencode.json;
  home.file.".config/opencode/themes/gentleman.json".source = ./opencode/themes/gentleman.json;
  home.file.".config/opencode/agents" = {
    source = ./opencode/agents;
    recursive = true;
  };
  home.file.".config/opencode/skills" = {
    source = ./opencode/skills;
    recursive = true;
  };

  # Shell aliases
  programs.nushell.shellAliases.opencode-config = "nvim ~/.config/opencode/opencode.json";
  programs.fish.shellAliases.oc = "opencode";
}
