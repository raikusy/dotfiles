# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# ----- GO SETUP -----
export GOROOT=/usr/local/go
export GOPATH=$HOME/Desktop/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# ----- ANDROID STUDIO SETUP -----
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
# FB-IDB
export PYTHON_HOME=$HOME/Library/Python/3.9
export PATH=$PATH:$PYTHON_HOME/bin

# ----- VOLTA SETUP -----
# https://volta.sh
export VOLTA_HOME="$HOME/.volta"
export PATH=$PATH:$VOLTA_HOME/bin

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# ----- PLUGINS SETUP -----
plugins=(git colorize docker docker-compose z zsh-syntax-highlighting zsh-autosuggestions zsh-completions)
autoload -Uz compinit;
compinit
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue"

# ----- OH-MY-ZSH SETUP -----
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

ZSH_THEME=""

# ----- ALIAS SETUP -----
alias test="echo \"Test\""

# ----- PURE SETUP -----
FPATH=$HOME/.zsh/pure:$FPATH
autoload -Uz promptinit
promptinit

# change the path color
zstyle :prompt:pure:path color white

# change the color for both `prompt:success` and `prompt:error`
zstyle ':prompt:pure:prompt:success' color green
zstyle ':prompt:pure:prompt:error' color red

# turn on git stash status
zstyle :prompt:pure:git:stash show yes

prompt pure

# iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
