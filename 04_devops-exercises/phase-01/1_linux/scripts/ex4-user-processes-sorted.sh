#!/usr/bin/env bash
set -euo pipefail

echo "=== EX4: Sort user processes by CPU or MEM ==="
read -rp "Sort by (cpu/mem): " sort_choice
sort_choice=$(echo "$sort_choice" | tr '[:upper:]' '[:lower:]')

case "$sort_choice" in
  cpu) ps -u "$USER" -o pid,ppid,%cpu,%mem,etime,cmd --sort=-%cpu ;;
  mem) ps -u "$USER" -o pid,ppid,%cpu,%mem,etime,cmd --sort=-%mem ;;
  *) echo "ERROR: choose cpu or mem"; exit 1 ;;
esac
