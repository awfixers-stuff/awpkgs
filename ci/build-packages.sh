#!/usr/bin/env bash
# Build every awpkgs flake output for x86_64-linux.
# Exits non-zero if any package fails to build.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

SYSTEM="${AWPKGS_SYSTEM:-x86_64-linux}"
ARTIFACT_DIR="${AWPKGS_ARTIFACT_DIR:-$ROOT/ci/out/artifacts}"
MANIFEST="$ARTIFACT_DIR/manifest.json"

# Keep in sync with flake.nix packages.x86_64-linux (exclude "default").
PACKAGES=(
  cursor
  helium
  antigravity
  bun-latest
  readest
  zed-staging
  zen-browser
)

mkdir -p "$ARTIFACT_DIR"
rm -rf "$ROOT/ci/out/build-links"
mkdir -p "$ROOT/ci/out/build-links"

echo '[' >"$MANIFEST"
first=1

for pkg in "${PACKAGES[@]}"; do
  echo "==> Building .#${pkg}"
  link="$ROOT/ci/out/build-links/${pkg}"
  rm -f "$link"
  nix build ".#${pkg}" --out-link "$link" --print-build-logs

  out_path="$(readlink -f "$link")"
  version="$(nix eval --raw ".#${pkg}.version" 2>/dev/null || echo "unknown")"

  if [[ "$first" -eq 1 ]]; then
    first=0
  else
    echo ',' >>"$MANIFEST"
  fi

  printf '  {"name":"%s","version":"%s","storePath":"%s"}' \
    "$pkg" "$version" "$out_path" >>"$MANIFEST"

  tar_path="$ARTIFACT_DIR/${pkg}.tar.gz"
  echo "==> Archiving ${pkg} -> ${tar_path}"
  tar -czf "$tar_path" -C "$out_path" .

done

echo '' >>"$MANIFEST"
echo ']' >>"$MANIFEST"

echo "==> All packages built successfully"
echo "==> Manifest: $MANIFEST"