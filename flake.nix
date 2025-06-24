{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    nix-homebrew,
    ...
  }: let
    system = "aarch64-darwin";
    specialArgs = {inherit self system inputs;};
  in {
    darwinConfigurations = {
      raikusy = darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.raikusy = ./home.nix;
          }
          {
            _module.args = {inherit self;};
            nixpkgs.overlays = [
              # Add ARM-specific optimizations
              (final: prev: {
                # Example: Override packages with ARM-optimized versions
                stdenv =
                  prev.stdenv
                  // {
                    isAarch64 = true;
                    isDarwin = true;
                  };
              })
            ];
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "raikusy";

              # Automatically migrate existing Homebrew installations
              autoMigrate = true;
            };
          }
        ];
      };
    };

    darwinPackages = self.darwinConfigurations."raikusy".pkgs;
  };
}
