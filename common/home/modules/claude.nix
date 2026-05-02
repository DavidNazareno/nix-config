{ pkgs, lib, ... }:

{
  # Keep Claude setup manual and outside activation.
  # This avoids networked, stateful installs during home-manager switch.

  # Optional environment variables (extend if Claude CLI needs API keys, etc.)
  home.sessionVariables = { };

  home.file."bin/install-claude-code" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail
      export PATH="${pkgs.coreutils}/bin:${pkgs.curl}/bin:${pkgs.gnugrep}/bin:${pkgs.gnused}/bin:${pkgs.perl}/bin:${pkgs.jq}/bin:$PATH"
      curl -fsSL https://claude.ai/install.sh | ${pkgs.bash}/bin/bash
    '';
  };

  # Fish aliases (cc -> assumed 'claude-code' binary). Installation remains manual.
  programs.fish.shellAliases = {
    cc = "claude-code";  # Adjust if the final executable name differs
  };
}
