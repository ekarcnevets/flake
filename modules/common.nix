{ pkgs, ... }:

with pkgs; [
  # Core utilities
  _1password-cli # 1Password CLI
  coreutils
  curl
  openssl
  wget

  # Version control
  git
  gh # GitHub CLI
  tig # Text-mode interface for git
  diff-so-fancy # Better git diffs

  # JSON/YAML tools
  jq
  yq-go
  dyff # YAML diff tool

  # Modern CLI replacements
  ripgrep # better grep
  fd # better find
  sd # better sed
  bat # better cat
  eza # better ls

  # Development tools
  fzf
  gum # Charm TUI components (used by defaults-to-nix)
  tree
  btop # Better system monitor than htop
  biome # Fast formatter for JS/TS/JSON/CSS
  gnumake # GNU Make build tool

  # System Python (for system scripts and tools)
  python3

  # Container tools
  colima # Container runtime for macOS
  docker # Docker CLI
  docker-compose # Docker Compose CLI

  # Kubernetes tools
  kubectl # Kubernetes CLI
  kubernetes-helm # Helm package manager
  helm-docs # Generate docs from Helm charts
  k9s # Terminal UI for Kubernetes
  kubie # Kubernetes context/namespace switcher
  teleport # Teleport shell (tsh) for secure access

  # Zsh plugins
  zsh-vi-mode
  zsh-fzf-tab
  zsh-you-should-use
  zsh-z # Directory jumping
]
