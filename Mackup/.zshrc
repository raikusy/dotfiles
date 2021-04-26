# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# # ----- GO SETUP -----
# export GOROOT=/usr/local/go
# export GOPATH=$HOME/Desktop/go
# export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# # ----- ANDROID STUDIO SETUP -----
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$ANDROID_HOME/emulator:$PATH
# export PATH=$ANDROID_HOME/tools:$PATH
# export PATH=$ANDROID_HOME/tools/bin:$PATH
# export PATH=$ANDROID_HOME/platform-tools:$PATH
# # FB-IDB
# export PYTHON_HOME=$HOME/Library/Python/3.9
# export PATH=$PYTHON_HOME/bin:$PATH

# ----- VOLTA SETUP -----
# https://volta.sh
export VOLTA_HOME="$HOME/.volta"
export PATH=$VOLTA_HOME/bin:$PATH

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# ----- PLUGINS SETUP -----
plugins=()

# ----- OH-MY-ZSH SETUP -----
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

ZSH_THEME=""

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(fasd --init auto)"
eval "$(starship init zsh)"
source ~/.fresh/build/shell.sh