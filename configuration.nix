{ pkgs, self, ... }:
{
  environment.systemPackages = with pkgs; [
    # Add some essential packages
    coreutils
    curl
    git
  ];

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [
      "root"
      "raikusy"
      "@wheel"
    ];
    use-xdg-base-directories = true;
    accept-flake-config = true;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  users.users.raikusy = {
    home = "/Users/raikusy";
  };
}
