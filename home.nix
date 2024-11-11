{ pkgs, inputs, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "raikusy";
  home.homeDirectory = "/Users/raikusy";

  home.packages = with pkgs; [
    pkgs.zsh
    pkgs.fish
    pkgs.vim
    pkgs.git
    pkgs.curl
    pkgs.wget
    pkgs.ripgrep
    pkgs.fzf
    pkgs.lsd
    pkgs.yazi
    pkgs.bat
    pkgs.zoxide
    pkgs.nixfmt-rfc-style
    pkgs.nixd
    pkgs.rustc
    pkgs.cargo
    pkgs.rustfmt
    pkgs.volta
    # pkgs.direnv
    pkgs.colima
    pkgs.devenv
    pkgs.starship
    pkgs.cachix

    pkgs.fishPlugins.fzf
    pkgs.fishPlugins.git-abbr
    pkgs.fishPlugins.forgit
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
      enable = true;
      userName = "raikusy";
      userEmail = "ping@raikusy.dev";
      ignores = [ "**/.idea/" "**/.direnv/" "**/.DS_Store" ];
      extraConfig = {
        pull = { ff = "only"; };
        init.defaultBranch = "main";
      };
    };

  # programs.direnv.enable = true;

  # programs.zsh = {
  #   enable = true;
  #   enableFastSyntaxHighlighting = true;
  #   enableFzfCompletion = true;
  # };
  # add home-manager installs in $PATH

  programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        scan_timeout = 10;
        # prompt
        format = "$directory$git_branch$git_metrics$nix_shell$package$character";
        add_newline = true;
        line_break.disabled = false;
        directory.style = "cyan";
        character = {
          success_symbol = "[λ](green)";
          error_symbol = "[λ](red)";
        };
        # git
        git_branch = {
          style = "purple";
          symbol = "";
        };
        git_metrics = {
          disabled = false;
          added_style = "bold yellow";
          deleted_style = "bold red";
        };
        # package management
        package.format = "version [$version](bold green) ";
        nix_shell.symbol = " ";
      };
    };
}
