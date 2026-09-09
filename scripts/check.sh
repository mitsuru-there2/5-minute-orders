#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
run_checked() {
  local log
  log="$(mktemp)"
  if ! "$ROOT/scripts/godot.sh" --headless --path "$ROOT/game" "$@" >"$log" 2>&1; then
    cat "$log"; rm -f "$log"; return 1
  fi
  cat "$log"
  if grep -Eq 'SCRIPT ERROR:|ERROR:|Parse Error:' "$log"; then
    rm -f "$log"; return 1
  fi
  rm -f "$log"
}
run_checked --editor --import --quit
run_checked --script res://tests/run.gd
run_checked --quit-after 3
