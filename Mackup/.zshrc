# ----- BASE SETUP -----
autoload -U compinit
autoload -U bashcompinit
# Generate a menu of matches when globbing (rather than auto-inserting all matches)
setopt GLOB_COMPLETE
setopt PROMPT_SUBST
setopt NO_NOMATCH

export EDITOR='nano'

# ----- PLUGINS SETUP -----
plugins=(git docker docker-compose)

# ----- OH-MY-ZSH SETUP -----
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""
source $ZSH/oh-my-zsh.sh

# ----- CONFIG SETUP -----
typeset -U config_files
config_files=($HOME/zsh/**/*.zsh)
# load config files
for file in ${config_files}
do
  source $file
done
