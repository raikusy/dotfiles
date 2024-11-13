if status --is-interactive
    # Commands to run in interactive sessions can go here
end
# Universal
set --universal --export ME (whoami)
set --universal --export HOME /Users/$ME

# Project
set --global --export WORK $HOME/workspace
set --global --export EDITOR cursor


# Start Homebrew
set --global --export HOMEBREW_PREFIX /opt/homebrew
set --global --export HOMEBREW_CELLAR /opt/homebrew/Cellar
set --global --export HOMEBREW_REPOSITORY /opt/homebrew
fish_add_path --global --move --path /opt/homebrew/bin /opt/homebrew/sbin
if test -n "$MANPATH[1]"
    set --global --export MANPATH '' $MANPATH
end
if not contains /opt/homebrew/share/info $INFOPATH
    set --global --export INFOPATH /opt/homebrew/share/info $INFOPATH
end
eval "$(/opt/homebrew/bin/brew shellenv)"
# End Homebrew

# Gems
set --global --export GEM_HOME "$HOME/.gem"
# End Gems

# Deno
set --global --export DENO_INSTALL "$HOME/.deno"
fish_add_path $DENO_INSTALL/env
fish_add_path $DENO_INSTALL/bin
# End Deno

# Node
set --global --export NODE_OPTIONS "--max-old-space-size=8192 "
# End Node

# Bun
set --global --export BUN_INSTALL "$HOME/.bun"
# End Bun

# Volta
set --global --export VOLTA_HOME "$HOME/.volta"
# End Volta

set --global --export NIX_SW /run/current-system/sw

# Paths
fish_add_path $NIX_SW/bin
fish_add_path $HOME/.nix-profile/bin
fish_add_path /etc/profiles/per-user/$ME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.
# End Paths

zoxide init fish | source
direnv hook fish | source
starship init fish | source
