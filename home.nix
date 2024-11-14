{ pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "raikusy";
  home.homeDirectory = "/Users/raikusy";

  home.packages = with pkgs; [
    # Shell and Core Utils
    zsh # Extended Bourne Shell with many improvements
    fish # Friendly Interactive Shell
    coreutils # GNU Core Utilities
    starship # Cross-shell prompt
    direnv # Environment switcher

    # Text Editors
    neovim # Hyperextensible Vim-based text editor
    helix # Post-modern modal text editor

    # File Management and Navigation
    yazi # Terminal file manager
    lsd # Modern ls alternative
    eza # Modern replacement for ls
    fd # Simple, fast alternative to find
    bat # Cat clone with syntax highlighting
    zoxide # Smarter cd command
    kondo # Save disk space by cleaning unneeded files

    # Search and Filter
    ripgrep # Fast grep alternative
    fzf # Fuzzy finder

    # Development Tools
    git # Version control system
    nixd # Nix language server
    nixfmt-rfc-style # Nix code formatter
    fh # Nix package manager
    aider-chat # AI coding assistant
    devenv # Development environments
    gh # GitHub CLI
    git-credential-manager # Git credential manager

    # Package Managers
    fnm # Fast Node.js version manager
    volta # JavaScript tool manager
    bun # All-in-one JavaScript runtime & toolkit
    cargo # Rust package manager
    cachix # Nix binary cache hosting

    # Programming Languages & Runtimes
    rustc # Rust compiler
    rustfmt # Rust formatter
    deno # JavaScript/TypeScript runtime

    # Container & Virtualization
    docker # Container platform
    docker-compose # Multi-container Docker applications
    colima # Container runtime for macOS

    # Network Tools
    curl # Transfer data with URLs
    wget # Network file retriever
    whois # Domain information groper

    # System Monitoring
    htop # Interactive process viewer
    mactop # macOS system monitor
    topgrade # System upgrade tool

    # Email
    neomutt # Terminal mail client

    # Misc Tools
    pls # Collaborative shell command syntax fixer
    sherlock # Hunt down social media accounts
    ox # Terminal hex viewer

    # Fish Shell Plugins
    fishPlugins.fzf # Fish integration for fzf
    fishPlugins.git-abbr # Git abbreviations for fish
    fishPlugins.forgit # Interactive git commands for fish

    # GUI Apps
    # wezterm # WezTerm Terminal Emulator
    # arc-browser # Arc Browser
    # warp-terminal # Warp Terminal
    # raycast # Raycast

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

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };

    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };

    fish = {
      enable = true;

      # Environment variables
      shellInit = ''
        # Universal exports
        set --universal --export ME (whoami)
        set --universal --export HOME /Users/$ME

        # Project related
        set --global --export WORK $HOME/workspace
        set --global --export EDITOR cursor

        # Homebrew
        set --global --export HOMEBREW_PREFIX /opt/homebrew
        set --global --export HOMEBREW_CELLAR /opt/homebrew/Cellar
        set --global --export HOMEBREW_REPOSITORY /opt/homebrew

        # Package managers
        set --global --export GEM_HOME "$HOME/.gem"
        set --global --export DENO_INSTALL $HOME/.deno
        set --global --export NODE_OPTIONS "--max-old-space-size=8192"
        set --global --export BUN_INSTALL "$HOME/.bun"
        set --global --export VOLTA_HOME "$HOME/.volta"
        set --global --export NIX_SW /run/current-system/sw
        set --global --export NIX_PROFILE /etc/profiles/per-user/$ME


        # Path modifications
        fish_add_path --global --move --path /opt/homebrew/bin /opt/homebrew/sbin
        fish_add_path $NIX_SW/bin
        fish_add_path $HOME/.nix-profile/bin
        fish_add_path $HOME/.local/bin
        fish_add_path $HOME/.
      '';

      # Interactive shell initialization
      interactiveShellInit = ''
        # Initialize tools
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };

    git = {
      enable = true;
      userName = "raikusy";
      userEmail = "xenax.rakibul@gmail.com";
      ignores = [
        "**/.idea/"
        "**/.direnv/"
        "**/.DS_Store"
      ];
      extraConfig = {
        pull = {
          ff = "only";
        };
        init.defaultBranch = "main";
      };
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
  };

  home.file = {
    # Add configurations one by one as you create them

    # Example: Once you have fish config:
    ".config/fish" = {
      source = ./config/fish;
      recursive = true;
    };

    # Example: Once you have starship config:
    ".config/starship.toml" = {
      source = ./config/starship/starship.toml;
    };

    # Git config (if you want to manage beyond what git program module provides)
    ".gitconfig" = {
      source = ./config/git/gitconfig;
    };

    # Add others as you create them
  };
}
