{
  pkgs,
  config,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  xdg.enable = true;
  home.username = "raikusy";
  home.homeDirectory = "/Users/raikusy";
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = false;

  home.packages = with pkgs; [
    # Shell and Core Utils
    grc # Colorize terminal output
    fish # Friendly Interactive Shell
    starship # Cross-shell prompt
    direnv # Environment switcher
    lazygit # Git UI
    # tmux # Tmux
    rip2 # Better rm
    _1password-cli # 1Password CLI
    just # Justfile runner
    antidote # Antidote plugin manager

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
    nil # Nix language server
    nixd # Nix debugger
    alejandra # Nix code formatter
    fh # Nix package manager
    gh # GitHub CLI
    git-credential-manager # Git credential manager
    delta # Better git diffs
    difftastic # Structural diff tool
    act # Run GitHub Actions locally
    actionlint # GitHub Actions linting
    action-validator # GitHub Actions validator
    cocoapods # iOS dependency manager
    watchman # File watching service
    brotli # Brotli compression format
    pigz # Parallel gzip
    node-gyp # Node.js addon build tool
    zellij # Terminal multiplexer

    # Package Managers
    volta # JavaScript tool manager
    cargo-update # Update Rust packages

    # Programming Languages & Runtimes
    rustup # Rust toolchain installer
    rustc # Rust compiler
    rustlings # Rust learning exercises
    bun # All-in-one JavaScript runtime & toolkit
    deno # JavaScript/TypeScript runtime

    # Container & Virtualization
    docker # Container platform
    docker-compose # Multi-container Docker applications
    colima # Container runtime for macOS

    # Network Tools
    curl # Transfer data with URLs
    wget # Network file retriever

    # macOS Specific
    m-cli # Swiss Army Knife for macOS
    mas # Mac App Store CLI
    xcode-install # Install and update Xcode

    # Cloud & Infrastructure
    awscli2 # AWS CLI

    # Additional Development Tools
    # fnm # Fast Node Manager
    go # Go programming language

    # Security Tools
    # age # Modern encryption tool
    # sops # Secrets management

    # System Monitoring & Performance
    # mactop # macOS system monitor
    # topgrade # System upgrade tool
    # fastfetch # Fast fetch
    # bottom # System monitor with nice graphs
    # htop # Interactive process viewer
    # hyperfine # Command-line benchmarking tool
    # bandwhich # Network utilization tool

    # Misc Tools
    # sherlock # Hunt down social media accounts
    # jq # JSON processor
    # yq # YAML processor

    # GUI Apps
    # telegram-desktop # Telegram
    # maccy # Clipboard manager
    # wezterm # WezTerm Terminal Emulator
    # karabiner-elements # Keyboard customizer
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
  home.stateVersion = "24.11";

  home.sessionVariables = {
    DOTFILES = "${config.home.homeDirectory}/dotfiles";
    EDITOR = "cursor";
    USER_PROFILE = "/run/current-system/etc/profiles/per-user/${config.home.username}";
    NIX_PROFILE = "${config.home.homeDirectory}/.nix-profile";
    NODE_OPTIONS = "--max-old-space-size=8192";
    BUN_INSTALL = "${config.home.homeDirectory}/.bun";
    VOLTA_HOME = "${config.home.homeDirectory}/.volta";
    GEM_HOME = "${config.home.homeDirectory}/.gem";
    DENO_INSTALL = "${config.home.homeDirectory}/.deno";
    DOCKER_BUILDKIT = "1";
    DOCKER_HOST = "unix://${config.xdg.configHome}/colima/default/docker.sock";
    COMPOSE_DOCKER_CLI_BUILD = "1";
    HOMEBREW_NO_ANALYTICS = "1";
    COLORTERM = "truecolor";
    TERM = "xterm-256color";
    RUST_TARGET = "aarch64-apple-darwin";
    CARGO_NET_GIT_FETCH_WITH_CLI = "true";
    HYPERFINE_MIN_RUNS = "10";
    WATCHMAN_CONFIG_FILE = "${config.xdg.configHome}/watchman/config.json";
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
  };

  home.file = {
    ".nix-profile" = {
      source = "${config.home.sessionVariables.USER_PROFILE}";
      recursive = true;
    };
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/bin"
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.gem/bin"
    # "${config.home.homeDirectory}/.volta/bin"
    "${config.home.homeDirectory}/.deno/bin"
    "${config.home.homeDirectory}/.bun/bin"
    "${config.home.homeDirectory}/.nix-profile/bin"
    "${config.xdg.stateHome}/nix/profile/bin"
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
    "/Applications/Windsurf.app/Contents/Resources/app/bin"
    "${config.home.sessionVariables.CARGO_HOME}/bin"
  ];

  xdg.configFile = {
    "starship.toml" = {
      source = "${config.home.homeDirectory}/dotfiles/config/starship/starship.toml";
    };
    "git/allowed-signers" = {
      source = "${config.home.homeDirectory}/dotfiles/config/git/allowed-signers";
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };

    bun = {
      enable = true;
      settings = {
        smol = true;
      };
    };

    zsh = {
      enable = true;
      antidote = {
        enable = true;
        useFriendlyNames = true;
        plugins = [
          # Let's go ahead and use all of Oh My Zsh's lib directory.
          "ohmyzsh/ohmyzsh path:lib"
          "ohmyzsh/ohmyzsh path:plugins/extract"

          # Now, let's pick our Oh My Zsh utilty plugins
          "ohmyzsh/ohmyzsh path:plugins/colored-man-pages"
          "ohmyzsh/ohmyzsh path:plugins/copybuffer"
          "ohmyzsh/ohmyzsh path:plugins/copyfile"
          "ohmyzsh/ohmyzsh path:plugins/copypath"
          "ohmyzsh/ohmyzsh path:plugins/globalias"
          "ohmyzsh/ohmyzsh path:plugins/magic-enter"
          "ohmyzsh/ohmyzsh path:plugins/fancy-ctrl-z"
          "ohmyzsh/ohmyzsh path:plugins/otp"
          "ohmyzsh/ohmyzsh path:plugins/zoxide"

          # Add some programmer plugins
          "ohmyzsh/ohmyzsh path:plugins/git"
          "ohmyzsh/ohmyzsh path:plugins/docker"
          "ohmyzsh/ohmyzsh path:plugins/docker-compose"
          "ohmyzsh/ohmyzsh path:plugins/vscode"
          "ohmyzsh/ohmyzsh path:plugins/node"

          # Add macOS specific plugins
          "ohmyzsh/ohmyzsh path:plugins/brew conditional:is-macos"
          "ohmyzsh/ohmyzsh path:plugins/macos conditional:is-macos"

          "MichaelAquilina/zsh-you-should-use"

          "olets/zsh-abbr    kind:defer"

          # Add binary utils
          # romkatv/zsh-bench kind:path

          # Add core plugins that make Zsh a bit more like Fish
          "zsh-users/zsh-completions path:src kind:fpath"
          "zsh-users/zsh-autosuggestions"
          "zsh-users/zsh-history-substring-search"
          "zdharma-continuum/fast-syntax-highlighting"
          # rupa/z

          # or lighter-weight ones like zsh-utils
          "belak/zsh-utils path:editor"
          "belak/zsh-utils path:history"
          "belak/zsh-utils path:prompt"
          "belak/zsh-utils path:utility"
          "belak/zsh-utils path:completion"
        ];
      };
      oh-my-zsh = {
        enable = true;
      };
      syntaxHighlighting.enable = true;
      zsh-abbr.enable = true;
      initExtraFirst = ''
        . "$HOME/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
      '';
      initExtra = ''
        op completion zsh | source
        fh completion zsh | source
        rip completions zsh | source
        colima completion zsh | source
        . "$HOME/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
      '';
    };

    fish = {
      enable = true;

      # Add useful shell functions
      functions = {
        fish_greeting = ""; # Disable greeting
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
        cat = ''
          bat --paging=never --style=auto $argv
        '';
        where = ''
          if test (count $argv) -eq 0
            echo "Usage: where <command>"
            return 1
          end

          type -a $argv
        '';
        asq = ''
          q chat "$argv"
        '';
        rm = ''
          rip $argv
        '';
      };

      # Add environment variables in a more organized way
      loginShellInit =
        builtins.readFile "${config.home.homeDirectory}/dotfiles/config/fish/conf.d/99_custom_init.fish"
        + ''
          op completion fish | source
          fh completion fish | source
          rip completions fish | source
          colima completion fish | source
        '';
      plugins = [
        # {
        #   name = "osx";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "oh-my-fish";
        #     repo = "plugin-osx";
        #     rev = "main";
        #     sha256 = "sha256-jSUIk3ewM6QnfoAtp16l96N1TlX6vR0d99dvEH53Xgw=";
        #   };
        # }
        {
          name = "replay.fish";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "replay.fish";
            rev = "main";
            sha256 = "sha256-TzQ97h9tBRUg+A7DSKeTBWLQuThicbu19DHMwkmUXdg=";
          };
        }
        {
          name = "gitnow";
          src = pkgs.fetchFromGitHub {
            owner = "joseluisq";
            repo = "gitnow";
            rev = "2.12.0";
            sha256 = "sha256-PuorwmaZAeG6aNWX4sUTBIE+NMdn1iWeea3rJ2RhqRQ=";
          };
        }
        {
          name = "colored_man_pages.fish";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "colored_man_pages.fish";
            rev = "main";
            sha256 = "sha256-ii9gdBPlC1/P1N9xJzqomrkyDqIdTg+iCg0mwNVq2EU=";
          };
        }
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
        {
          name = "plugin-git";
          src = pkgs.fishPlugins.plugin-git.src;
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
      icons = "auto";
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
      # tmux.enableShellIntegration = true;
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
      userName = "raikusy";
      userEmail = "xenax.rakibul@gmail.com";
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILi1cbiFBIMivXJpLMBS8w4KsOkPpdMEUd1HW5vzWG5G";
        signByDefault = true;
      };
      extraConfig = {
        init.defaultBranch = "main";
        pull = {
          ff = "false";
          rebase = true;
        };
        rebase = {
          autoStash = true;
        };
        core = {
          editor = "cursor";
          autocrlf = "input";
          whitespace = "trailing-space,space-before-tab";
        };
        gpg = {
          format = "ssh";
          allowedSignersFile = builtins.readFile "${config.xdg.configHome}/git/allowed-signers";
          ssh = {
            program = builtins.toPath "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          };
        };
        commit.gpgSign = true;
        alias = {
          up = "pull --rebase --autostash";
        };
        credential = {
          helper = "!gh auth git-credential";
        };
      };
    };

    # tmux = {
    #   enable = true;
    #   clock24 = true;
    #   keyMode = "vi";
    #   customPaneNavigationAndResize = true;
    #   terminal = "screen-256color";
    #   plugins = with pkgs.tmuxPlugins; [
    #     sensible
    #     yank
    #     resurrect
    #     continuum
    #     {
    #       plugin = dracula;
    #       extraConfig = ''
    #         set -g @dracula-show-battery false
    #         set -g @dracula-show-powerline true
    #         set -g @dracula-refresh-rate 10
    #       '';
    #     }
    #   ];
    #   extraConfig = ''
    #     # Enable mouse support
    #     set -g mouse on

    #     # Start windows and panes at 1, not 0
    #     set -g base-index 1
    #     setw -g pane-base-index 1

    #     # Automatically renumber windows
    #     set -g renumber-windows on
    #   '';
    # };

    wezterm = {
      enable = true;
      extraConfig = builtins.readFile "${config.home.homeDirectory}/dotfiles/config/wezterm/wezterm.lua";
    };
  };
}
