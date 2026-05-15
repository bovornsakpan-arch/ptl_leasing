# PT Leasing — SDLC Framework 🏢

> ระบบจัดการเอกสารและ workflow สำหรับโปรเจกต์ PT Leasing (PTL)
> SDLC Documentation Framework for PT Leasing Backoffice System

---

## Overview / ภาพรวม

โปรเจกต์ **PT Leasing** เป็นระบบ backoffice สำหรับธุรกิจลีสซิ่ง ซึ่ง framework นี้ครอบคลุม:
- Document management ตลอดวงจรชีวิต SDLC
- Role-based access control สำหรับทีมงาน
- Tracking integration กับ Jira
- PM Dashboard แบบ real-time
- ISO27001 compliance documentation

---

## Quick Start / เริ่มต้นใช้งาน

### 1. ดู Project Status
เปิดไฟล์ [PROJECT_STATUS.md](PROJECT_STATUS.md) เพื่อดูสถานะโปรเจกต์ปัจจุบัน หรือเปิด [Dashboard](dashboard/index.html) สำหรับ visual view

### 2. สร้าง Feature ใหม่
```bash
./scripts/new-feature.sh F-001 "feature-name"
```

### 3. สร้าง Change Request
```bash
./scripts/new-cr.sh CR-001 "change-name" "F-001"
```

### 4. Validate Documents
```bash
./scripts/validate.sh
```

### 5. อัปเดต Dashboard
```bash
./scripts/update-status.sh
```

---

## Project Structure / โครงสร้างโปรเจกต์

```
PT_leasing_4/
├── README.md                    # ← คุณอยู่ที่นี่
├── PROJECT_STATUS.md            # Live project status
├── CHANGELOG.md                 # Version history
├── DECISION_LOG.md              # Key decisions log
├── GLOSSARY.md                  # Project glossary
│
├── config/                      # Project configuration
│   ├── project.yaml             # Project metadata
│   ├── roles.yaml               # Role definitions & permissions
│   ├── users.yaml               # Team members
│   ├── phases.yaml              # Discovery phases & SLA
│   ├── tracking.yaml            # Jira integration config
│   └── feature-versions.yaml   # Feature version registry
│
├── .github/                     # GitHub configuration
│   ├── CODEOWNERS               # Role-based code ownership
│   ├── pull_request_template.md # PR template
│   ├── ISSUE_TEMPLATE/          # Issue templates
│   └── workflows/               # GitHub Actions
│
├── templates/                   # Document templates
│   ├── _frontmatter.md          # Frontmatter reference
│   ├── BRD-new-feature.template.md
│   ├── BRD-change-request.template.md
│   ├── GAP_ANALYSIS.template.md
│   ├── IMPACT_ANALYSIS.template.md
│   ├── SRS.template.md
│   ├── ACCEPTANCE_CRITERIA.template.md
│   ├── ARCHITECTURE.template.md
│   ├── ADR.template.md
│   ├── TEST_CASE.template.md
│   └── USER_MANUAL_PAGE.template.md
│
├── docs/                        # All project documentation
│   ├── 00-discovery/            # Discovery phase documents
│   │   ├── 01-requirements/     # Requirements gathering
│   │   ├── 02-design/           # Design documents
│   │   ├── 03-validation/       # Design validation
│   │   ├── 04-breakdown/        # Story & task breakdown
│   │   └── 05-ready-for-develop/ # Dev readiness
│   ├── iso27001/                # ISO27001 compliance docs
│   └── user-manual/             # MkDocs user manual
│
├── dashboard/                   # PM Dashboard
│   ├── index.html               # Dashboard UI
│   ├── assets/                  # CSS & JS
│   └── data/                    # status.json
│
├── scripts/                     # Utility scripts
│   ├── new-feature.sh
│   ├── new-cr.sh
│   ├── new-doc.sh
│   ├── update-status.sh
│   ├── sync-tracking.sh
│   ├── validate.sh
│   ├── build-user-manual.sh
│   └── init-project.sh
│
└── versions/                    # ISO27001 audit snapshots
```

---

## Workflow / ขั้นตอนการทำงาน

### Discovery Phases (5 ขั้นตอน)

| Phase | ชื่อ | SLA |
|-------|------|-----|
| 1 | Requirement Gathering | 14 วัน |
| 2 | Make Design | 21 วัน |
| 3 | Validate Design | 7 วัน |
| 4 | Story & Task Breakdown | 7 วัน |
| 5 | Ready for Develop | 3 วัน |

---

## Team / ทีมงาน

| Role | Name | Email |
|------|------|-------|
| PM | Bovornsak Pan | bovornsak.pan@snocko-tech.com |
| BA | Orawan Nus | orawan.nus@snocko-tech.com |
| SA | Siriporn San | siriporn.san@snocko-tech.com |
| SA | Thamonwan San | thamonwan.san@snocko-tech.com |

---

## Links / ลิงก์สำคัญ

- **Jira Board**: https://snocko-main.atlassian.net/jira/software/projects/PTL/
- **Figma**: https://www.figma.com/files/project/587761135
- **Repository**: https://github.com/bovornsakpan-arch/ptl_leasing
- **User Manual**: https://bovornsakpan-arch.github.io/ptl_leasing/manual/
- **PM Dashboard**: [dashboard/index.html](dashboard/index.html)

---

## Document Status Definitions / ความหมายของ Status

| Status | คำอธิบาย |
|--------|-----------|
| `draft` | กำลังร่าง ยังไม่สมบูรณ์ |
| `in_review` | อยู่ระหว่างการ review |
| `approved` | ได้รับการอนุมัติแล้ว |
| `final` | เอกสารฉบับสมบูรณ์ |
| `superseded` | ถูกแทนที่ด้วยเอกสารใหม่ |
| `rejected` | ถูกปฏิเสธ |

---

*Last updated: 2026-05-15 | Version: 0.1.0*
