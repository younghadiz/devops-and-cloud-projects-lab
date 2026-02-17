#!/usr/bin/env bash
set -euo pipefail

echo "=== EX2: Install Java and verify version (>=11) ==="

sudo apt update -y
sudo apt install -y default-jre

if ! command -v java >/dev/null 2>&1; then
  echo "❌ Java is NOT installed (java command not found)."
  exit 1
fi

JAVA_VERSION_RAW=$(java -version 2>&1 | head -n 1)
echo "Detected: $JAVA_VERSION_RAW"

JAVA_MAJOR=$(echo "$JAVA_VERSION_RAW" | awk -F'"' '{print $2}' | awk -F. '{print $1}')
if [[ "$JAVA_MAJOR" == "1" ]]; then
  JAVA_MAJOR=$(echo "$JAVA_VERSION_RAW" | awk -F'"' '{print $2}' | awk -F. '{print $2}')
fi

if (( JAVA_MAJOR < 11 )); then
  echo "⚠️ Java is installed but too old (major=$JAVA_MAJOR). Need >=11."
  exit 1
fi

echo "✅ Success: Java major version is $JAVA_MAJOR (>=11)."
