#!/bin/bash
# ============================================================
# new-feature.sh — Create new feature folder with all required docs
# Usage: ./scripts/new-feature.sh F-001 "feature-name"
# Example: ./scripts/new-feature.sh F-001 "contract-management"
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TODAY=$(date +%Y-%m-%d)

# ── Args ──────────────────────────────────────────────────────
FEATURE_ID="${1:-}"
FEATURE_NAME="${2:-}"

if [[ -z "$FEATURE_ID" || -z "$FEATURE_NAME" ]]; then
  echo "Usage: ./scripts/new-feature.sh <feature-id> <feature-name>"
  echo "Example: ./scripts/new-feature.sh F-001 'contract-management'"
  echo ""
  echo "This will create:"
  echo "  docs/00-discovery/01-requirements/new-features/F-001-contract-management/"
  echo "    ├── BRD.md"
  echo "    ├── SRS.md"
  echo "    ├── ACCEPTANCE_CRITERIA.md"
  echo "    └── verification/.gitkeep"
  exit 1
fi

# Normalize feature name (lowercase, hyphens)
FEATURE_SLUG=$(echo "$FEATURE_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]/-/g')
FOLDER_NAME="${FEATURE_ID}-${FEATURE_SLUG}"
FEATURE_DIR="$PROJECT_ROOT/docs/00-discovery/01-requirements/new-features/$FOLDER_NAME"

# ── Check if folder already exists ────────────────────────────
if [[ -d "$FEATURE_DIR" ]]; then
  echo "ERROR: Feature folder already exists: $FEATURE_DIR"
  echo "If you want to recreate it, delete the folder first."
  exit 1
fi

echo "Creating feature: $FEATURE_ID — $FEATURE_NAME"
echo "Folder: $FEATURE_DIR"
echo ""

# ── Create directories ─────────────────────────────────────────
mkdir -p "$FEATURE_DIR/verification"
mkdir -p "$FEATURE_DIR/changes"

# ── BRD.md ────────────────────────────────────────────────────
cat > "$FEATURE_DIR/BRD.md" << HEREDOC
---
doc_id: "PTL-${FEATURE_ID}-BRD"
title: "BRD: ${FEATURE_NAME}"
project: ptl_leasing
type: new_feature
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "01-requirements"
feature_id: "${FEATURE_ID}"
jira_issue: "PTL-TBD"
created_at: "${TODAY}"
updated_at: "${TODAY}"
reviewed_by: ""
approved_by: ""
---

# BRD: ${FEATURE_NAME}
# Business Requirements Document

> **Feature ID**: ${FEATURE_ID} | **Version**: 0.1.0 | **Status**: Draft

---

## 1. Business Context / บริบทธุรกิจ

*(อธิบาย context ว่าทำไมต้องมี feature นี้)*

---

## 2. Problem Statement / ปัญหาที่ต้องการแก้ไข

*(อธิบายปัญหาปัจจุบัน)*

---

## 3. Proposed Solution / วิธีแก้ไขที่เสนอ

*(อธิบาย solution ในระดับ high-level)*

---

## 4. Scope / ขอบเขต

### In Scope
- [ ] TBD

### Out of Scope
- TBD

---

## 5. Stakeholders / ผู้มีส่วนได้เสีย

| Role | Name | Responsibility |
|------|------|---------------|
| Business Owner | TBD | Final approval |
| BA | Orawan Nus | Document requirements |
| PM | Bovornsak Pan | Project management |

---

## 6. Business Rules / กฎธุรกิจ

| Rule ID | Description |
|---------|-------------|
| BR-001 | TBD |

---

## 7. Assumptions & Constraints

*(กรอกสมมติฐานและข้อจำกัด)*

---

## 8. Success Metrics / ตัวชี้วัด

| Metric | Target |
|--------|--------|
| TBD | TBD |

---

## Sign-off

| Role | Name | Status | Date |
|------|------|--------|------|
| Business Owner | TBD | Pending | |
| BA | Orawan Nus | Pending | |
| PM | Bovornsak Pan | Pending | |

---
*Created by: ./scripts/new-feature.sh | ${TODAY}*
HEREDOC

# ── SRS.md ────────────────────────────────────────────────────
cat > "$FEATURE_DIR/SRS.md" << HEREDOC
---
doc_id: "PTL-${FEATURE_ID}-SRS"
title: "SRS: ${FEATURE_NAME}"
project: ptl_leasing
type: srs
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
phase: "02-design"
feature_id: "${FEATURE_ID}"
jira_issue: "PTL-TBD"
created_at: "${TODAY}"
updated_at: "${TODAY}"
reviewed_by: ""
approved_by: ""
---

# SRS: ${FEATURE_NAME}
# Software Requirements Specification

> **Feature ID**: ${FEATURE_ID} | **Version**: 0.1.0 | **Based on BRD**: PTL-${FEATURE_ID}-BRD

---

## 2. Functional Requirements

| Req ID | Description | Priority | Source |
|--------|-------------|---------|--------|
| FR-001 | TBD | Must | BRD §3 |

---

## 3. Non-Functional Requirements

| Category | Requirement |
|---------|------------|
| Performance | Response time < 2s (p95) |
| Security | Authentication required |
| PDPA | Comply with PDPA |

---

## 4. Constraints

- ต้องใช้ tech stack ตาม TECH_STACK.md

---

*Created by: ./scripts/new-feature.sh | ${TODAY}*
HEREDOC

# ── ACCEPTANCE_CRITERIA.md ────────────────────────────────────
cat > "$FEATURE_DIR/ACCEPTANCE_CRITERIA.md" << HEREDOC
---
doc_id: "PTL-${FEATURE_ID}-AC"
title: "Acceptance Criteria: ${FEATURE_NAME}"
project: ptl_leasing
type: acceptance_criteria
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "04-breakdown"
feature_id: "${FEATURE_ID}"
jira_issue: "PTL-TBD"
created_at: "${TODAY}"
updated_at: "${TODAY}"
reviewed_by: ""
approved_by: ""
---

# Acceptance Criteria: ${FEATURE_NAME}

> **Feature ID**: ${FEATURE_ID} | **Version**: 0.1.0

---

## AC-${FEATURE_ID}-001: [Happy Path]

\`\`\`gherkin
Given [สถานการณ์เริ่มต้น]
When [action ที่ผู้ใช้ทำ]
Then [ผลลัพธ์ที่คาดหวัง]
\`\`\`

---

## AC-${FEATURE_ID}-002: [Validation]

\`\`\`gherkin
Given [สถานการณ์]
When [กรอกข้อมูลไม่ถูกต้อง]
Then [แสดง error message]
\`\`\`

---

## Sign-off

| Role | Status | Date |
|------|--------|------|
| BA | Pending | |
| Business Owner | Pending | |
| PM | Pending | |

---
*Created by: ./scripts/new-feature.sh | ${TODAY}*
HEREDOC

# ── .gitkeep ──────────────────────────────────────────────────
touch "$FEATURE_DIR/verification/.gitkeep"

# ── Summary ───────────────────────────────────────────────────
echo "✓ Feature folder created successfully!"
echo ""
echo "Files created:"
find "$FEATURE_DIR" -type f | sed "s|$PROJECT_ROOT/||"
echo ""
echo "Next steps:"
echo "  1. Edit $FOLDER_NAME/BRD.md — fill in business requirements"
echo "  2. Run: git add . && git commit -m 'feat(requirements): add BRD for ${FEATURE_ID} ${FEATURE_NAME}'"
echo "  3. Create PR for BA/PM review"
echo ""
echo "Remember to update config/feature-versions.yaml!"
