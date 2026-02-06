{ config, lib, pkgs, pkgs-unstable, inputs, ... }: {
  networking.hostName = "wagestation";

  environment.systemPackages = with pkgs; [ ];

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
}
