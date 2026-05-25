#!/usr/bin/env bash

INPUT_ARG="${1:-}"

MODE=""
if [ "$INPUT_ARG" == "true" ]; then
  MODE="dark"
else
  MODE="light"
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/toggle-dark-mode.sh" "$MODE"
