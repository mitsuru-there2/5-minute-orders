#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
export UV_CACHE_DIR="$ROOT/.tools/uv-cache"
case "${1:-check}" in
  format) uv run --locked gdformat game/src game/scenes game/tests ;;
  lint) uv run --locked gdlint game/src game/scenes game/tests ;;
  check)
    uv run --locked gdformat --check game/src game/scenes game/tests
    uv run --locked gdlint game/src game/scenes game/tests
    ;;
  *) echo 'Usage: scripts/style.sh [format|lint|check]' >&2; exit 2 ;;
esac
