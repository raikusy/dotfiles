# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed and these are never upgraded.
# To link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded) add the following to your ~/.zshrc:
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
# For compilers to find openssl@1.1 you may need to set:
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

# For pkg-config to find openssl@1.1 you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# ----- GO SETUP -----
export GOROOT=/usr/local/go
export GOPATH=$HOME/Desktop/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# ----- ANDROID STUDIO SETUP -----
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
# FB-IDB
export PYTHON_HOME=$HOME/Library/Python/3.9
export PATH=$PYTHON_HOME/bin:$PATH

# ----- VOLTA SETUP -----
# https://volta.sh
export VOLTA_HOME="$HOME/.volta"
export PATH=$VOLTA_HOME/bin:$PATH

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# ----- PLUGINS SETUP -----
plugins=(git colorize docker docker-compose zsh-syntax-highlighting zsh-autosuggestions zsh-completions fasd)
autoload -Uz compinit;
compinit
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue"

# ----- OH-MY-ZSH SETUP -----
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

ZSH_THEME=""

# ----- ALIAS SETUP -----
alias ssh-foodbuddy="ssh 54.151.185.209"
alias ssh-dynamic="ssh 54.179.6.189"
alias ssh-sheratong="ssh 18.136.50.33"

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
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
###-begin-pm2-completion-###
### credits to npm for the completion file model
#
# Installation: pm2 completion >> ~/.bashrc  (or ~/.zshrc)
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _pm2_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           pm2 completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _pm2_completion pm2
elif type compctl &>/dev/null; then
  _pm2_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       pm2 completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _pm2_completion + -f + pm2
fi
###-end-pm2-completion-###
eval "$(fasd --init auto)"