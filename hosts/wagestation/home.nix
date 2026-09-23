{ lib, pkgs, ... }: {
  home.packages = [ pkgs.vault ];

  targets.darwin.defaults.NSGlobalDomain.NSUserDictionaryReplacementItems = [
    { on = 1; replace = "@@"; "with" = "steven.crake@nscale.com"; }
  ];

  programs.git.includes = [
    { condition = "gitdir:/Users/steven/src/github.com/nscaledev/"; contents.user.email = "steven.crake@nscale.com"; }
  ];

  # BetterDisplay settings for M4 14" + external monitor
  home.activation.importBetterDisplaySettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD /usr/bin/defaults import pro.betterdisplay.BetterDisplay "${../../files/betterdisplay/wagestation.plist}"
  '';
}
