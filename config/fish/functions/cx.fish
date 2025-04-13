function cx
    # Check if any arguments were passed to the function
    if test (count $argv) -eq 0
        # No arguments provided, open the current directory
        cursor .
    else
        # Arguments provided, pass them directly to the cursor command
        cursor $argv
    end
end
