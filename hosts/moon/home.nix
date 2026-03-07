{ lib, ... }: {
  targets.darwin.defaults.NSGlobalDomain.NSUserDictionaryReplacementItems = [
    { on = 1; replace = "@@"; "with" = "ekarcnevets@gmail.com"; }
  ];
  home.file.".config/1Password/ssh/agent.toml".source = ./agent.toml;
  home.file.".ssh/github_ekarcnevets_moon_1pw.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJOkkyB57orOxVPLOZ8YhMDTmvqj5b2fi0Cy5DRlwuEZ";
  home.file.".ssh/config".source = ./ssh-config;
  home.file.".ssh/allowed_signers".source = ./allowed-signers;

  # BetterDisplay settings for M3 16" + external monitor
  home.activation.importBetterDisplaySettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD /usr/bin/defaults import pro.betterdisplay.BetterDisplay "${../../files/betterdisplay/moon.plist}"
  '';
}
