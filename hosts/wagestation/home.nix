{ lib, ... }: {
  programs.git.includes = [
    {
      condition = "gitdir:/Users/steven/src/github.com/nscaledev/";
      path = "/Users/steven/src/github.com/nscaledev/.gitconfig";
    }
    {
      condition = "gitdir:/Users/steven/src/github.com/stevencrake-nscale/";
      path = "/Users/steven/src/github.com/stevencrake-nscale/.gitconfig";
    }
  ];

  home.file.".ssh/config".source = ./ssh-config;
  home.file.".ssh/allowed_signers".source = ./allowed-signers;

  # BetterDisplay settings for M4 14" + external monitor
  home.activation.importBetterDisplaySettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD /usr/bin/defaults import pro.betterdisplay.BetterDisplay "${../../files/betterdisplay/wagestation.plist}"
  '';
}
