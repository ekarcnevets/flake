{ config, lib, pkgs, pkgs-unstable, inputs, ... }: {
  networking.hostName = "moon";
  environment.systemPackages = with pkgs; [ ];
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  homebrew.casks = [
    "plex"
    "screen-studio"
    "signal"
    "tidal"
    "whatsapp"
  ];
}
