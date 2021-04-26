# Enable starship.rs prompt, if available
if hash starship 2>/dev/null; then
    eval "$(starship init zsh)"
fi