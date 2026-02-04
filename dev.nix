{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Core utilities
    coreutils
    curl
    wget

    # Version control
    git
    gh   # GitHub CLI
    tig  # Text-mode interface for git
    diff-so-fancy  # Better git diffs

    # JSON/YAML tools
    jq
    yq-go
    dyff  # YAML diff tool

    # Modern CLI replacements
    ripgrep  # better grep
    fd       # better find
    bat      # better cat
    eza      # better ls

    # Development tools
    claude-code
    codex
    fzf
    tree
    htop
    starship  # Shell prompt
    gnumake   # GNU Make build tool

    # Language toolchains
    rustup  # Rust toolchain manager
    go      # Go language
    fnm     # Fast Node Manager (nvm alternative, works with .nvmrc)
    python3  # Python interpreter
    uv       # Fast Python package installer

    # Kubernetes tools
    kubectl           # Kubernetes CLI
    kubernetes-helm   # Helm package manager
    helm-docs         # Generate docs from Helm charts
    k9s               # Terminal UI for Kubernetes
    kubie             # Kubernetes context/namespace switcher
  ];

  programs.git = {
    enable = true;
    # userName = "Your Name";
    # userEmail = "your.email@example.com";
  };
}
