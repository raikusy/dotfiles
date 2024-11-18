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
abbr -a -- nxrd 'nix --extra-experimental-features "nix-command flakes" run nix-darwin'
abbr -a -- dr 'darwin-rebuild switch --flake ~/dotfiles --impure'

# Common
abbr -a -- :c clear
abbr -a -- :q exit
abbr -a -- :m micro
abbr -a -- mifc 'micro ~/.config/fish/config.fish'
abbr -a -- mizc 'micro ~/.zshrc'
abbr -a -- srcf 'source ~/.config/fish/config.fish'
abbr -a -- srcz 'source ~/.zshrc'
abbr -a -- spf superfile
