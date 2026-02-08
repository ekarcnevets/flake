# nix-darwin configuration

Declarative macOS configuration using nix-darwin, home-manager, and flakes.

## Prerequisites

1. [Determinate Nix](https://install.determinate.systems/nix)
2. [Homebrew](https://brew.sh/) (for GUI applications)

## Setup

```bash
make init     # Set up git hooks
make switch   # Apply configuration
exec zsh      # Restart shell to pick up changes
```

## Usage

```bash
make switch   # Apply configuration
make build    # Test without applying
make update   # Update flake inputs
make check    # Validate flake
make fmt      # Format nix files
```

## Adding Packages

**CLI tools:** Add to `modules/common.nix`

**GUI apps:** Add to `modules/darwin.nix` under `homebrew.casks`

**Language toolchains:** Use per-project nix dev shells instead of global installs.

## Troubleshooting

**Git signing fails:** Ensure 1Password is running with SSH agent enabled

**Homebrew not found:** Restart terminal after initial activation

**Changes not applying:** Some preferences require logout/restart

## References

- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [home-manager](https://nix-community.github.io/home-manager/)
