#!/usr/bin/env bash
set -euo pipefail

echo "=== EX3: Processes for current user ==="
echo "USER: $USER"
ps aux | awk -v u="$USER" 'NR==1 || $1==u {print}'
