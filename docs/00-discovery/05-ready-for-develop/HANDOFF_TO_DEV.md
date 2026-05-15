---
doc_id: "PTL-HANDOFF-001"
title: "Dev Handoff Document — F-001 Customer Registration"
project: ptl_leasing
type: handoff
version: "1.0.0"
status: final
owner: bovornsak.pan@snocko-tech.com
phase: "05-ready"
feature_id: "F-001"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "siriporn.san@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_date: "2026-05-15"
---

# Dev Handoff Document — F-001 Customer Registration
# เอกสาร Handoff ให้ Dev

> **Version**: 1.0.0 | **Status**: Final | **Feature**: F-001 Customer Registration
> **Discovery Completion Date**: 2026-05-15

---

## Project Overview / ภาพรวมโปรเจกต์

| Field | Value |
|-------|-------|
| Project | PT Leasing Backoffice |
| Code | PTL |
| Feature | F-001 Customer Registration |
| Repository | https://github.com/bovornsakpan-arch/ptl_leasing |
| Jira | https://snocko-main.atlassian.net/jira/software/projects/PTL/ |
| PM | Bovornsak Pan — bovornsak.pan@snocko-tech.com |
| BA | Orawan Nus — orawan.nus@snocko-tech.com |
| SA | Siriporn San — siriporn.san@snocko-tech.com |
| SA | Thamonwan San — thamonwan.san@snocko-tech.com |

---

## What to Build / สิ่งที่ต้องสร้าง

### F-001 Summary
ระบบลงทะเบียนลูกค้าใหม่สำหรับ backoffice leasing ให้ staff ฝ่ายสินเชื่อใช้แทนการกรอก Excel

**5 User Stories**:

| Story | Description | Sprint | Points |
|-------|-------------|--------|--------|
| US-F001-001 | ลงทะเบียนลูกค้าบุคคลธรรมดา | Sprint 1 | 5 |
| US-F001-002 | ลงทะเบียนลูกค้านิติบุคคล | Sprint 1 | 5 |
| US-F001-003 | อัปโหลดเอกสาร KYC | Sprint 1 | 3 |
| US-F001-004 | ค้นหาลูกค้าด้วยชื่อ/เลขบัตร/เบอร์โทร | Sprint 2 | 2 |
| US-F001-005 | Supervisor review และ approve/reject registration | Sprint 2 | 5 |

**Total**: 20 story points | 2 sprints (4 สัปดาห์)

---

## Key Documents / เอกสารสำคัญ

| Document | Location | Description | Version |
|----------|----------|-------------|---------|
| BRD | docs/00-discovery/01-requirements/new-features/F-001-customer-registration/BRD.md | Business requirements | 1.0.0 |
| SRS | docs/00-discovery/01-requirements/new-features/F-001-customer-registration/SRS.md | Software requirements (FR + NFR) | 1.0.0 |
| Acceptance Criteria | docs/00-discovery/01-requirements/new-features/F-001-customer-registration/ACCEPTANCE_CRITERIA.md | Gherkin AC สำหรับ UAT | 1.0.0 |
| System Design | docs/00-discovery/02-design/system/SYSTEM_DESIGN.md | Component, DB schema, data flow | 1.0.0 |
| **API Spec** | docs/00-discovery/02-design/system/API_SPEC.md | **API contracts — อ่านก่อนเริ่มเขียนโค้ด** | 1.0.0 |
| Business Flow | docs/00-discovery/02-design/business/BUSINESS_FLOW.md | Business process diagram | 1.0.0 |
| Data Classification | docs/00-discovery/02-design/security/DATA_CLASSIFICATION.md | PDPA + security requirements | 1.0.0 |
| Test Cases | docs/00-discovery/02-design/testing/TEST_CASES.md | 7 test cases สำหรับ F-001 | 1.0.0 |
| Stories | docs/00-discovery/04-breakdown/STORIES.md | User stories detail | 1.0.0 |
| Tasks | docs/00-discovery/04-breakdown/TASKS.md | Task breakdown | 1.0.0 |
| Traceability | docs/00-discovery/04-breakdown/TRACEABILITY_MATRIX.md | REQ → Design → Story → Test | 1.0.0 |
| Figma | https://www.figma.com/files/project/587761135 | UI designs |  |

