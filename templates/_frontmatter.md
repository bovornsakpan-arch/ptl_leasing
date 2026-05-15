---
# ============================================================
# PT Leasing SDLC Framework — Frontmatter Reference
# ============================================================
# คัดลอก frontmatter นี้ไปใช้ในเอกสารใหม่
# ลบ comment (#) ออกก่อนใช้งาน

doc_id: "PTL-DOC-XXX"           # Required: รหัสเอกสาร (เช่น PTL-F001-BRD, PTL-CR001-GAP)
title: "Document Title"          # Required: ชื่อเอกสาร
project: ptl_leasing             # Required: ใส่ ptl_leasing เสมอ
type: new_feature                # Required: new_feature | change_request | brd | srs | gap_analysis
                                 #           impact_analysis | architecture | adr | test_case |
                                 #           test_strategy | acceptance_criteria | security_design |
                                 #           validation | story | task | readiness | handoff |
                                 #           user_manual | design | requirements
version: "0.1.0"                 # Required: Semantic version (MAJOR.MINOR.PATCH)
status: draft                    # Required: draft | in_review | approved | final | superseded | rejected
owner: email@snocko-tech.com     # Required: email ของเจ้าของเอกสาร (ต้องอยู่ใน config/users.yaml)

# Optional fields
phase: "01-requirements"         # Phase ที่เอกสารนี้สังกัด (01-requirements through 05-ready)
feature_id: "F-XXX"             # ID ของ feature ที่เกี่ยวข้อง
cr_id: "CR-XXX"                  # ID ของ CR ที่เกี่ยวข้อง (ถ้าเป็น CR)
epic: "EPIC-XX"                  # Epic ที่เอกสารนี้สังกัด
jira_issue: "PTL-XXX"           # Jira issue ที่เชื่อมโยง
related_jira: "PTL-XXX"         # Alias ของ jira_issue

created_at: "2026-05-15"        # วันที่สร้างเอกสาร
updated_at: "2026-05-15"        # วันที่อัปเดตล่าสุด
reviewed_by: ""                  # email ของผู้ review
approved_by: ""                  # email ของผู้ approve
approved_at: ""                  # วันที่ approve

# ============================================================
# Version History (optional — สำหรับเอกสารที่มี history ยาว)
# ============================================================
# version_history:
#   - version: "0.1.0"
#     date: "2026-05-15"
#     author: "email@snocko-tech.com"
#     summary: "Initial draft"
#   - version: "0.2.0"
#     date: "2026-05-20"
#     author: "email@snocko-tech.com"
#     summary: "Updated after review session"
#   - version: "1.0.0"
#     date: "2026-05-25"
#     author: "email@snocko-tech.com"
#     summary: "Approved by PM"
# ============================================================
---

# Document Title

> *(เอกสาร description สั้น ๆ)*

...
