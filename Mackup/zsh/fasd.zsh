# Enable fasd, if available
if hash fasd 2>/dev/null; then
    eval "$(fasd --init auto)"
fi