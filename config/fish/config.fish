# Nix
if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    # following is single user
    # source '/nix/var/nix/profiles/default/etc/profile.d/nix.fish'
end
# End Nix


################### Nix
# Essential workaround for clobbered `$PATH` with nix-darwin.
# Without this, both Nix and Homebrew paths are forced to the end of $PATH.
# <https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1345383219>
# <https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1030877541>
#
# A previous version of this snippet also included:
#   - /run/wrappers/bin
#   - /etc/profiles/per-user/$USER/bin # mwb needed if useGlobalPkgs used.
#
if test (uname) = Darwin
    fish_add_path --prepend --global --move \
        # /etc/profiles/per-user/$USER/bin \
        $XDG_STATE_HOME/nix/profile/bin \
        $HOME/.nix-profile/bin \
        /run/current-system/sw/bin \
        /nix/var/nix/profiles/default/bin \
        /etc/profiles/per-user/$USER/bin
end

################### Deno
fish_add_path --global --move --path $HOME/.deno/bin

################### Bun
fish_add_path --global --move --path $HOME/.bun/bin

################### Volta
fish_add_path --global --move --path $HOME/.volta/bin

# Bun aliases
abbr -a -- b bun
abbr -a -- ba 'bun add'
abbr -a -- bag 'bun add --global'
abbr -a -- bi 'bun i'
abbr -a -- bif 'bun i --force'
abbr -a -- brm 'bun remove'
abbr -a -- brmg 'bun remove -g'
abbr -a -- br 'bun run'
abbr -a -- brb 'bun run build'
abbr -a -- brd 'bun run dev'
abbr -a -- btt 'bun test'
abbr -a -- blt 'bun lint'
abbr -a -- bx bunx
abbr -a -- bp 'bun pm'
abbr -a -- bpls 'bun pm ls'
abbr -a -- bplsg 'bun pm ls --global'


# Pnpm aliases
abbr -a -- p pnpm
abbr -a -- pi 'pnpm i'
abbr -a -- pif 'pnpm i --force'
abbr -a -- pun 'pnpm uninstall'
abbr -a -- pung 'pnpm uninstall -g'
abbr -a -- pa 'pnpm add'
abbr -a -- pag 'pnpm add --global'
abbr -a -- pad 'pnpm add -D'
abbr -a -- pr 'pnpm run'
abbr -a -- plt 'pnpm lint'
abbr -a -- ptt 'pnpm test'
abbr -a -- prd 'pnpm run dev'
abbr -a -- prb 'pnpm run build'
abbr -a -- prs 'pnpm run start'
abbr -a -- px pnpx

# Nix
abbr -a -- nx 'nix --extra-experimental-features "nix-command flakes"'
abbr -a -- nxd 'nix --extra-experimental-features "nix-command flakes" run nix-darwin'
abbr -a -- dr darwin-rebuild
abbr -a -- drs 'darwin-rebuild switch --flake ~/dotfiles --impure'
abbr -a -- drb 'darwin-rebuild build --flake ~/dotfiles --impure'
abbr -a -- drc 'darwin-rebuild check --flake ~/dotfiles --impure'
abbr -a -- npu nix-prefetch-url
abbr -a -- nfu 'nix flake update'
abbr -a -- nfui 'nix flake update --commit-lock-file'

# Directories
abbr -a --position anywhere -- ~df '~/dotfiles'
abbr -a --position anywhere -- ~w '~/work'
abbr -a --position anywhere -- ~d '~/Desktop'
abbr -a --position anywhere -- ~dd '~/Downloads'

# Common
abbr -a -- :c clear
abbr -a -- :q exit
abbr -a -- :m micro
abbr -a -- :sf superfile
abbr -a -- :cr cursor
abbr -a -- :wt wezterm
abbr -a -- :ws windsurf

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
    eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/homebrew/Caskroom/miniconda/base/bin" $PATH
    end
end
# <<< conda initialize <<<
