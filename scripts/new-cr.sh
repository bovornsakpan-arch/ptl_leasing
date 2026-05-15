#!/bin/bash
# ============================================================
# new-cr.sh — Create Change Request folder with all required docs
# Usage: ./scripts/new-cr.sh CR-001 "change-name" "F-001"
# Example: ./scripts/new-cr.sh CR-001 "add-renewal-date" "F-002"
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TODAY=$(date +%Y-%m-%d)

# ── Args ──────────────────────────────────────────────────────
CR_ID="${1:-}"
CR_NAME="${2:-}"
FEATURE_ID="${3:-}"

if [[ -z "$CR_ID" || -z "$CR_NAME" || -z "$FEATURE_ID" ]]; then
  echo "Usage: ./scripts/new-cr.sh <cr-id> <change-name> <feature-id>"
  echo "Example: ./scripts/new-cr.sh CR-001 'add-renewal-date' 'F-002'"
  echo ""
  echo "This will create:"
  echo "  docs/00-discovery/01-requirements/new-features/F-002-xxx/changes/CR-001-add-renewal-date/"
  echo "    ├── BRD.md"
  echo "    ├── GAP_ANALYSIS.md"
  echo "    ├── IMPACT_ANALYSIS.md"
  echo "    ├── SRS.md"
  echo "    ├── ACCEPTANCE_CRITERIA.md"
  echo "    └── verification/.gitkeep"
  exit 1
fi

