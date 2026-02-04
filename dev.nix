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

    # JSON/YAML tools
    jq
    yq-go

    # Modern CLI replacements
    ripgrep  # better grep
    fd       # better find
    bat      # better cat
    eza      # better ls

    # Development tools
    claude-code
    fzf
    tree
    htop

    # Add language-specific tools as needed:
    # nodejs
    # python3
    # rustc
    # go
  ];

  programs.git = {
    enable = true;
    # userName = "Your Name";
    # userEmail = "your.email@example.com";
  };
}
