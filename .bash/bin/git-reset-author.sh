#!/bin/bash

# Get the target commit from the first argument
TARGET_HASH=$1

# Command to rewrite author/committer using current git config
REWRITE_CMD="git commit --amend --no-edit --reset-author"

if [ -z "$TARGET_HASH" ]; then
    echo "No hash provided. Resetting author for the ENTIRE repository history..."
    # --root tells rebase to start from the initial commit
    GIT_SEQUENCE_EDITOR=: git rebase -i --root --exec "$REWRITE_CMD"
else
    echo "Resetting author starting from commit: $TARGET_HASH"
    # ^ targets the parent of the hash to include the hash itself in the rewrite
    GIT_SEQUENCE_EDITOR=: git rebase -i "${TARGET_HASH}^" --exec "$REWRITE_CMD"
fi

echo "----------------------------------------------------------------"
echo "Success: Author updated to $(git config user.name) <$(git config user.email)>"
echo "To update the remote, run: git push --force-with-lease"
