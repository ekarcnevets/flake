{ pkgs, ... }: {
  imports = [
    ./dev.nix
  ];

  home.username = "steven";
  home.homeDirectory = "/Users/steven";
  home.stateVersion = "24.05";

  # GUI applications
  home.packages = with pkgs; [
    _1password-gui
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
