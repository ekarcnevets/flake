{ lib, pkgs, ... }: {
  home.packages = [ pkgs.vault ];

  # Work address everywhere on this machine. A later include wins when both match,
  # so this checkout stays on the personal address. Moon keeps the personal default.
  programs.git.includes = [
    { condition = "gitdir:/Users/steven/"; contents.user.email = "steven.crake@nscale.com"; }
    { condition = "gitdir:/Users/steven/src/github.com/ekarcnevets/flake/"; contents.user.email = "ekarcnevets@gmail.com"; }
  ];

  # BetterDisplay settings for M4 14" + external monitor
  home.activation.importBetterDisplaySettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD /usr/bin/defaults import pro.betterdisplay.BetterDisplay "${../../files/betterdisplay/wagestation.plist}"
  '';
}
