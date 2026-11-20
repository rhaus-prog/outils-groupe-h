#!/usr/bin/env bash
# Installe LibreDWG 0.13.3 (dwg2dxf) dans ~/.local/libredwg et ajoute ~/.local/bin au PATH.
# Usage: bash dwg/install.sh   (environ 5 a 10 minutes de compilation)
set -euo pipefail
VERSION=0.13.3
PREFIX="${HOME}/.local/libredwg"
if [ -x "${PREFIX}/bin/dwg2dxf" ]; then echo "Deja installe: ${PREFIX}/bin/dwg2dxf"; exit 0; fi
WORK="$(mktemp -d)"
cd "$WORK"
curl -fsSL -o libredwg.tar.xz "https://github.com/LibreDWG/libredwg/releases/download/${VERSION}/libredwg-${VERSION}.tar.xz"
tar xf libredwg.tar.xz
cd "libredwg-${VERSION}"
./configure --prefix="$PREFIX" --disable-bindings --disable-docs >/dev/null
make -j"$(nproc)" >/dev/null
make install >/dev/null
mkdir -p "${HOME}/.local/bin"
ln -sf "${PREFIX}/bin/dwg2dxf" "${HOME}/.local/bin/dwg2dxf"
ln -sf "${PREFIX}/bin/dwgread" "${HOME}/.local/bin/dwgread"
echo "Installe. Ajoute au PATH si besoin: export PATH=\$HOME/.local/bin:\$PATH"
"${PREFIX}/bin/dwg2dxf" --version
