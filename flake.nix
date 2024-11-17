{
  description = "Darwin configuration";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nix.url = "https://flakehub.com/f/DeterminateSystems/nix/2.0";
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/0.1.704822.tar.gz";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager.url = "github:nix-community/home-manager";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.2405.*";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      determinate,
      nix-darwin,
      home-manager,
      nix-homebrew,
    }:
    {
      darwinConfigurations.raikusy = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          determinate.darwinModules.default
          # (
          #   { pkgs, ... }:
          #   {
          #     imports = [
          #       nix.darwinModules.default
          #     ];
          #     # the rest of your configuration

          #   }
          # )

          # Pass self as a module argument
          {
            _module.args = {
              inherit self;
            };
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
          ./configuration.nix
          home-manager.darwinModules.home-manager
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
