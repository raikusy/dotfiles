function see -d "Interactive directory explorer with fd, fzf, and rg"
    # Default to current directory if no argument provided
    set -l target_dir $argv[1]
    if test -z "$target_dir"
        set target_dir "."
    end

    # Ensure the target is a directory
    if not test -d "$target_dir"
        echo "Error: '$target_dir' is not a directory"
        return 1
    end

    # Use fd to find files and directories
    # Then use fzf with preview window to display content
    fd --hidden --follow --exclude ".git" . "$target_dir" | fzf --preview 'set -l target {}; 
                  if test -d "$target"
                      ls -la --color=always "$target"
                  else if file --mime "$target" | grep -q "text/"
                      bat --style=numbers --color=always "$target" 2>/dev/null || cat "$target"
                  else if file --mime "$target" | grep -q "image/"
                      echo "Image file: $target"
                      file "$target"
                  else
                      echo "Binary file: $target"
                      file "$target"
                  end' \
        --preview-window='right:60%' \
        --bind='ctrl-/:change-preview-window(down|hidden|)' \
        --bind='ctrl-d:preview-page-down' \
        --bind='ctrl-u:preview-page-up' \
        --bind='ctrl-f:page-down' \
        --bind='ctrl-b:page-up' \
        --bind='ctrl-r:reload(fd --hidden --follow --exclude ".git" . "$target_dir")' \
        --bind='ctrl-g:execute(rg --color=always --line-number "{q}" {} | less -R)' \
        --header='CTRL-/: toggle preview | CTRL-R: reload | CTRL-G: grep in file | CTRL-O: open' \
        --bind='ctrl-o:execute(open {})' \
        --ansi \
        --layout=reverse
end
