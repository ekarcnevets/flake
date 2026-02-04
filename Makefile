.PHONY: switch build update clean check fmt help

# Default target
help:
	@echo "Available targets:"
	@echo "  make switch  - Build and activate the configuration"
	@echo "  make build   - Build the configuration without activating"
	@echo "  make update  - Update flake inputs"
	@echo "  make clean   - Remove build artifacts"
	@echo "  make check   - Check flake for errors"
	@echo "  make fmt     - Format nix files"
	@echo "  make help    - Show this help message"

# Build and activate the configuration
switch:
	darwin-rebuild switch --flake .#wagestation

# Build without activating
build:
	darwin-rebuild build --flake .#wagestation

# Update flake inputs
update:
	nix flake update

# Remove build artifacts
clean:
	rm -rf result result-*

# Check flake for errors
check:
	nix flake check

# Format nix files
fmt:
	nix fmt
