{ ... }: {
  homebrew = {
    enable = true;

    casks = [
      "1password"
      "ghostty"
    ];

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
  };
}
