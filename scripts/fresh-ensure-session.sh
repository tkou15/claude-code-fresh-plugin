#!/bin/bash
# fresh-ensure-session.sh — Ensure a Fresh session is running and print its name.
#
# Usage: fresh-ensure-session.sh [working-directory]
#
# Output (stdout):
#   Line 1: SESSION_NAME
#   Line 2: SURFACE_ID (only when cmux started a new split; empty otherwise)
#
# Exit codes:
#   0 — session ready
#   1 — fresh not installed
#   2 — could not start session

set -euo pipefail

WORKDIR="${1:-$(pwd)}"

# --- Check fresh is installed ---
if ! command -v fresh &>/dev/null; then
  echo "ERROR: fresh is not installed." >&2
  echo "Install with: brew install fresh-editor" >&2
  exit 1
fi

# --- Helper: extract session name from `fresh --cmd session list` ---
get_session_name() {
  fresh --cmd session list 2>/dev/null | grep -oE '\(([A-Za-z0-9_-]+)\)' | head -1 | tr -d '()' || true
}

SESSION_NAME=$(get_session_name)

# --- If session already exists, return it ---
if [[ -n "$SESSION_NAME" ]]; then
  echo "$SESSION_NAME"
  echo ""
  exit 0
fi

# --- No session — try to start one via cmux ---
if [[ -n "${CMUX_SOCKET_PATH:-}" ]]; then
  # Create a right split and capture the surface ID
  SPLIT_OUTPUT=$(cmux new-split right 2>&1)
  SURFACE_ID=$(echo "$SPLIT_OUTPUT" | grep -oE 'surface:[0-9]+' | head -1)

  if [[ -z "$SURFACE_ID" ]]; then
    echo "ERROR: cmux new-split failed: $SPLIT_OUTPUT" >&2
    exit 2
  fi

  # Start Fresh in the new terminal surface — it auto-creates a session from CWD
  cmux send --surface "$SURFACE_ID" "cd '$WORKDIR' && fresh" >/dev/null 2>&1
  cmux send-key --surface "$SURFACE_ID" Enter >/dev/null 2>&1

  # Wait for session to be attachable (up to 5 seconds)
  for _ in $(seq 1 10); do
    sleep 0.5
    SESSION_NAME=$(get_session_name)
    if [[ -n "$SESSION_NAME" ]]; then
      echo "$SESSION_NAME"
      echo "$SURFACE_ID"
      exit 0
    fi
  done

  echo "ERROR: Fresh session did not start within 5 seconds." >&2
  exit 2
fi

# --- No cmux — cannot auto-start, tell caller ---
echo "ERROR: No Fresh session running and cmux is not available." >&2
echo "Start Fresh manually: fresh ." >&2
exit 2
