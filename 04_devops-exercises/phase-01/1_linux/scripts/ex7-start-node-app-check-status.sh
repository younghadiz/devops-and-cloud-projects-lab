#!/usr/bin/env bash
set -euo pipefail

echo "=== EX7: Start app + check status ==="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/ex6-start-node-app.sh"

APP_PID=$(pgrep -f "node server.js" | head -n 1 || true)
if [[ -z "$APP_PID" ]]; then
  echo "❌ App not running."
  exit 1
fi

echo "✅ App PID: $APP_PID"
ps -p "$APP_PID" -o pid,ppid,cmd,etime,%cpu,%mem

if command -v ss >/dev/null 2>&1; then
  echo "Listening port(s):"
  ss -ltnp 2>/dev/null | grep -E "pid=${APP_PID}," || echo "⚠️ Port not detected via ss."
else
  echo "Install ss with: sudo apt install -y iproute2"
fi
