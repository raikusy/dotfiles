{
  description = "Darwin configuration";

  inputs = {
    # determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.819493.tar.gz";
    darwin.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2505.804391.tar.gz";
    # darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2505.804391.tar.gz";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    homebrew.url = "github:zhaofengli/nix-homebrew";
    # nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";

    # Formatter
    # alejandra.url = "github:kamadorueda/alejandra/3.1.0";
    # alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    darwin,
    home-manager,
    homebrew,
    # alejandra,
    # lix-module,
    ...
  }: let
    system = "aarch64-darwin";
    specialArgs = {
      inherit self system;
    };
  in {
    # formatter.aarch64-darwin = alejandra;
    darwinConfigurations.raikusy = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        # lix-module.nixosModules.default
        # determinate.darwinModules.default
        home-manager.darwinModules.home-manager
        homebrew.darwinModules.homebrew
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
          homebrew = {
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
