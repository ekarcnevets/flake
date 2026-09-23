{ pkgs, ... }:

{
  imports = [
    ./home-manager.nix
    ./github.nix
  ];

  home.packages = import ../modules/common.nix { inherit pkgs; };
}
