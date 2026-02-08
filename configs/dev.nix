{ pkgs, ... }: {
  # Tig configuration
  home.file.".tigrc".source = ../files/tigrc;

  home.packages = with pkgs; [
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
    htop
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

    # Zsh plugins
    zsh-vi-mode
    zsh-fzf-tab
    zsh-you-should-use
  ];

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Steven Crake";
        email = "ekarcnevets@gmail.com";
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJOkkyB57orOxVPLOZ8YhMDTmvqj5b2fi0Cy5DRlwuEZ";
      };

      alias = {
        addm = "!git ls-files --deleted --modified --other --exclude-standard | fzf -0 -m --preview 'git diff --color=always {-1}' | xargs -r git add";
        addmp = "!git ls-files --deleted --modified --exclude-standard | fzf -0 -m --preview 'git diff --color=always {-1}' | xargs -r -o git add -p";
        cb = "!git branch --all | grep -v '^[*+]' | awk '{print $1}' | fzf -0 --preview 'git show --color=always {-1}' | sed 's/remotes\\/origin\\///g' | xargs -r git checkout";
        cs = "!git stash list | fzf -0 --preview 'git show --pretty=oneline --color=always --patch \"$(echo {} | cut -d: -f1)\"' | cut -d: -f1 | xargs -r git stash pop";
        db = "!git branch | grep -v '^[*+]' | awk '{print $1}' | fzf -0 --multi --preview 'git show --color=always {-1}' | xargs -r git branch --delete";
        Db = "!git branch | grep -v '^[*+]' | awk '{print $1}' | fzf -0 --multi --preview 'git show --color=always {-1}' | xargs -r git branch --delete --force";
        ds = "!git stash list | fzf -0 --preview 'git show --pretty=oneline --color=always --patch \"$(echo {} | cut -d: -f1)\"' | cut -d: -f1 | xargs -r git stash drop";
        edit = "!git ls-files --modified --other --exclude-standard | sort -u | fzf -0 --multi --preview 'git diff --color {}' | xargs -r $EDITOR -p";
        fixup = "!git log --oneline --no-decorate --no-merges | fzf -0 --preview 'git show --color=always --format=oneline {1}' | awk '{print $1}' | xargs -r git commit --fixup";
        resetm = "!git diff --name-only --cached | fzf -0 -m --preview 'git diff --color=always {-1}' | xargs -r git reset";
      };

      gpg = {
        format = "ssh";
        ssh = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          allowedSignersFile = "~/.ssh/allowed_signers";
        };
      };

      commit = {
        gpgsign = true;
        verbose = true;
      };

      tag = {
        sort = "version:refname";
        gpgsign = true;
      };

      includeIf."gitdir:/Users/steven/src/github.com/nscaledev/".path = "/Users/steven/src/github.com/nscaledev/.gitconfig";
      includeIf."gitdir:/Users/steven/src/github.com/stevencrake-nscale/".path = "/Users/steven/src/github.com/stevencrake-nscale/.gitconfig";

      column.ui = "auto";
      branch.sort = "-committerdate";
      init.defaultBranch = "main";

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
        tool = "zed";
      };

      difftool."zed".cmd = "zed --wait --diff \"$LOCAL\" \"$REMOTE\"";

      merge = {
        tool = "zed";
        conflictstyle = "zdiff3";
      };

      mergetool."zed" = {
        cmd = "zed --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"";
        trustExitCode = true;
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      fetch = {
        prune = true;
        prunetags = false;
        all = true;
      };

      help.autocorrect = "prompt";

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      core = {
        eol = "lf";
        autocrlf = "input";
        excludesfile = "~/.gitignore";
        pager = "diff-so-fancy | less --tabs=4 -R";
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      pull.rebase = true;

      "diff-so-fancy" = {
        markEmptyLines = false;
        stripLeadingSymbols = false;
      };

      "url \"ssh://git@github.com/\"" = {
        insteadOf = [ "https://github.com/" "git://github.com/" ];
      };
    };
  };
}
