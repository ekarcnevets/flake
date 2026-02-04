{ ... }: {
  homebrew = {
    enable = true;

    casks = [
      "1password"
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
