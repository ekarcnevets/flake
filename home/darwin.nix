{ pkgs, lib, ... }:

{
  imports = [
    ./home-manager.nix
    ./github.nix
  ];

  home.packages = import ../modules/common.nix { inherit pkgs; };

  # screencapture silently does nothing if its target directory is missing.
  home.activation.screenshotsDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/Screenshots"
  '';
}
