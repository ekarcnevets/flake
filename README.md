# nix-darwin configuration

Declarative macOS configuration using nix-darwin, home-manager, and flakes.

## Prerequisites

1. **Determinate Nix**
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

2. **Homebrew** (for GUI applications)
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

## Setup

```bash
# Clone repository
git clone <repo-url> ~/.config/flake
cd ~/.config/flake

# Apply configuration
darwin-rebuild switch --flake .#wagestation

# Set up 1Password SSH agent (for git signing)
# Open 1Password → Settings → Developer → Enable SSH Agent

# Restart terminal
exec zsh
```

## Usage

```bash
make switch   # Apply configuration
make build    # Test without applying
make update   # Update flake inputs
make check    # Validate flake
make fmt      # Format nix files
```

## Structure

```
modules/
├── system/          # macOS system configuration
│   ├── default.nix  # Preferences, keyboard, dock
│   └── brew.nix     # GUI apps via homebrew
└── home/            # User environment
    ├── default.nix  # Home-manager entry point
    ├── dev.nix      # CLI tools, git, languages
    ├── ssh.nix      # SSH + 1Password
    └── ghostty.nix  # Terminal config

dotfiles/            # Config files managed by nix
├── 1password/       # SSH agent config
├── git/             # Work-specific git configs
├── ghostty/         # Terminal config + shaders
├── ssh/             # SSH config + signing keys
└── starship.toml    # Prompt configuration
```

## Configuration

**System:** See `modules/system/` for macOS preferences and homebrew apps

**Development:** See `modules/home/dev.nix` for CLI tools and language toolchains

**Git/SSH:** Configured for dual GitHub identities with 1Password signing

**Zsh:** Custom plugins, aliases, and starship prompt

## Adding Packages

**CLI tools:** Add to `modules/home/dev.nix` → `home.packages`

**GUI apps:** Add to `modules/system/brew.nix` → `homebrew.casks`

## Troubleshooting

**Git signing fails:** Ensure 1Password is running with SSH agent enabled

**Homebrew not found:** Restart terminal after initial activation

**Changes not applying:** Some preferences require logout/restart

## References

- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [home-manager](https://nix-community.github.io/home-manager/)
- [Going Immutable on macOS](https://yanncafe.com/post/going-immutable-on-macos/)
