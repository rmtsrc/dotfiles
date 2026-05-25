# Some AI agents use a locked down shell & are missing some environment variables (like Cursor)
# XDG_RUNTIME_DIR is for Linux only (don't set on macOS)
if [[ "$OSTYPE" != "darwin"* ]] && [ -z "$XDG_RUNTIME_DIR" ]; then
  USER_ID=$(id -u)

  # If ID is 0, check if we are actually root. If not root, default to 1000.
  if [ "$USER_ID" -eq 0 ] && [ "$USER" != "root" ]; then
    USER_ID=1000
  fi

  export XDG_RUNTIME_DIR="/run/user/$USER_ID"
fi
