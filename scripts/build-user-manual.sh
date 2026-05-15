#!/bin/bash
# ============================================================
# build-user-manual.sh — Build MkDocs user manual
# Usage: ./scripts/build-user-manual.sh [--deploy VERSION]
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
MANUAL_DIR="$PROJECT_ROOT/docs/user-manual"

DEPLOY_FLAG="${1:-}"
VERSION="${2:-latest}"

echo "Building PT Leasing User Manual..."
echo "Directory: $MANUAL_DIR"
echo ""

# Check mkdocs is installed
if ! command -v mkdocs &> /dev/null; then
  echo "ERROR: mkdocs not found. Install with:"
  echo "  pip install mkdocs-material mike"
  exit 1
fi

cd "$MANUAL_DIR"

if [[ "$DEPLOY_FLAG" == "--deploy" ]]; then
  echo "Deploying version: $VERSION"
  if ! command -v mike &> /dev/null; then
    echo "ERROR: mike not found. Install with: pip install mike"
    exit 1
  fi
  mike deploy --update-aliases "$VERSION" latest
  mike set-default latest
  echo "✓ Deployed version $VERSION to GitHub Pages"
else
  echo "Building static site..."
  mkdocs build --strict
  echo ""
  echo "✓ Site built at: $MANUAL_DIR/site/"
  echo ""
  echo "To serve locally: cd $MANUAL_DIR && mkdocs serve"
  echo "To deploy: ./scripts/build-user-manual.sh --deploy 1.0"
fi
