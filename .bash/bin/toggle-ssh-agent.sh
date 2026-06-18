#!/usr/bin/env bash

STATE_FILE="$HOME/.ssh-agent-toggle-state"

# Load saved state
if [[ -f "$STATE_FILE" ]]; then
    source "$STATE_FILE"
fi

# If toggled ON → restore previous agent
if [[ "$TOGGLED" == "1" ]]; then
    echo "Restoring previous ssh-agent..."

    # kill current agent (the temporary one)
    if [[ -n "$SSH_AGENT_PID" ]]; then
        ssh-agent -k >/dev/null 2>&1
    fi

    # restore old env
    export SSH_AUTH_SOCK="$OLD_SSH_AUTH_SOCK"
    export SSH_AGENT_PID="$OLD_SSH_AGENT_PID"

    # clear state
    cat > "$STATE_FILE" <<EOF
TOGGLED=0
OLD_SSH_AUTH_SOCK=$OLD_SSH_AUTH_SOCK
OLD_SSH_AGENT_PID=$OLD_SSH_AGENT_PID
EOF

    echo "Restored previous ssh-agent."
    return 0 2>/dev/null || exit 0
fi

# Otherwise → save current and start new agent
echo "Starting new ssh-agent..."

OLD_SSH_AUTH_SOCK="$SSH_AUTH_SOCK"
OLD_SSH_AGENT_PID="$SSH_AGENT_PID"

# start new agent IN THIS SHELL
eval "$(ssh-agent -s)"

cat > "$STATE_FILE" <<EOF
TOGGLED=1
OLD_SSH_AUTH_SOCK=$OLD_SSH_AUTH_SOCK
OLD_SSH_AGENT_PID=$OLD_SSH_AGENT_PID
SSH_AUTH_SOCK=$SSH_AUTH_SOCK
SSH_AGENT_PID=$SSH_AGENT_PID
EOF

echo "Switched to new ssh-agent. Run again to restore."
