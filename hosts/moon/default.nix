{ ... }: {
  networking.hostName = "moon";

  homebrew.brews = [
    "vercel-cli"
  ];

  homebrew.casks = [
    "ngrok"
    "plex"
    "screen-studio"
    "signal"
    "tidal"
    "whatsapp"
  ];
}
