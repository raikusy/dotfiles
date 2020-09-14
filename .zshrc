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

# ----- VOLTA SETUP -----
export VOLTA_HOME=$HOME/.volta
export PATH=$VOLTA_HOME/bin:$PATH

# ----- PLUGINS SETUP -----
plugins=(git colorize docker docker-compose z brew osx zsh-syntax-highlighting zsh-autosuggestions zsh-completions)
autoload -U compinit && compinit
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue"

# ----- OH-MY-ZSH SETUP -----
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

ZSH_THEME=""

# ----- ALIAS SETUP -----
alias shunboi-dev="gcloud compute ssh --zone \"asia-southeast1-b\" \"unpossible@staging\" --project \"unpossible\""
alias shunboi-prod="gcloud compute ssh --zone \"asia-south1-a\" \"unpossible@production\" --project \"unpossible\""
alias deploy-ovechr-api="cd ~/Desktop/riseuplab/backend-ovechr && aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 297103403771.dkr.ecr.ap-southeast-1.amazonaws.com && docker build -t ovechr-api . && docker tag ovechr-api:latest 297103403771.dkr.ecr.ap-southeast-1.amazonaws.com/ovechr-api:latest && docker push 297103403771.dkr.ecr.ap-southeast-1.amazonaws.com/ovechr-api:latest"

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/google-cloud-sdk/path.zsh.inc ]; then . $HOME/google-cloud-sdk/path.zsh.inc; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME/google-cloud-sdk/completion.zsh.inc ]; then . $HOME/google-cloud-sdk/completion.zsh.inc; fi

# ----- PURE SETUP -----
fpath=($HOME/.zsh/pure $fpath)
autoload -Uz promptinit; promptinit

# change the path color
zstyle :prompt:pure:path color white

# change the color for both `prompt:success` and `prompt:error`
zstyle ':prompt:pure:prompt:*' color cyan

# turn on git stash status
zstyle :prompt:pure:git:stash show yes

prompt pure
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

