{ config, pkgs, lib, ... }:
{
  # Global CLAUDE.md — instrucciones para todas las sesiones de Claude Code
  home.file.".claude/CLAUDE.md".source = ./claude-code/CLAUDE.md;

  # Slash commands — /dev-fast, /dev, /dev-expert, /reviewer, /debugger
  home.file.".claude/commands/dev-fast.md".source  = ./claude-code/commands/dev-fast.md;
  home.file.".claude/commands/dev.md".source       = ./claude-code/commands/dev.md;
  home.file.".claude/commands/dev-expert.md".source = ./claude-code/commands/dev-expert.md;
  home.file.".claude/commands/reviewer.md".source  = ./claude-code/commands/reviewer.md;
  home.file.".claude/commands/debugger.md".source  = ./claude-code/commands/debugger.md;

  # MCP servers — mismos que OpenCode
  home.file.".claude/settings.json".source = ./claude-code/settings.json;
}
