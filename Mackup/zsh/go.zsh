# ----- GO SETUP -----

if [[ -f /usr/local/go ]]; then
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/Desktop/go
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
fi