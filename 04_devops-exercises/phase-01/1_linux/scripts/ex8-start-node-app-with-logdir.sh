#!/usr/bin/env bash
set -euo pipefail

echo "=== EX8: Start app with LOG_DIR parameter ==="

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <log_directory>"
  exit 1
fi

LOG_DIR_INPUT="$1"
mkdir -p "$LOG_DIR_INPUT"
export LOG_DIR="$(cd "$LOG_DIR_INPUT" && pwd)"
echo "LOG_DIR=$LOG_DIR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/ex6-start-node-app.sh"

echo "Check: $LOG_DIR/app.log (if app writes it)"
