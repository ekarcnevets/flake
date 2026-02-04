{ pkgs, ... }: {
  # Let Determinate Nix handle Nix configuration
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # Define the user
  users.users.steven = {
    home = "/Users/steven";
  };

  # Primary user for system preferences
  system.primaryUser = "steven";

  # System preferences
  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      persistent-apps = [];
      persistent-others = [];
      show-recents = false;
    };

    # Keyboard settings
    NSGlobalDomain = {
      # Disable autocorrect
      NSAutomaticSpellingCorrectionEnabled = false;
      # Function keys as standard function keys
      "com.apple.keyboard.fnState" = true;
    };

    # Disable Siri
    CustomUserPreferences = {
      "com.apple.Siri" = {
        "UAProfileCheckingStatus" = 0;
        "siriEnabled" = 0;
      };
    };
  };

  # Remap Caps Lock to Control
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  system.stateVersion = 5;
}
