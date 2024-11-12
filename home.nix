{ pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "raikusy";
  home.homeDirectory = "/Users/raikusy";

  home.packages = with pkgs; [
    zsh
    vim
    git
    neovim
    nixd
    nixfmt-rfc-style
    curl
    wget
    ripgrep
    fzf
    lsd
    yazi
    bat
    zoxide
    helix
    aider-chat
    neomutt
    mactop
    kondo
    pls
    eza
    sherlock
    fnm
    docker
    docker-compose
    rustc
    cargo
    rustfmt
    ox
    volta
    bun
    deno
    direnv
    fd
    htop
    topgrade
    colima
    devenv
    starship
    cachix
    fish
    whois
    coreutils
    fishPlugins.fzf
    fishPlugins.git-abbr
    fishPlugins.forgit
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
  home.sessionVariables = {
    PATH = "$PATH:/Users/raikusy/.nix-profile/bin";
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

    fish = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "raikusy";
      userEmail = "ping@raikusy.dev";
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
      settings = {
        add_newline = false;
      };
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
}
