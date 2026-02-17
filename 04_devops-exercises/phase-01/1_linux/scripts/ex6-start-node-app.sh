#!/usr/bin/env bash
set -euo pipefail

echo "=== EX6: Start Node app (env vars + background) ==="

ARTIFACT_URL="https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"
ARTIFACT_FILE="bootcamp-node-envvars-project-1.0.0.tgz"
APP_DIR="package"

sudo apt update -y
sudo apt install -y nodejs npm curl tar

echo "Node: $(node -v)"
echo "NPM : $(npm -v)"

rm -f "$ARTIFACT_FILE"
curl -fsSL -o "$ARTIFACT_FILE" "$ARTIFACT_URL"

rm -rf "$APP_DIR"
tar -xzf "$ARTIFACT_FILE"

export APP_ENV="dev"
export DB_USER="myuser"
export DB_PWD="mysecret"

cd "$APP_DIR"
npm install

nohup node server.js > node-app.out 2>&1 &
echo "✅ Started in background. Log: $(pwd)/node-app.out"
