{ ... }: {
  networking.hostName = "moon";

  homebrew = {
    casks = [
      "1password"
      "granola"
      "ngrok"
      "plex"
      "protonvpn"
      "screen-studio"
      "signal"
      "thebrowsercompany-dia"
      "whatsapp"
    ];

    masApps = {
      "Amphetamine" = 937984704;
    };
  };
}
