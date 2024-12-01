{
  description = "Darwin configuration";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/0.1.704822.tar.gz";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.2405.*";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";

    # Formatter
    alejandra.url = "github:kamadorueda/alejandra/3.1.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    determinate,
    nix-darwin,
    home-manager,
    nix-homebrew,
    alejandra,
    nixpkgs-stable,
    ...
  }: let
    system = "aarch64-darwin";
    specialArgs = {
      inherit self system;
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
    formatter.aarch64-darwin = alejandra;
    darwinConfigurations.raikusy = nix-darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        determinate.darwinModules.default
        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
        ./configuration.nix
        {
          _module.args = {
            inherit self;
          };

          # System-wide overlays
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

            # Optional: Declarative tap management
            # taps = {
            #   "homebrew/homebrew-core" = homebrew-core;
            #   "homebrew/homebrew-cask" = homebrew-cask;
            #   "homebrew/homebrew-bundle" = homebrew-bundle;
            # };

            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            # mutableTaps = false;
          };
        }
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.raikusy = import ./home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."raikusy".pkgs;
  };
}
