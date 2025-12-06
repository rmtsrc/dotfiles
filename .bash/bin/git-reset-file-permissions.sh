#!/bin/bash

# Exit on error
set -e

# Ensure we're inside a git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not inside a Git repository."
    exit 1
fi

# Get list of changed files (staged and unstaged)
changed_files=$(git diff --name-only)

# Loop through each file
for file in $changed_files; do
    # Skip if file no longer exists
    [ ! -e "$file" ] && continue

    # Get the committed Git mode (e.g., 100644 or 100755)
    committed_mode=$(git ls-tree HEAD "$file" | awk '{print $1}')

    # Skip if file is not tracked
    [ -z "$committed_mode" ] && continue

    # Determine if committed file is executable
    if [[ "$committed_mode" == "100755" ]]; then
        committed_exec=1
    else
        committed_exec=0
    fi

    # Determine if current file is executable
    if [[ -x "$file" ]]; then
        current_exec=1
    else
        current_exec=0
    fi

    # If permission (executable bit) has changed
    if [[ "$committed_exec" != "$current_exec" ]]; then
        echo "Fixing permissions for: $file"
        if [[ "$committed_exec" -eq 1 ]]; then
            chmod +x "$file"
        else
            chmod -x "$file"
        fi
    fi
done

echo "Done: File permissions have been reset to match Git commit."
