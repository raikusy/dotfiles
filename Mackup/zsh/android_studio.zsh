# # ----- ANDROID STUDIO SETUP -----
if [[ -f $HOME/Library/Android/sdk ]]; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$ANDROID_HOME/emulator:$PATH
    export PATH=$ANDROID_HOME/tools:$PATH
    export PATH=$ANDROID_HOME/tools/bin:$PATH
    export PATH=$ANDROID_HOME/platform-tools:$PATH
fi

# FB-IDB
if [[ -f $HOME/Library/Python/3.9 ]]; then
    export PYTHON_HOME=$HOME/Library/Python/3.9
    export PATH=$PYTHON_HOME/bin:$PATH
fi