#!/bin/bash
# fresh-open-finding.sh — Open a file with annotation in Fresh.
#
# Usage: fresh-open-finding.sh <session-name> <file-spec> [surface-id]
#
# Arguments:
#   session-name  Fresh session name (e.g., Users_ko1_work)
#   file-spec     File with annotation (e.g., src/main.py:10-20@"issue here")
#   surface-id    Optional cmux surface ID for the Fresh pane
#
# If surface-id is provided and cmux is available, sends the command via cmux.
# Otherwise, runs fresh --cmd directly.

set -euo pipefail

SESSION_NAME="${1:?Usage: fresh-open-finding.sh <session-name> <file-spec> [surface-id]}"
FILE_SPEC="${2:?Usage: fresh-open-finding.sh <session-name> <file-spec> [surface-id]}"
SURFACE_ID="${3:-}"

FRESH_CMD="fresh --cmd session open-file $SESSION_NAME '${FILE_SPEC}'"

if [[ -n "$SURFACE_ID" ]] && [[ -n "${CMUX_SOCKET_PATH:-}" ]]; then
  # Send via cmux to the Fresh pane
  # Escape double quotes inside the file spec for the outer cmux send quotes
  ESCAPED_SPEC=$(echo "$FILE_SPEC" | sed 's/"/\\"/g')
  cmux send --surface "$SURFACE_ID" "fresh --cmd session open-file $SESSION_NAME '${ESCAPED_SPEC}'" >/dev/null 2>&1
  cmux send-key --surface "$SURFACE_ID" Enter >/dev/null 2>&1
else
  # Run directly
  fresh --cmd session open-file "$SESSION_NAME" "$FILE_SPEC"
fi
