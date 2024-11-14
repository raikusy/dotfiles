{
  description = "Darwin configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      determinate,
      home-manager,
      darwin,
      nixpkgs,
      ...
    }:
    {
      darwinConfigurations = {
        raikusy = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            # Pass self as a module argument
            {
              _module.args = {
                inherit self;
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
            determinate.darwinModules.default
          ];
        };
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."raikusy".pkgs;
    };
}
