{
  description = "wagestation nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    claude-code-nix.url = "github:sadjow/claude-code-nix";
    codex-cli-nix.url = "github:sadjow/codex-cli-nix";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, claude-code-nix, codex-cli-nix }: {
    # Formatter for 'nix fmt'
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;

    darwinConfigurations."wagestation" = nix-darwin.lib.darwinSystem {
      modules = [
        ./modules/system
        home-manager.darwinModules.home-manager
        {
          nixpkgs.overlays = [
            claude-code-nix.overlays.default
            codex-cli-nix.overlays.default
          ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.steven = import ./modules/home;
        }
      ];
    };
  };
}
