{ ... }: {
  networking.hostName = "wagestation";

  homebrew.taps = [ "azure/functions" ];

  homebrew.brews = [
    "azure-cli"
    "azure-functions-core-tools"
  ];

  homebrew.casks = [
    "microsoft-teams"
    "ngrok"
  ];
}
