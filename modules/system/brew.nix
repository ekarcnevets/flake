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
      "slack"
      "spotify"
      "zed"
    ];

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
  };
}
