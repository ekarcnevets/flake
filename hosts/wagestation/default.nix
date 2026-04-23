{ ... }: {
  networking.hostName = "wagestation";

  homebrew.taps = [ "azure/functions" ];

  homebrew.brews = [
    "azure-cli"
    "azure/functions/azure-functions-core-tools@4"
  ];

  homebrew.casks = [
    "microsoft-teams"
  ];
}
