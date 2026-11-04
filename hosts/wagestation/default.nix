{ ... }: {
  homebrew = {
    # /Applications is not writable here, so casks install under $HOME instead.
    caskArgs.appdir = "/Users/steven/Applications";

    onActivation = {
      # Upgrades need an elevation window to succeed, and software installed
      # out of band would not survive a zap.
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };
  };
}
