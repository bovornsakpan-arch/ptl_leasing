---
doc_id: "PTL-HANDOFF-001"
title: "Dev Handoff Document — PT Leasing"
project: ptl_leasing
type: handoff
version: "0.1.0"
status: draft
owner: bovornsak.pan@snocko-tech.com
phase: "05-ready"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Dev Handoff Document / เอกสาร Handoff ให้ Dev

> **Version**: 0.1.0 | **Status**: Draft
> เอกสารนี้เป็น single point of truth สำหรับทีม Dev ก่อนเริ่ม Sprint 1

---

## Project Overview / ภาพรวมโปรเจกต์

| Field | Value |
|-------|-------|
| Project | PT Leasing Backoffice |
| Code | PTL |
| Repository | https://github.com/bovornsakpan-arch/ptl_leasing |
| Jira | https://snocko-main.atlassian.net/jira/software/projects/PTL/ |
| PM | Bovornsak Pan — bovornsak.pan@snocko-tech.com |
| BA | Orawan Nus — orawan.nus@snocko-tech.com |
| SA | Siriporn San / Thamonwan San |

---

## Key Documents / เอกสารสำคัญ

| Document | Location | Description |
|----------|----------|-------------|
| Architecture | docs/00-discovery/02-design/architecture/ARCHITECTURE.md | System architecture |
| Tech Stack | docs/00-discovery/02-design/architecture/TECH_STACK.md | Technologies |
| API Spec | docs/00-discovery/02-design/system/API_SPEC.md | API endpoints |
| Data Structure | docs/00-discovery/02-design/architecture/DATA_STRUCTURE.md | DB schema |
| System Design | docs/00-discovery/02-design/system/SYSTEM_DESIGN.md | Module design |
| Security Design | docs/00-discovery/02-design/security/SECURITY_DESIGN.md | Security requirements |
| Stories | docs/00-discovery/04-breakdown/STORIES.md | User stories |
| Figma | https://www.figma.com/files/project/587761135 | UI designs |

---

## Development Setup / การตั้งค่าสภาพแวดล้อม

*(กรอกหลังจาก tech stack finalised)*

```bash
# Clone repository
git clone https://github.com/bovornsakpan-arch/ptl_leasing.git
cd ptl_leasing

# Install dependencies
npm install

# Copy environment variables
cp .env.example .env
# Edit .env with your local values

# Start development
docker-compose up -d  # Start DB, Redis
npm run dev           # Start API
cd frontend && npm run dev  # Start Frontend
```

---

## Git Workflow / Git Workflow

```
main        — Production branch
develop     — Integration branch
feature/*   — Feature branches (branch from develop)
hotfix/*    — Emergency fixes (branch from main)
```

**Branch naming**: `feature/S-001-login`, `bugfix/PTL-123-fix-auth`
**Commit format**: `feat(auth): add login endpoint` (Conventional Commits)
**PR**: ต้องผ่าน CI และ code review จาก 1 person ก่อน merge

---

## Sprint 1 Stories / Stories Sprint แรก

*(กรอกหลัง sprint planning)*

| Story | Title | Points | Assignee |
|-------|-------|--------|---------|
| S-001 | | | |
| S-002 | | | |

---

## Definition of Done / เกณฑ์การ Done

Story ถือว่า Done เมื่อ:
- [ ] Code implemented
- [ ] Unit tests passed (coverage ≥ 80%)
- [ ] Code reviewed by 1 peer
- [ ] Integration tests passed
- [ ] Deployed to staging
- [ ] QA tested on staging
- [ ] Acceptance criteria verified
- [ ] Jira issue moved to Done

---

## Questions & Contacts / ถ้ามีคำถาม

| เรื่อง | ติดต่อ |
|-------|-------|
| Business requirements | BA: orawan.nus@snocko-tech.com |
| System/API design | SA: siriporn.san@snocko-tech.com |
| Architecture decisions | SA: thamonwan.san@snocko-tech.com |
| Project/timeline | PM: bovornsak.pan@snocko-tech.com |
| UI/UX | UXUI Designer (TBD) |

---

## Known Issues / ปัญหาที่รู้อยู่แล้ว

*(กรอกก่อน handoff session)*

---

## Sign-off / การอนุมัติ

| Role | Name | Status | Date |
|------|------|--------|------|
| BA | Orawan Nus | Pending | |
| SA | Siriporn San | Pending | |
| PM | Bovornsak Pan | Pending | |
| Dev Lead | TBD | Pending | |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: bovornsak.pan@snocko-tech.com*
