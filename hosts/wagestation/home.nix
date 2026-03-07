{ lib, pkgs, ... }: {
  home.packages = [ pkgs.vault ];

  targets.darwin.defaults.NSGlobalDomain.NSUserDictionaryReplacementItems = [
    { on = 1; replace = "@@"; "with" = "steven.crake@nscale.com"; }
  ];

  programs.git.settings.user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIByGzaN5IRi+ojvLIxREOr5Ovthegr8cGvqffdOb5dn";
  programs.git.includes = [
    { condition = "gitdir:/Users/steven/src/github.com/nscaledev/"; contents.user.email = "steven.crake@nscale.com"; }
    { condition = "gitdir:/Users/steven/src/github.com/stevencrake-nscale/"; contents.user.email = "steven.crake@nscale.com"; }
  ];

  home.file.".config/1Password/ssh/agent.toml".source = ./agent.toml;
  home.file.".ssh/github_ekarcnevets_wagestation_1pw.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIByGzaN5IRi+ojvLIxREOr5Ovthegr8cGvqffdOb5dn";
  home.file.".ssh/config".source = ./ssh-config;
  home.file.".ssh/allowed_signers".source = ./allowed-signers;

  # BetterDisplay settings for M4 14" + external monitor
  home.activation.importBetterDisplaySettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD /usr/bin/defaults import pro.betterdisplay.BetterDisplay "${../../files/betterdisplay/wagestation.plist}"
  '';
}
