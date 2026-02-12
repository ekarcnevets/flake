#!/bin/bash

# Toggle the current appearance
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'

# Re-enable auto switching
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true
