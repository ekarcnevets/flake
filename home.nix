{ pkgs, ... }: {
  imports = [
    ./dev.nix
    ./ssh.nix
    ./ghostty.nix
  ];

  home.username = "steven";
  home.homeDirectory = "/Users/steven";
  home.stateVersion = "24.05";

  # Work-specific git config
  home.file."src/github.com/nscaledev/.gitconfig".source = ./dotfiles/git/nscaledev.gitconfig;
  home.file."src/github.com/stevencrake-nscale/.gitconfig".source = ./dotfiles/git/stevencrake-nscale.gitconfig;

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    initContent = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
