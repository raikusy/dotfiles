{
  pkgs,
  config,
  ...
}:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  xdg.enable = true;
  home.username = "raikusy";
  home.homeDirectory = "/Users/raikusy";
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = false;

  home.packages = with pkgs; [
    # Shell and Core Utils
    zsh # Extended Bourne Shell with many improvements
    fish # Friendly Interactive Shell
    coreutils # GNU Core Utilities
    starship # Cross-shell prompt
    direnv # Environment switcher

    # Text Editors
    neovim # Hyperextensible Vim-based text editor

    # File Management and Navigation
    yazi # Terminal file manager
    eza # Modern replacement for ls
    fd # Simple, fast alternative to find
    bat # Cat clone with syntax highlighting
    zoxide # Smarter cd command
    kondo # Save disk space by cleaning unneeded files
    ox # Independent Rust text editor that runs in your terminal
    superfile # Supercharged file manager

    # Search and Filter
    ripgrep # Fast grep alternative
    fzf # Fuzzy finder

    # Development Tools
    git # Version control system
    nixd # Nix language server
    nixfmt-rfc-style # Nix code formatter
    fh # Nix package manager
    devenv # Development environments
    gh # GitHub CLI
    git-credential-manager # Git credential manager

    # Package Managers
    fnm # Fast Node.js version manager
    volta # JavaScript tool manager
    cargo # Rust package manager
    cargo-update # Update Rust packages

    # Programming Languages & Runtimes
    rustc # Rust compiler
    rustfmt # Rust formatter
    bun # All-in-one JavaScript runtime & toolkit
    deno # JavaScript/TypeScript runtime

    # Container & Virtualization
    docker # Container platform
    docker-compose # Multi-container Docker applications
    colima # Container runtime for macOS

    # Network Tools
    curl # Transfer data with URLs
    wget # Network file retriever

    # System Monitoring
    htop # Interactive process viewer
    mactop # macOS system monitor
    topgrade # System upgrade tool
    fastfetch # Fast fetch

    # Email
    neomutt # Terminal mail client

    # Misc Tools
    sherlock # Hunt down social media accounts

    # GUI Apps
    maccy # Clipboard manager
    # wezterm # WezTerm Terminal Emulator
    # arc-browser # Arc Browser
    # warp-terminal # Warp Terminal
    # raycast # Raycast

    # Fish Shell Plugins
    fishPlugins.forgit # Interactive git commands for fish
    fishPlugins.sponge # Fish integration for sponge
    fishPlugins.colored-man-pages
    fishPlugins.gruvbox
    fishPlugins.foreign-env
    fishPlugins.fzf-fish
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # add home-manager installs in $PATH
  # home.sessionVariables = {
  #   PATH = "$PATH:/Users/raikusy/.nix-profile/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/per-user/raikusy/profile/bin";
  # };

  # home.file = {
  #   # Add configurations one by one as you create them

  #   # Example: Once you have fish config:
  #   # ".config/fish" = {
  #   #   source = ./config/fish;
  #   #   recursive = true;
  #   # };

  #   # Example: Once you have starship config:
  #   ".config/starship.toml" = {
  #     source = ./config/starship/starship.toml;
  #   };

  #   # Git config (if you want to manage beyond what git program module provides)
  #   ".gitconfig" = {
  #     source = ./config/git/gitconfig;
  #   };

  #   # Add others as you create them
  # };

  # set a variable with value "/run/current-system"

  home.sessionVariables = {
    HOME = "/Users/${config.home.username}";
    EDITOR = "cursor";
    WORK = "${config.home.homeDirectory}/workspace";
    NIX_RUN_CS = "/run/current-system";
    NIX_PROFILE = "${config.home.sessionVariables.NIX_RUN_CS}/etc/profiles/per-user/${config.home.username}";
    NODE_OPTIONS = "--max-old-space-size=8192";
    BUN_INSTALL = "${config.home.homeDirectory}/.bun";
    VOLTA_HOME = "${config.home.homeDirectory}/.volta";
    GEM_HOME = "${config.home.homeDirectory}/.gem";
    DENO_INSTALL = "${config.home.homeDirectory}/.deno";
  };

  home.sessionPath = [
    "${config.home.sessionVariables.NIX_RUN_CS}/sw/bin"
    "${config.home.homeDirectory}/.nix-profile/bin"
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.gem/bin"
    "${config.home.homeDirectory}/.volta/bin"
    "${config.home.homeDirectory}/.deno/bin"
    "${config.home.homeDirectory}/.bun/bin"
    "${config.home.homeDirectory}/bin"
  ];

  home.file = {
    ".nix-profile" = {
      source = "${config.home.sessionVariables.NIX_PROFILE}";
      recursive = true;
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };

    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };

    # git = {
    #   enable = true;
    # };

    fish = {
      enable = true;

      # Add useful shell functions
      functions = {
        fish_greeting = "fastfetch"; # Disable greeting
        # Add more custom functions here
        dco = ''
          if type -q docker compose
            docker compose $argv
          else if type -q docker-compose
            docker-compose $argv
          else
            echo "docker compose or docker-compose not found"
            echo "Please install docker compose"
            echo "  \`brew install docker-compose\`"
          end
        '';
      };

      # Add more useful shell abbreviations
      shellAbbrs = {
        # Existing abbreviations
        npu = "nix-prefetch-url";
        nx = "nix --extra-experimental-features 'nix-command flakes'";

        # Additional useful ones
        drs = "darwin-rebuild switch";
        nfu = "nix flake update";
        nfui = "nix flake update --commit-lock-file";
      };

      # Add environment variables in a more organized way
      interactiveShellInit = ''
        # Existing initialization
        fh completion fish | source
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # Set fish colors to match your theme
        set -U fish_color_command blue
        set -U fish_color_param cyan
        set -U fish_color_error red

        # Additional useful settings
        set -U fish_features qmark-noglob
      '';

      plugins = [
        {
          name = "osx";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-osx";
            rev = "master";
            sha256 = "sha256-jSUIk3ewM6QnfoAtp16l96N1TlX6vR0d99dvEH53Xgw=";
          };
        }
        {
          name = "grc";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-grc";
            rev = "master";
            sha256 = "sha256-NQa12L0zlEz2EJjMDhWUhw5cz/zcFokjuCK5ZofTn+Q=";
          };
        }
        {
          name = "fisher";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "fisher";
            rev = "master";
            sha256 = "sha256-pR5RKU+zIb7CS0Y6vjx2QIZ8Iu/3ojRfAcAdjCOxl1U=";
          };
        }
        {
          name = "sudope";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-sudope";
            rev = "master";
            sha256 = "sha256-pD4rNuqg6TG22L9m8425CO2iqcYm8JaAEXIVa0H/v/U=";
          };
        }
        {
          name = "replay.fish";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "replay.fish";
            rev = "master";
            sha256 = "sha256-TzQ97h9tBRUg+A7DSKeTBWLQuThicbu19DHMwkmUXdg=";
          };
        }
        {
          name = "gitnow";
          src = pkgs.fetchFromGitHub {
            owner = "joseluisq";
            repo = "gitnow";
            rev = "master";
            sha256 = "sha256-PuorwmaZAeG6aNWX4sUTBIE+NMdn1iWeea3rJ2RhqRQ=";
          };
        }
        {
          name = "projectdo";
          src = pkgs.fetchFromGitHub {
            owner = "paldepind";
            repo = "projectdo";
            rev = "master";
            sha256 = "sha256-j8wR+s1cMVMcNYXcVxmSf14UuHsRNq112jrMmevN9Dg=";
          };
        }
        {
          name = "fish-abbreviation-tips";
          src = pkgs.fetchFromGitHub {
            owner = "gazorby";
            repo = "fish-abbreviation-tips";
            rev = "master";
            sha256 = "sha256-F1t81VliD+v6WEWqj1c1ehFBXzqLyumx5vV46s/FZRU=";
          };
        }
        {
          name = "fish-git-abbr";
          src = pkgs.fetchFromGitHub {
            owner = "lewisacidic";
            repo = "fish-git-abbr";
            rev = "master";
            sha256 = "sha256-6z3Wr2t8CP85xVEp6UCYaM2KC9PX4MDyx19f/wjHkb0=";
          };
        }
      ];
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "base16";
      };
    };

    eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      git = true;
      icons = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
        "--octal-permissions"
        "--classify=always"
        "--color=always"
        "--sort=modified"
        "--sort=type"
        "--git-repos-no-status"
      ];
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
    };

    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userName = "Rakibul Hasan";
      userEmail = "xenax.rakibul@gmail.com";

      extraConfig = {
        init.defaultBranch = "main";
        pull.ff = "false";
        pull.rebase = true;
        rebase.autoStash = true;
        core = {
          editor = "cursor";
          autocrlf = "input";
          whitespace = "trailing-space,space-before-tab";
        };
        gpg = {
          format = "ssh";
        };
        "gpg \"ssh\"" = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        };
        commit.gpgsign = true;
        alias = {
          up = "pull --rebase --autostash";
        };
        credential = {
          helper = "!gh auth git-credential";
        };
      };
    };

    tmux = {
      enable = true;
      shortcut = "a";
      terminal = "screen-256color";
      baseIndex = 1;
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        editor = "cursor";
      };
    };
  };

  xdg.configFile = {
    "starship.toml".source = ./config/starship/starship.toml;
    "git/config".source = ./config/git/gitconfig;
    # "fish/functions/dco.fish".source = ./config/fish/functions/dco.fish;
    "fish/conf.d/99-custom-abbr.fish".source = ./config/fish/conf.d/99-custom-abbr.fish;
  };
}