---

## Architecture Decisions / การตัดสินใจด้าน Architecture

### Technology Stack
- **Frontend**: React + TypeScript + Vite + Tailwind CSS
- **Backend**: Node.js + Express + TypeScript
- **Database**: PostgreSQL (ต้องการ version ≥ 14 สำหรับ gen_random_uuid())
- **File Storage**: S3/MinIO (private bucket, server-side encryption)
- **Cache**: Redis (sessions, permissions)
- **Auth**: JWT (access token 15 min, refresh token 7 days)

### Key Design Decisions

| Decision | Choice | Reason |
|----------|--------|--------|
| ID generation | UUID v4 (gen_random_uuid()) | Prevent enumeration attacks |
| Soft delete | ใช้ `deleted_at` field | PDPA audit trail |
| File access | Pre-signed URL (15 min) | Secure, no direct S3 exposure |
| Sensitive data | AES-256 encryption at rest | PDPA C4 requirement |
| Duplicate check | onBlur + server-side | UX + race condition protection |
| Pagination | cursor-based ready (ใช้ offset ก่อน) | Future scalability |

---

## API Contracts / สัญญา API

**อ่าน API_SPEC.md ก่อนเสมอ** — link: `docs/00-discovery/02-design/system/API_SPEC.md`

### F-001 Endpoints Summary

| Method | Endpoint | Story |
|--------|----------|-------|
| `POST` | `/api/v1/customers` | US-F001-001, US-F001-002 |
| `GET` | `/api/v1/customers` | US-F001-004 |
| `GET` | `/api/v1/customers/:id` | US-F001-001, US-F001-002 |
| `GET` | `/api/v1/customers/check-duplicate` | US-F001-001, US-F001-002 |
| `POST` | `/api/v1/customers/:id/documents` | US-F001-003 |
| `GET` | `/api/v1/customers/:id/documents` | US-F001-003 |
| `POST` | `/api/v1/customers/:id/approve` | US-F001-005 |
| `POST` | `/api/v1/customers/:id/reject` | US-F001-005 |

---

## Security Requirements / ข้อกำหนดด้าน Security

**อ่าน DATA_CLASSIFICATION.md สำหรับรายละเอียดครบถ้วน**

### Critical Security Requirements

1. **Encrypt C4 fields at rest** — เลขบัตรประชาชน, เบอร์โทร, เลขบัตรผู้มีอำนาจ ต้องเข้ารหัส AES-256 ใน DB
2. **Mask ใน display** — เลขบัตรแสดงเป็น `110010012****`, เบอร์โทรเป็น `0812***678`
3. **Mask ใน logs** — ห้าม log ข้อมูล PII plaintext ใน any log
4. **KYC documents** — เก็บใน private S3 bucket, access ผ่าน pre-signed URL เท่านั้น (expire 15 min)
5. **Audit log** — บันทึกทุก action (ดู SYSTEM_DESIGN.md สำหรับ schema)
6. **RBAC** — เช็ค role ทุก endpoint:
   - OFFICER: สร้าง, แก้ไข, ดูข้อมูล, upload documents
   - MANAGER: approve, reject + ทุก OFFICER permissions
7. **PDPA** — แสดง Privacy Notice ก่อน submit form

---

## Test Cases to Implement / Test Cases ที่ต้อง Implement

**อ่าน TEST_CASES.md สำหรับรายละเอียดครบถ้วน**

| TC ID | Priority | Type | Sprint |
|-------|---------|------|--------|
| TC-F001-001 | Critical | Happy Path — Individual | Sprint 1 |
| TC-F001-002 | Critical | Happy Path — Juristic | Sprint 1 |
| TC-F001-003 | Critical | Duplicate check | Sprint 1 |
| TC-F001-004 | High | File validation | Sprint 1 |
| TC-F001-005 | High | Form validation | Sprint 1 |
| TC-F001-006 | High | Customer search | Sprint 2 |
| TC-F001-007 | High | Audit log | Sprint 1 |

---

## Development Setup / การตั้งค่าสภาพแวดล้อม

