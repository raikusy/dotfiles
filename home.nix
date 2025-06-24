{
  config,
  pkgs,
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
    lazygit # Git UI
    # tmux # Tmux
    rip2 # Better rm
    _1password-cli # 1Password CLI

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
    wiper

    # Search and Filter
    ripgrep # Fast grep alternative
    fzf # Fuzzy finder

    # Development Tools
    git # Version control system
    nil # Nix language server
    nixd # Nix debugger
    # alejandra # Nix code formatter
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
    mas # Mac App Store CLI
    xcode-install # Install and update Xcode

    # Cloud & Infrastructure
    awscli2 # AWS CLI
    go # Go programming language
    fastfetch # Fast fetch
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
    "${config.home.homeDirectory}/.volta/bin"
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
    "ghostty/config" = {
      source = "${config.home.homeDirectory}/dotfiles/config/ghostty/config";
    };
    "wezterm/wezterm.lua" = {
      source = "${config.home.homeDirectory}/dotfiles/config/wezterm/wezterm.lua";
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };

    bun = {
      enable = true;
    };

    zsh = {
      enable = true;
      antidote = {
        enable = true;
        useFriendlyNames = true;
        plugins = [];
      };
      syntaxHighlighting.enable = true;
      zsh-abbr.enable = true;
      initContent = ''
        eval "$(op completion zsh)"
        eval "$(rip completions zsh)"
        eval "$(fh completion zsh)"
        eval "$(colima completion zsh)"
      '';
    };

    fish = {
      enable = true;

      # Add useful shell functions
      functions = {
        fish_greeting = "";
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
          bat $argv
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
        cx = ''
          # Check if any arguments were passed to the function
          if test (count $argv) -eq 0
              # No arguments provided, open the current directory
              cursor .
          else
              # Arguments provided, pass them directly to the cursor command
              cursor $argv
          end
        '';
        projects = {
          description = "Jump to a project";
          body = ''
            set projdir ( \
                fd \
                    --search-path $HOME/workspace \
                    --type directory \
                    --hidden \
                    "^.git\$" \
                | xargs dirname \
                | fzf \
                    --delimiter '/' \
                    --with-nth 6.. \
            )
            and cd $projdir
            and commandline -f execute
          '';
        };
        copy = {
          description = "Copy file contents into clipboard";
          body = "cat $argv | pbcopy"; # Need to fix for non-macOS
        };
        json = {
          description = "Tidy up JSON using jq";
          body = "pbpaste | jq '.' | pbcopy"; # Need to fix for non-macOS
        };
        br = {
          description = "Open browser";
          wraps = "broot";
          body = ''
            set -l cmd_file (mktemp)
            if broot --outcmd $cmd_file $argv
                source $cmd_file
                rm -f $cmd_file
            else
                set -l code $status
                rm -f $cmd_file
                return $code
            end
          '';
        };
        print_path = {
          description = "Print PATH variable in a nicely formatted way";
          body = "echo $PATH | string split ' ' | awk '{print NR \" \", $0}' | bat --plain --language=ini";
        };
      };
      # Add environment variables in a more organized way
      loginShellInit =
        ''
          /opt/homebrew/bin/brew shellenv | source
        ''
        + builtins.readFile "${config.home.homeDirectory}/dotfiles/config/fish/config.fish"
        + ''
          op completion fish | source
          fh completion fish | source
          rip completions fish | source
          colima completion fish | source
          atuin init fish | source
        '';
      plugins = [
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
        paging = "never";
        color = "always";
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
  };
}
