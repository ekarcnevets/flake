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
  home.file."src/github.com/nscaledev/.gitconfig".text = ''
    [user]
      name = "Steven Crake"
      email = "steven.crake@nscale.com"
      signingkey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILoxhIV4lNUvgM/1ORLBrc+tmr7esOJqRGZWUShgRMfj

    [gpg]
      format = ssh

    [gpg "ssh"]
      program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"

    [commit]
      gpgsign = true

    [tag]
      gpgsign = true

    [url "git@github.com-nscale:"]
        insteadOf = git@github.com:
  '';

  home.file."src/github.com/stevencrake-nscale/.gitconfig".text = ''
    [user]
      name = "Steven Crake"
      email = "steven.crake@nscale.com"
      signingkey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILoxhIV4lNUvgM/1ORLBrc+tmr7esOJqRGZWUShgRMfj

    [gpg]
      format = ssh

    [gpg "ssh"]
      program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"

    [commit]
      gpgsign = true

    [tag]
      gpgsign = true

    [url "git@github.com-nscale:"]
        insteadOf = git@github.com:
  '';

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