# Normalize CR name
CR_SLUG=$(echo "$CR_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]/-/g')
CR_FOLDER="${CR_ID}-${CR_SLUG}"

# Find the feature folder
FEATURES_DIR="$PROJECT_ROOT/docs/00-discovery/01-requirements/new-features"
FEATURE_DIR=$(find "$FEATURES_DIR" -maxdepth 1 -type d -name "${FEATURE_ID}-*" 2>/dev/null | head -1)

if [[ -z "$FEATURE_DIR" ]]; then
  echo "ERROR: Feature folder not found for $FEATURE_ID"
  echo "Create it first: ./scripts/new-feature.sh $FEATURE_ID 'feature-name'"
  exit 1
fi

CR_DIR="$FEATURE_DIR/changes/$CR_FOLDER"

if [[ -d "$CR_DIR" ]]; then
  echo "ERROR: CR folder already exists: $CR_DIR"
  exit 1
fi

echo "Creating CR: $CR_ID — $CR_NAME"
echo "Related to feature: $FEATURE_ID ($FEATURE_DIR)"
echo "CR folder: $CR_DIR"
echo ""

mkdir -p "$CR_DIR/verification"

# ── BRD.md ────────────────────────────────────────────────────
cat > "$CR_DIR/BRD.md" << HEREDOC
---
doc_id: "PTL-${CR_ID}-BRD"
title: "BRD (CR): ${CR_NAME}"
project: ptl_leasing
type: change_request
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "01-requirements"
cr_id: "${CR_ID}"
feature_id: "${FEATURE_ID}"
jira_issue: "PTL-TBD"
created_at: "${TODAY}"
updated_at: "${TODAY}"
reviewed_by: ""
approved_by: ""
---

# BRD (Change Request): ${CR_NAME}

> **CR ID**: ${CR_ID} | **Related Feature**: ${FEATURE_ID} | **Version**: 0.1.0

---

## 1. Change Request Background / ที่มา

*(อธิบาย context ว่าทำไมถึงมี CR นี้)*

---

## 2. Current State (As-Is)

*(อธิบายสถานะปัจจุบัน)*

---

## 3. Requested Change

*(อธิบายการเปลี่ยนแปลงที่ต้องการ)*

---

## 4. Business Justification

*(เหตุผลทางธุรกิจ)*

---

## 5. Scope of Change

*(ขอบเขตการเปลี่ยนแปลง)*

---

## 6. Impact Summary

| Area | Impact Level |
|------|-------------|
| Backend | TBD |
| Frontend | TBD |
| Database | TBD |

---

## 7. Success Criteria

- [ ] TBD

---

## Sign-off

| Role | Name | Status |
|------|------|--------|
| Business Owner | TBD | Pending |
| BA | Orawan Nus | Pending |
| PM | Bovornsak Pan | Pending |

---
*Created by: ./scripts/new-cr.sh | ${TODAY}*
HEREDOC

# ── GAP_ANALYSIS.md ───────────────────────────────────────────
cat > "$CR_DIR/GAP_ANALYSIS.md" << HEREDOC
---
doc_id: "PTL-${CR_ID}-GAP"
title: "Gap Analysis: ${CR_NAME}"
project: ptl_leasing
type: gap_analysis
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "01-requirements"
cr_id: "${CR_ID}"
feature_id: "${FEATURE_ID}"
created_at: "${TODAY}"
updated_at: "${TODAY}"
reviewed_by: ""
approved_by: ""
---

# Gap Analysis: ${CR_NAME}

> **CR ID**: ${CR_ID} | **Version**: 0.1.0

---

## 1. Reference Documents

| Document | Location |
|----------|----------|
| BRD (CR) | ./BRD.md |
| Original BRD | ../BRD.md |

---

## 2. As-Is Analysis

*(อธิบายสถานะปัจจุบัน)*

---

## 3. To-Be Analysis

*(อธิบายสถานะที่ต้องการ)*

---

## 4. Gap Analysis Table

| Area | As-Is | To-Be | Gap Type | Impact | Priority |
|------|-------|-------|----------|--------|---------|
| TBD | | | | | |

---

## 5. Estimated Effort

| Area | Effort (days) |
|------|--------------|
| Total | TBD |

---
*Created by: ./scripts/new-cr.sh | ${TODAY}*
HEREDOC

# ── IMPACT_ANALYSIS.md ────────────────────────────────────────
cat > "$CR_DIR/IMPACT_ANALYSIS.md" << HEREDOC
---
doc_id: "PTL-${CR_ID}-IMPACT"
title: "Impact Analysis: ${CR_NAME}"
project: ptl_leasing
type: impact_analysis
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
phase: "01-requirements"
cr_id: "${CR_ID}"
feature_id: "${FEATURE_ID}"
created_at: "${TODAY}"
updated_at: "${TODAY}"
reviewed_by: ""
approved_by: ""
---

# Impact Analysis: ${CR_NAME}

> **CR ID**: ${CR_ID} | **Version**: 0.1.0

---

## 2. Affected Systems

### APIs

| Endpoint | Impact | Backward Compatible? |
|----------|--------|---------------------|
| TBD | TBD | TBD |

### Database

| Table | Impact | Migration |
|-------|--------|-----------|
| TBD | TBD | TBD |

---

## 3. Risk Level

**Overall Risk**: High / Medium / Low

---

## 4. Rollback Plan

1. Rollback application version
2. Rollback database migration

---

## 5. Migration Plan

1. Backup production DB
2. Run migration script
3. Deploy new version
4. Monitor

---
*Created by: ./scripts/new-cr.sh | ${TODAY}*
HEREDOC

# ── SRS.md ────────────────────────────────────────────────────
cat > "$CR_DIR/SRS.md" << HEREDOC
---
doc_id: "PTL-${CR_ID}-SRS"
title: "SRS (CR): ${CR_NAME}"
project: ptl_leasing
type: srs
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
phase: "02-design"
cr_id: "${CR_ID}"
feature_id: "${FEATURE_ID}"
created_at: "${TODAY}"
updated_at: "${TODAY}"
reviewed_by: ""
approved_by: ""
---

# SRS (CR): ${CR_NAME}

> **CR ID**: ${CR_ID} | **Version**: 0.1.0

---

## 2. Functional Requirements (Changed/Added)

| Req ID | Description | Priority | Change Type |
|--------|-------------|---------|------------|
| FR-C-001 | TBD | Must | Add/Modify/Remove |

---
*Created by: ./scripts/new-cr.sh | ${TODAY}*
HEREDOC

# ── ACCEPTANCE_CRITERIA.md ────────────────────────────────────
cat > "$CR_DIR/ACCEPTANCE_CRITERIA.md" << HEREDOC
---
doc_id: "PTL-${CR_ID}-AC"
title: "Acceptance Criteria (CR): ${CR_NAME}"
project: ptl_leasing
type: acceptance_criteria
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "04-breakdown"
cr_id: "${CR_ID}"
feature_id: "${FEATURE_ID}"
created_at: "${TODAY}"
updated_at: "${TODAY}"
reviewed_by: ""
approved_by: ""
---

# Acceptance Criteria (CR): ${CR_NAME}

> **CR ID**: ${CR_ID} | **Version**: 0.1.0

---

## AC-${CR_ID}-001: [Changed Behavior]

\`\`\`gherkin
Given [สถานการณ์หลังการเปลี่ยนแปลง]
When [action]
Then [ผลลัพธ์ใหม่ที่คาดหวัง]
\`\`\`

---
*Created by: ./scripts/new-cr.sh | ${TODAY}*
HEREDOC

# ── .gitkeep ──────────────────────────────────────────────────
touch "$CR_DIR/verification/.gitkeep"

# ── Summary ───────────────────────────────────────────────────
echo "✓ CR folder created successfully!"
echo ""
echo "Files created:"
find "$CR_DIR" -type f | sed "s|$PROJECT_ROOT/||"
echo ""
echo "Next steps:"
echo "  1. Edit BRD.md — fill in change request background"
echo "  2. Edit GAP_ANALYSIS.md — As-Is vs To-Be"
echo "  3. Edit IMPACT_ANALYSIS.md — affected systems"
echo "  4. Run: git add . && git commit -m 'feat(requirements): add ${CR_ID} ${CR_NAME}'"
echo "  5. Create PR for BA/PM review"
