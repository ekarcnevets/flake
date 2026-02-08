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
      persistent-apps = [ ];
      persistent-others = [ ];
      show-recents = false;
    };

    # Finder settings
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
    };

    # Keyboard and system settings
    NSGlobalDomain = {
      # Disable autocorrect
      NSAutomaticSpellingCorrectionEnabled = false;
      # Function keys as standard function keys
      "com.apple.keyboard.fnState" = true;
      # Full keyboard access for all controls
      AppleKeyboardUIMode = 3;
      # Disable press-and-hold for keys (enables key repeat for vim)
      ApplePressAndHoldEnabled = false;
      # Fast key repeat
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      # Drag windows from anywhere with modifier key
      NSWindowShouldDragOnGesture = true;
    };

    # Disable Siri
    CustomUserPreferences = {
      "com.apple.Siri" = {
        "UAProfileCheckingStatus" = 0;
        "siriEnabled" = 0;
      };
      # Disable screenshot keyboard shortcuts
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          "28" = { enabled = false; }; # Save picture of screen as a file (⇧⌘3)
          "29" = { enabled = false; }; # Copy picture of screen to clipboard (⌃⇧⌘3)
          "30" = { enabled = false; }; # Save picture of selected area as a file (⇧⌘4)
          "31" = { enabled = false; }; # Copy picture of selected area to clipboard (⌃⇧⌘4)
        };
      };
    };
  };

  # Remap Caps Lock to Control
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  # Homebrew configuration
  homebrew = {
    enable = true;

    taps = [
      "nikitabobko/tap"
    ];

    casks = [
      "1password"
      "aerospace"
      "arc"
      "claude-code"
      "codex"
      "ghostty"
      "linear-linear"
      "notion"
      "notion-calendar"
      "shottr"
      "slack"
      "spotify"
      "zed"
    ];

    masApps = {
      "Amphetamine" = 937984704;
    };

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
  };

  system.stateVersion = 5;
}
