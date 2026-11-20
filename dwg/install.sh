#!/usr/bin/env bash
# Installe dwg2dxf (LibreDWG 0.13.3, binaire Linux x86_64 precompile): quelques secondes.
# Si le binaire ne tourne pas sur cette machine, bascule sur la compilation (5 a 10 min).
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
DEST="${HOME}/.local/bin"
mkdir -p "$DEST"
if [ "$(uname -s)-$(uname -m)" = "Linux-x86_64" ]; then
  gunzip -c "$HERE/bin/linux-x86_64/dwg2dxf.gz" > "$DEST/dwg2dxf"
  chmod +x "$DEST/dwg2dxf"
  if "$DEST/dwg2dxf" --version >/dev/null 2>&1; then
    echo "dwg2dxf installe dans $DEST (ajoute au PATH: export PATH=\$HOME/.local/bin:\$PATH)"
    exit 0
  fi
fi
echo "Binaire precompile inutilisable ici, compilation..."
bash "$HERE/install-compile.sh"
