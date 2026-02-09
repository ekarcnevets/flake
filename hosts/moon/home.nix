{ lib, ... }: {
  home.file.".ssh/config".source = ./ssh-config;
  home.file.".ssh/allowed_signers".source = ./allowed-signers;

  # BetterDisplay settings for M3 16" + external monitor
  home.activation.importBetterDisplaySettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD /usr/bin/defaults import pro.betterdisplay.BetterDisplay "${../../files/betterdisplay/moon.plist}"
  '';
}