```bash
# Clone repository
git clone https://github.com/bovornsakpan-arch/ptl_leasing.git
cd ptl_leasing

# Install dependencies
npm install

# Copy environment variables
cp .env.example .env
# Edit .env with your local values:
# DATABASE_URL=postgresql://postgres:password@localhost:5432/ptleasing
# REDIS_URL=redis://localhost:6379
# S3_ENDPOINT=http://localhost:9000
# S3_BUCKET=ptl-kyc-documents
# SMTP_HOST=localhost
# SMTP_PORT=1025
# JWT_SECRET=your-secret-key

# Start infrastructure
docker-compose up -d  # Start PostgreSQL, Redis, MinIO

# Run database migrations
npm run db:migrate

# Start development server
npm run dev           # Start API (port 3000)
cd frontend && npm run dev  # Start Frontend (port 5173)
```

---

## Git Workflow / Git Workflow

```
main        — Production branch
develop     — Integration branch
feature/*   — Feature branches (branch from develop)
hotfix/*    — Emergency fixes (branch from main)
```

**Branch naming สำหรับ F-001**:
- `feature/F001-001-individual-registration`
- `feature/F001-002-juristic-registration`
- `feature/F001-003-kyc-upload`
- `feature/F001-004-customer-search`
- `feature/F001-005-supervisor-approval`

**Commit format**: `feat(customers): add individual registration endpoint` (Conventional Commits)

**PR**: ต้องผ่าน CI (lint + tests) และ code review จาก 1 person ก่อน merge to develop

---

## Sprint 1 Stories / Stories Sprint 1

| Story | Title | Points | Jira |
|-------|-------|--------|------|
| US-F001-001 | ลงทะเบียนลูกค้าบุคคลธรรมดา | 5 | PTL-101 |
| US-F001-002 | ลงทะเบียนลูกค้านิติบุคคล | 5 | PTL-102 |
| US-F001-003 | อัปโหลดเอกสาร KYC | 3 | PTL-103 |
| **Sprint 1 Total** | | **13 pts** | |

---

## Definition of Done (DEV) / เกณฑ์ Done

Story ถือว่า Done เมื่อ:
- [ ] Unit tests pass (coverage ≥ 80%)
- [ ] Integration tests pass
- [ ] API matches spec ใน API_SPEC.md
- [ ] PDPA requirements met — sensitive data encrypted, audit log บันทึกครบ
- [ ] Code review approved by 1 peer
- [ ] No lint errors
- [ ] Deployed to staging
- [ ] BA UAT sign-off (orawan.nus@snocko-tech.com)
- [ ] Jira issue moved to Done

---

## Known Constraints / ข้อจำกัดที่รู้

1. **F-AUTH dependency**: Authentication module ต้องพร้อมก่อน Sprint 1 เริ่ม — coordinate กับ SA
2. **S3/MinIO**: DevOps ต้อง setup และ configure bucket ก่อน US-F001-003 เริ่ม
3. **SMTP**: DevOps ต้อง configure SMTP ก่อน email notification ทำงานได้
4. **Encryption key management**: ต้องใช้ environment variable — ห้าม hardcode ใน code

---

## Questions & Contacts / ถ้ามีคำถาม

| เรื่อง | ติดต่อ |
|-------|-------|
| Business requirements / AC clarification | BA: orawan.nus@snocko-tech.com |
| System/API design clarification | SA: siriporn.san@snocko-tech.com |
| Architecture decisions | SA: thamonwan.san@snocko-tech.com |
| Project/timeline | PM: bovornsak.pan@snocko-tech.com |
| UI/UX questions | UX Designer (TBD) |
| Infrastructure/DevOps | DevOps (TBD) |

---

## Sign-off / การอนุมัติ

| Role | Name | Status | Date |
|------|------|--------|------|
| BA | Orawan Nus | ✅ Approved | 2026-05-15 |
| SA | Siriporn San | ✅ Approved | 2026-05-15 |
| PM | Bovornsak Pan | ✅ Approved | 2026-05-15 |
| Dev Lead | TBD | Pending | — |

---

*Document ID: PTL-HANDOFF-001 | Version: 1.0.0 | อัปเดตล่าสุด: 2026-05-15 | Owner: bovornsak.pan@snocko-tech.com*
