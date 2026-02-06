{ ... }: {
  homebrew = {
    enable = true;

    taps = [
      "nikitabobko/tap"
    ];

    casks = [
      "1password"
      "aerospace"
      "arc"
      "ghostty"
      "linear-linear"
      "notion"
      "notion-calendar"
      "shottr"
      "slack"
      "spotify"
      "zed"
    ];

    masApps = {
      "Amphetamine" = 937984704;
    };

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
  };
}
