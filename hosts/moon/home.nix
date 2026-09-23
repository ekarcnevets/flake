{ lib, ... }: {
  targets.darwin.defaults.NSGlobalDomain.NSUserDictionaryReplacementItems = [
    { on = 1; replace = "@@"; "with" = "ekarcnevets@gmail.com"; }
  ];
  # BetterDisplay settings for M3 16" + external monitor
  home.activation.importBetterDisplaySettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD /usr/bin/defaults import pro.betterdisplay.BetterDisplay "${../../files/betterdisplay/moon.plist}"
  '';
}
