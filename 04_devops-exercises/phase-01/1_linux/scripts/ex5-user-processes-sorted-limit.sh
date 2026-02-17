#!/usr/bin/env bash
set -euo pipefail

echo "=== EX5: Sort + limit user processes ==="
read -rp "Sort by (cpu/mem): " sort_choice
sort_choice=$(echo "$sort_choice" | tr '[:upper:]' '[:lower:]')

read -rp "How many processes to print? " limit
if ! [[ "$limit" =~ ^[0-9]+$ ]] || [[ "$limit" -le 0 ]]; then
  echo "ERROR: Enter a positive number."
  exit 1
fi

case "$sort_choice" in
  cpu) ps -u "$USER" -o pid,ppid,%cpu,%mem,etime,cmd --sort=-%cpu | head -n $((limit + 1)) ;;
  mem) ps -u "$USER" -o pid,ppid,%cpu,%mem,etime,cmd --sort=-%mem | head -n $((limit + 1)) ;;
  *) echo "ERROR: choose cpu or mem"; exit 1 ;;
esac
