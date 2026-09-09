#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VERSION="$(cat "$ROOT/.godot-version")"
case "$(uname -s)/$(uname -m)" in
  Darwin/*) ASSET="Godot_v${VERSION}-stable_macos.universal.zip" ;;
  Linux/x86_64) ASSET="Godot_v${VERSION}-stable_linux.x86_64.zip" ;;
  *) echo 'Use official Godot Standard archive and set GODOT_BIN on this platform.' >&2; exit 1 ;;
esac
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
BASE="https://github.com/godotengine/godot/releases/download/${VERSION}-stable"
curl --fail --location --retry 3 "$BASE/$ASSET" -o "$TMP/$ASSET"
curl --fail --location --retry 3 "$BASE/SHA512-SUMS.txt" -o "$TMP/SHA512-SUMS.txt"
python3 - "$TMP" "$ASSET" <<'PY'
import hashlib, pathlib, sys
folder, name = pathlib.Path(sys.argv[1]), sys.argv[2]
entries = [line.split() for line in (folder / 'SHA512-SUMS.txt').read_text().splitlines() if line.strip()]
expected = next(parts[0] for parts in entries if parts[-1].lstrip('*') == name)
actual = hashlib.sha512((folder / name).read_bytes()).hexdigest()
if actual != expected:
    raise SystemExit('SHA512 mismatch')
print('SHA512 verified:', name)
PY
mkdir -p "$ROOT/.tools"
unzip -q -o "$TMP/$ASSET" -d "$ROOT/.tools"
if [[ "$(uname -s)" == Linux ]]; then
  mv "$ROOT/.tools/Godot_v${VERSION}-stable_linux.x86_64" "$ROOT/.tools/godot"
  chmod +x "$ROOT/.tools/godot"
fi
"$ROOT/scripts/godot.sh" --version
