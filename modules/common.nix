{ config, pkgs, pkgs-unstable, ... }:

{
  # Packages available to all hosts
  shared = with pkgs; [
    # Core utilities
    coreutils
    curl
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
    bat # better cat
    eza # better ls

    # Development tools
    fzf
    tree
    btop # Better system monitor than htop
    biome # Fast formatter for JS/TS/JSON/CSS
    gnumake # GNU Make build tool

    # Language toolchains
    rustup # Rust toolchain manager
    go # Go language
    fnm # Fast Node Manager (nvm alternative, works with .nvmrc)
    pnpm # Fast Node package manager
    python3 # Python interpreter
    uv # Fast Python package installer

    # Kubernetes tools
    kubectl # Kubernetes CLI
    kubernetes-helm # Helm package manager
    helm-docs # Generate docs from Helm charts
    k9s # Terminal UI for Kubernetes
    kubie # Kubernetes context/namespace switcher
    teleport # Teleport shell (tsh) for secure access
  ];

  # Home-manager specific packages
  home = with pkgs; [
    claude-code
    codex
    zsh-vi-mode
    zsh-fzf-tab
    zsh-you-should-use
    zsh-z # Directory jumping
  ];
}
