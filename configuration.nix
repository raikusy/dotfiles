{self, ...}: {
  # nix.settings = {
  #   # Necessary for using flakes on this system.
  #   experimental-features = "nix-command flakes";
  #   trusted-users = [
  #     "root"
  #     "raikusy"
  #     "@wheel"
  #   ];
  #   use-xdg-base-directories = true;
  #   accept-flake-config = true;
  #   sandbox = false;
  #   allowed-users = ["@wheel"];
  #   trusted-substituters = [
  #     "https://cache.nixos.org"
  #     "https://nix-community.cachix.org"
  #   ];
  # };
  nix.channel.enable = false;

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
      allowUnsupportedSystem = true;
    };
  };

  # System-wide environment variables
  environment = {
    systemPackages = [];
    # systemPath = ["/opt/homebrew/bin"];
    pathsToLink = ["/Applications"];

    # Better defaults for macOS
    variables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      EDITOR = "cursor";
      VISUAL = "cursor";
    };
  };

  homebrew = {
    enable = true;
    brews = [
      "composer"
    ];
    casks = [
      "ghostty"
      "1password-cli"
      "hammerspoon"
      "miniconda"
      "visual-studio-code"
      "warp"
      "font-symbols-only-nerd-font"
      "gitify"
      "insomnia"
      "orbstack"
      "vlc"
    ];
  };

  # System settings and preferences
  system = {
    # keyboard = {
    #   enableKeyMapping = true;
    #   remapCapsLockToEscape = true;
    # };
    primaryUser = "raikusy";
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Always";
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        _HIHideMenuBar = false;
      };
      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
      };
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
        CreateDesktop = false;
      };
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };

  # Security settings
  security = {
    pam.services.sudo_local.touchIdAuth = true;
  };

  # Services configuration
  # services = {
  # yabai = {
  #   enable = true;
  #   enableScriptingAddition = true;
  #   config = {
  #     layout = "bsp";
  #     auto_balance = "on";
  #     window_placement = "second_child";
  #     window_gap = 8;
  #   };
  # };
  # skhd = {
  #   enable = true;
  #   skhdConfig = ''
  #     # Toggle window split type
  #     alt - e : yabai -m window --toggle split
  #     alt - f : yabai -m window --toggle float
  #     alt - t : yabai -m window --toggle native-fullscreen

  #     # Focus window
  #     alt - h : yabai -m window --focus west
  #     alt - j : yabai -m window --focus south
  #     alt - k : yabai -m window --focus north
  #     alt - l : yabai -m window --focus east
  #   '';
  # };
  # };

  # Nix configuration
  nix = {
    enable = false;
    # channel = {
    #   enable = false;
    # };
    # gc = {
    #   automatic = true;
    #   interval = { Weekday = 0; Hour = 0; Minute = 0; };
    #   options = "--delete-older-than 7d";
    # };
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        "raikusy"
        "@wheel"
      ];
      use-xdg-base-directories = true;
      accept-flake-config = true;
      sandbox = false;
      allowed-users = ["@wheel"];
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      max-jobs = "auto";
      cores = 0;
      extra-experimental-features = [
        "recursive-nix"
        "ca-derivations"
      ];
      extra-trusted-substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      keep-outputs = true;
      keep-derivations = true;
    };
  };

  users.users.raikusy = {
    home = "/Users/raikusy";
  };
}
