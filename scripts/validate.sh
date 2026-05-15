#!/bin/bash
# ============================================================
# validate.sh — Validate frontmatter in all doc files
# Usage: ./scripts/validate.sh [--strict]
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

STRICT="${1:-}"
ERRORS=0
WARNINGS=0
CHECKED=0
SKIPPED=0

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  PT Leasing — Document Validation${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

VALID_STATUSES="draft in_review approved final superseded rejected"

check_frontmatter() {
  local file="$1"

  # Check if file starts with ---
  local first_line
  first_line=$(head -1 "$file")
  if [[ "$first_line" != "---" ]]; then
    SKIPPED=$((SKIPPED + 1))
    return 0
  fi

  CHECKED=$((CHECKED + 1))

  # Extract frontmatter (between first and second ---)
  local fm
  fm=$(awk '/^---/{i++; if(i==2) exit} i==1 && !/^---/' "$file")

  # Check required fields
  for field in doc_id title version status owner; do
    local value
    value=$(echo "$fm" | grep "^${field}:" | sed 's/^[^:]*: *//' | tr -d '"' | tr -d "'")
    if [[ -z "$value" ]]; then
      echo -e "  ${RED}ERROR${NC}: $file — Missing required field: '$field'"
      ERRORS=$((ERRORS + 1))
    fi
  done

  # Validate status
  local status
  status=$(echo "$fm" | grep "^status:" | sed 's/^status: *//' | tr -d '"' | tr -d "'")
  if [[ -n "$status" ]]; then
    local valid=false
    for s in $VALID_STATUSES; do
      if [[ "$status" == "$s" ]]; then valid=true; break; fi
    done
    if [[ "$valid" == "false" ]]; then
      echo -e "  ${RED}ERROR${NC}: $file — Invalid status: '$status'"
      ERRORS=$((ERRORS + 1))
    fi
  fi

  # Validate version format (semver x.y.z)
  local version
  version=$(echo "$fm" | grep "^version:" | sed 's/^version: *//' | tr -d '"' | tr -d "'")
  if [[ -n "$version" ]]; then
    if ! echo "$version" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then
      echo -e "  ${RED}ERROR${NC}: $file — Version '$version' not semver (X.Y.Z)"
      ERRORS=$((ERRORS + 1))
    fi
  fi

  # Validate owner is email format
  local owner
  owner=$(echo "$fm" | grep "^owner:" | sed 's/^owner: *//' | tr -d '"' | tr -d "'")
  if [[ -n "$owner" ]]; then
    if ! echo "$owner" | grep -qE '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; then
      echo -e "  ${YELLOW}WARN${NC}:  $file — Owner '$owner' is not a valid email"
      WARNINGS=$((WARNINGS + 1))
    fi
  fi
}

# Scan docs/ and templates/
for dir in docs templates; do
  if [[ ! -d "$PROJECT_ROOT/$dir" ]]; then continue; fi
  while IFS= read -r -d '' file; do
    # Skip user-manual (MkDocs manages it)
    if [[ "$file" == *"user-manual"* ]]; then
      SKIPPED=$((SKIPPED + 1))
      continue
    fi
    check_frontmatter "$file"
  done < <(find "$PROJECT_ROOT/$dir" -name "*.md" -print0 2>/dev/null)
done

echo ""
echo -e "${BLUE}============================================${NC}"
echo "Files checked:  $CHECKED"
echo "Files skipped:  $SKIPPED (no frontmatter)"
echo -e "Errors:         ${RED}$ERRORS${NC}"
echo -e "Warnings:       ${YELLOW}$WARNINGS${NC}"
echo -e "${BLUE}============================================${NC}"

if [[ $ERRORS -gt 0 ]]; then
  echo -e "${RED}VALIDATION FAILED — $ERRORS error(s) found${NC}"
  exit 1
else
  echo -e "${GREEN}VALIDATION PASSED${NC}"
  exit 0
fi
