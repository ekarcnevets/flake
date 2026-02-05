{ pkgs, ... }: {
  imports = [
    ./dev.nix
    ./ssh.nix
    ./ghostty.nix
    ./zed.nix
    ./aerospace.nix
  ];

  home.username = "steven";
  home.homeDirectory = "/Users/steven";
  home.stateVersion = "25.11";

  # Fonts
  home.packages = with pkgs; [
    nerd-fonts.blex-mono
  ];

  # Work-specific git config
  home.file."src/github.com/nscaledev/.gitconfig".source = ../../dotfiles/git/nscaledev.gitconfig;
  home.file."src/github.com/stevencrake-nscale/.gitconfig".source = ../../dotfiles/git/stevencrake-nscale.gitconfig;

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "kubectl"
      ];
      theme = ""; # Using Starship prompt
      custom = "$HOME/.oh-my-zsh/custom";
    };

    # Load custom zsh plugins from nix
    plugins = [
      {
        name = "zsh-vi-mode";
        src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
      }
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "you-should-use";
        src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
      }
    ];

    # Custom aliases
    shellAliases = {
      # Homebrew
      brewup = "brew upgrade --cask --greedy --verbose";

      # Git aliases (beyond oh-my-zsh)
      gfl = "git fetch && git pull --autostash";
      gdtl = "git difftool --no-prompt";
      gpot = "git push origin --tags";
      gbc = "git branch --show-current | tr -d '\\n' | pbcopy";
      gmlD = "gswm && gfl && gbgD";
      gbr = "gb -av --sort=-committerdate";

      # Kubernetes
      k = "kubectl";
      kdf = "kubectl diff -f";

      # Utilities
      ugrep = "grep -E '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'";
      mbtq = "make build && make test-unit && make quality";
      vim = "nvim --cmd \"set loadplugins\"";
    };

    sessionVariables = {
      # XDG Base Directory
      XDG_CONFIG_HOME = "$HOME/.config";

      # Python
      PIP_REQUIRE_VIRTUALENV = "true";

      # Go
      GOPATH = "$HOME/go";

      # Kubernetes
      KUBECTL_EXTERNAL_DIFF = "dyff between --omit-header --set-exit-code";

      # Docker/Testcontainers (for colima)
      DOCKER_HOST = "unix://$HOME/.config/colima/default/docker.sock";
      TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE = "/var/run/docker.sock";
      TESTCONTAINERS_RYUK_DISABLED = "true";
    };

    initContent = ''
      # Homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # zsh-vi-mode: Initialize when sourced
      ZVM_INIT_MODE=sourcing

      # you-should-use: Show all alias suggestions
      YSU_MODE=ALL

      # Completions
      if [[ ":$FPATH:" != *":/Users/steven/.zsh/completions:"* ]]; then
        export FPATH="/Users/steven/.zsh/completions:$FPATH"
      fi

      # fnm (Fast Node Manager) - replaces nvm
      eval "$(fnm env --use-on-cd)"

      # Initialize rustup with nightly if not configured
      if ! rustup show &>/dev/null; then
        rustup default nightly
      fi

      # Colima/Testcontainers dynamic host
      export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j 2>/dev/null | jq -r '.address' 2>/dev/null || echo "")

      # SSH keys
      ssh-add -A >/dev/null 2>&1

      # kubectl completion for k alias
      [[ $commands[kubectl] ]] && complete -o default -F __start_kubectl k

      # ripgrep->fzf->vim function
      rfv() (
        RELOAD='reload:rg --column --color=always --smart-case {q} || :'
        OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
                  nvim {1} +{2}
                else
                  nvim +cw -q {+f}
                fi'
        fzf --disabled --ansi --multi \
            --bind "start:$RELOAD" --bind "change:$RELOAD" \
            --bind "enter:become:$OPENER" \
            --bind "ctrl-o:execute:$OPENER" \
            --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
            --delimiter : \
            --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
            --preview-window '~4,+{2}+4/3,<80(up)' \
            --query "$*"
      )
    '';
  };
}
