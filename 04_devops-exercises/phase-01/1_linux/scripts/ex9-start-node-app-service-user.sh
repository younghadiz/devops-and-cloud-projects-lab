#!/usr/bin/env bash
set -euo pipefail

echo "=== EX9: Run app as service user myapp ==="

if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo: sudo $0 <log_directory>"
  exit 1
fi

LOG_DIR_INPUT="${1:-logs}"
APP_BASE="/opt/myapp"
ARTIFACT_URL="https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"
ARTIFACT_FILE="bootcamp-node-envvars-project-1.0.0.tgz"
APP_DIR="package"

apt update -y
apt install -y nodejs npm curl tar

id myapp >/dev/null 2>&1 || useradd -m -s /bin/bash myapp

mkdir -p "$APP_BASE/$LOG_DIR_INPUT"
chown -R myapp:myapp "$APP_BASE"

LOG_DIR_ABS="$(cd "$APP_BASE/$LOG_DIR_INPUT" && pwd)"

sudo -u myapp bash -c "
  set -euo pipefail
  cd '$APP_BASE'
  export APP_ENV='dev'
  export DB_USER='myuser'
  export DB_PWD='mysecret'
  export LOG_DIR='$LOG_DIR_ABS'

  rm -f '$ARTIFACT_FILE'
  curl -fsSL -o '$ARTIFACT_FILE' '$ARTIFACT_URL'

  rm -rf '$APP_DIR'
  tar -xzf '$ARTIFACT_FILE'
  cd '$APP_DIR'
  npm install
  nohup node server.js > node-app.out 2>&1 &
  echo '✅ Running as:' \$(whoami)
"

pgrep -u myapp -f "node server.js" >/dev/null 2>&1 \
  && echo "✅ App running as myapp" \
  || echo "❌ App not running. Check $APP_BASE/$APP_DIR/node-app.out"
