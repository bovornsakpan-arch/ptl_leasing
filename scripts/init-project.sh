#!/bin/bash
# ============================================================
# init-project.sh — Initialize a new SDLC project from this template
# Usage: ./scripts/init-project.sh <project-name> <project-code> <target-dir>
# Example: ./scripts/init-project.sh "PT Insurance" "PTI" /Users/me/Projects/PT_insurance
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$(dirname "$SCRIPT_DIR")"

PROJECT_NAME="${1:-}"
PROJECT_CODE="${2:-}"
TARGET_DIR="${3:-}"

if [[ -z "$PROJECT_NAME" || -z "$PROJECT_CODE" || -z "$TARGET_DIR" ]]; then
  echo "Usage: ./scripts/init-project.sh <project-name> <project-code> <target-dir>"
  echo ""
  echo "Example:"
  echo "  ./scripts/init-project.sh 'PT Insurance' 'PTI' /Users/me/Projects/PT_insurance"
  echo ""
  echo "This will copy the entire SDLC framework structure to <target-dir>"
  echo "and substitute project name/code throughout."
  exit 1
fi

PROJECT_CODE_UPPER=$(echo "$PROJECT_CODE" | tr '[:lower:]' '[:upper:]')
TODAY=$(date +%Y-%m-%d)

echo "Initializing new SDLC project:"
echo "  Name:   $PROJECT_NAME"
echo "  Code:   $PROJECT_CODE_UPPER"
echo "  Target: $TARGET_DIR"
echo ""

# Check target doesn't exist
if [[ -d "$TARGET_DIR" ]]; then
  echo "ERROR: Target directory already exists: $TARGET_DIR"
  echo "Delete it first or choose a different directory."
  exit 1
fi

# Copy everything except git history and generated artifacts
rsync -a --exclude='.git' --exclude='docs/user-manual/site/' \
  --exclude='node_modules/' --exclude='__pycache__/' \
  --exclude='*.pyc' --exclude='.DS_Store' \
  "$SOURCE_DIR/" "$TARGET_DIR/"

echo "Copied template structure to $TARGET_DIR"
echo ""

# Substitute project name/code in key files
substitute_in_file() {
  local file="$1"
  if [[ -f "$file" ]]; then
    sed -i.bak \
      -e "s/PT Leasing/${PROJECT_NAME}/g" \
      -e "s/ptl_leasing/${PROJECT_CODE,,}_leasing/g" \
      -e "s/PTL/${PROJECT_CODE_UPPER}/g" \
      -e "s/2026-05-15/${TODAY}/g" \
      "$file"
    rm -f "${file}.bak"
  fi
}

KEY_FILES=(
  "$TARGET_DIR/README.md"
  "$TARGET_DIR/PROJECT_STATUS.md"
  "$TARGET_DIR/CHANGELOG.md"
  "$TARGET_DIR/config/project.yaml"
  "$TARGET_DIR/config/tracking.yaml"
  "$TARGET_DIR/dashboard/data/status.json"
)

for f in "${KEY_FILES[@]}"; do
  substitute_in_file "$f"
done

# Initialize git
cd "$TARGET_DIR"
git init
git add .
git commit -m "feat: initialize SDLC framework for ${PROJECT_NAME} (${PROJECT_CODE_UPPER})"

echo ""
echo "✓ Project initialized successfully!"
echo ""
echo "Next steps:"
echo "  1. cd $TARGET_DIR"
echo "  2. Edit config/project.yaml — update pm_email, repository, figma_workspace"
echo "  3. Edit config/users.yaml — add your team members"
echo "  4. Set up GitHub repository and push"
echo "  5. Add secrets: JIRA_API_TOKEN, JIRA_USER_EMAIL in GitHub settings"
echo "  6. Open dashboard/index.html to see the PM dashboard"
