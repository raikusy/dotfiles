{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    # pkgs.zsh
    # pkgs.fish
    # pkgs.vim
    # pkgs.git
    # pkgs.curl
    # pkgs.wget
    # pkgs.ripgrep
    # pkgs.fzf
    # pkgs.lsd
    # pkgs.yazi
    # pkgs.bat
    # pkgs.zoxide
    # pkgs.starship
    # pkgs.nixfmt-rfc-style
    # pkgs.rustc
    # pkgs.cargo
    # pkgs.rustfmt
    # pkgs.direnv
    # pkgs.colima
    # pkgs.devenv
    # pkgs.nixd
    # pkgs.nil
  ];

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  # Installs a version of nix, that dosen't need "experimental-features = nix-command flakes" in /etc/nix/nix.conf
  # services.nix-daemon.package = pkgs.nixFlakes;
  services.activate-system.enable = true;
  nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Programs
  programs = {
    direnv.enable = true;
    zsh = {
      enable = true;
      enableFastSyntaxHighlighting = true;
      enableFzfCompletion = true;
    };
    fish = {
      enable = true;
      loginShellInit = ''
        set --universal ME (whoami)
        fish_add_path /etc/profiles/per-user/$ME/bin/
        eval (${pkgs.starship}/bin/starship init fish)
      '';
    };
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = config.rev or config.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
  };

  security.pam.enableSudoTouchIdAuth = true;

  users.users.raikusy = {
    home = "/Users/raikusy";
  };
}
