if [[ -d $BREW_PREFIX/sbin && ":$PATH:" != *":$BREW_PREFIX/sbin:"* ]]; then
    PATH=$BREW_PREFIX/sbin:$PATH
    export PATH
fi

if type brew &>/dev/null; then
  FPATH=$BREW_PREFIX/share/zsh/site-functions:$FPATH
fi

