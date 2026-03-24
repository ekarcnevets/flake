{ ... }: {
  networking.hostName = "wagestation";

  homebrew.taps = [ "azure/functions" ];

  homebrew.brews = [
    "azure-cli"
    "azure/functions/azure-functions-core-tools@4"
    "vercel-cli"
  ];

  homebrew.casks = [
    "microsoft-teams"
    "ngrok"
  ];
}
