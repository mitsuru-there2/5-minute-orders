#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
if [[ -n "${GODOT_BIN:-}" ]]; then
  BIN="$GODOT_BIN"
elif [[ -x "$ROOT/.tools/Godot.app/Contents/MacOS/Godot" ]]; then
  BIN="$ROOT/.tools/Godot.app/Contents/MacOS/Godot"
elif [[ -x "$ROOT/.tools/godot" ]]; then
  BIN="$ROOT/.tools/godot"
else
  echo 'Godot missing: run ./scripts/setup.sh or set GODOT_BIN.' >&2
  exit 1
fi
VERSION="$(cat "$ROOT/.godot-version")"
ACTUAL="$("$BIN" --version)"
[[ "$ACTUAL" == "$VERSION.stable."* ]] || { echo "Expected $VERSION stable, got $ACTUAL" >&2; exit 1; }
exec "$BIN" "$@"
