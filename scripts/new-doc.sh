#!/bin/bash
# ============================================================
# new-doc.sh — Create a new doc from template
# Usage: ./scripts/new-doc.sh <template-name> <output-path> <doc-id>
# Example: ./scripts/new-doc.sh ADR docs/00-discovery/02-design/architecture/adr/ADR-0002-use-react.md PTL-ADR-0002
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TEMPLATES_DIR="$PROJECT_ROOT/templates"
TODAY=$(date +%Y-%m-%d)

TEMPLATE_NAME="${1:-}"
OUTPUT_PATH="${2:-}"
DOC_ID="${3:-}"

if [[ -z "$TEMPLATE_NAME" || -z "$OUTPUT_PATH" || -z "$DOC_ID" ]]; then
  echo "Usage: ./scripts/new-doc.sh <template-name> <output-path> <doc-id>"
  echo ""
  echo "Available templates:"
  ls "$TEMPLATES_DIR"/*.template.md 2>/dev/null | sed 's|.*/||' | sed 's/\.template\.md//'
  echo ""
  echo "Examples:"
  echo "  ./scripts/new-doc.sh ADR docs/00-discovery/02-design/architecture/adr/ADR-0002.md PTL-ADR-0002"
  echo "  ./scripts/new-doc.sh BRD-new-feature docs/00-discovery/01-requirements/new-features/F-001/BRD.md PTL-F001-BRD"
  exit 1
fi

# Find template file
TEMPLATE_FILE="$TEMPLATES_DIR/${TEMPLATE_NAME}.template.md"
if [[ ! -f "$TEMPLATE_FILE" ]]; then
  echo "ERROR: Template not found: $TEMPLATE_FILE"
  echo "Available templates:"
  ls "$TEMPLATES_DIR"/*.template.md | sed 's|.*/||' | sed 's/\.template\.md//'
  exit 1
fi

# Resolve output path
if [[ "$OUTPUT_PATH" != /* ]]; then
  OUTPUT_PATH="$PROJECT_ROOT/$OUTPUT_PATH"
fi

if [[ -f "$OUTPUT_PATH" ]]; then
  echo "ERROR: Output file already exists: $OUTPUT_PATH"
  echo "Delete it first or choose a different path."
  exit 1
fi

# Create parent directory
mkdir -p "$(dirname "$OUTPUT_PATH")"

# Copy template and replace doc_id placeholder
sed "s/PTL-DOC-XXX/$DOC_ID/g" "$TEMPLATE_FILE" | \
  sed "s/YYYY-MM-DD/$TODAY/g" \
  > "$OUTPUT_PATH"

echo "✓ Created: $OUTPUT_PATH"
echo "  Template: $TEMPLATE_NAME"
echo "  Doc ID:   $DOC_ID"
echo ""
echo "Remember to update the frontmatter fields (title, owner, etc.)"
