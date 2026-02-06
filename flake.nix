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

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, claude-code-nix, codex-cli-nix }:
  let
    darwinSystem = "aarch64-darwin";

    mkDarwinSystem = { hostname, enableHomeManager ? true }:
      nix-darwin.lib.darwinSystem {
        system = darwinSystem;
        specialArgs = {
          inherit inputs;
          pkgs-unstable = import nixpkgs {
            system = darwinSystem;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/${hostname}
          ./modules/darwin.nix
          {
            nixpkgs.overlays = [
              claude-code-nix.overlays.default
              codex-cli-nix.overlays.default
            ];
          }
        ] ++ nixpkgs.lib.optionals enableHomeManager [
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.steven = import ./home/darwin.nix;
          }
        ];
      };
  in
  {
    # Formatter for 'nix fmt'
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;

    darwinConfigurations.wagestation = mkDarwinSystem { hostname = "wagestation"; };
  };
}
