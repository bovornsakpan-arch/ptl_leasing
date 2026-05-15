---
doc_id: "PTL-TASKS-001"
title: "Task Breakdown — PT Leasing"
project: ptl_leasing
type: requirements
version: "1.0.0"
status: final
owner: orawan.nus@snocko-tech.com
phase: "04-breakdown"
feature_id: "F-001"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "siriporn.san@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_date: "2026-05-15"
---

# Task Breakdown / การแบ่ง Tasks

> **Version**: 1.0.0 | **Status**: Final | **Feature**: F-001 Customer Registration

---

## Overview / ภาพรวม

เอกสารนี้แบ่ง User Stories ออกเป็น technical tasks สำหรับ Dev team
แต่ละ task มีขนาด ≤ 1 day (≤ 8 hours) เพื่อให้ track ได้ง่าย

---

## US-F001-001: ลงทะเบียนลูกค้าบุคคลธรรมดา (5 Points, Sprint 1)

| Task ID | Description | Type | Est. (hrs) | Assigned | Status |
|---------|-------------|------|-----------|---------|--------|
| T-F001-001 | สร้าง `customers` table migration script — Individual fields, indexes | Database | 3 | TBD | Not Started |
| T-F001-002 | สร้าง `customer_documents` table migration | Database | 2 | TBD | Not Started |
| T-F001-003 | สร้าง `audit_logs` table migration | Database | 2 | TBD | Not Started |
| T-F001-004 | Implement CustomerRepository — insert/findById/findByIdCard | Backend | 4 | TBD | Not Started |
| T-F001-005 | Implement CustomerService — createIndividual, validateAge, validateDuplicateIdCard | Backend | 5 | TBD | Not Started |
| T-F001-006 | Implement AuditService — logAction (async, non-blocking) | Backend | 3 | TBD | Not Started |
| T-F001-007 | Implement POST /api/v1/customers endpoint + Zod validation schema | Backend | 4 | TBD | Not Started |
| T-F001-008 | Implement GET /api/v1/customers/check-duplicate endpoint | Backend | 2 | TBD | Not Started |
| T-F001-009 | สร้าง Individual Customer Registration Form component (React) | Frontend | 5 | TBD | Not Started |
| T-F001-010 | Implement real-time field validation (ID card format, email, age) | Frontend | 3 | TBD | Not Started |
| T-F001-011 | Implement duplicate check onBlur ของ field เลขบัตร | Frontend | 2 | TBD | Not Started |
| T-F001-012 | Implement Submit flow + Confirmation dialog + Success screen | Frontend | 3 | TBD | Not Started |
| T-F001-013 | Write unit tests สำหรับ CustomerService (validation, duplicate check) | Test | 3 | TBD | Not Started |
| T-F001-014 | Write integration tests สำหรับ POST /api/v1/customers | Test | 3 | TBD | Not Started |

**Total Estimate**: ~44 hours | **Story Points**: 5

---

## US-F001-002: ลงทะเบียนลูกค้านิติบุคคล (5 Points, Sprint 1)

| Task ID | Description | Type | Est. (hrs) | Assigned | Status |
|---------|-------------|------|-----------|---------|--------|
| T-F001-015 | อัปเดต customers table migration เพิ่ม Juristic fields | Database | 2 | TBD | Not Started |
| T-F001-016 | Implement CustomerService — createJuristic, validateJuristicNo | Backend | 4 | TBD | Not Started |
| T-F001-017 | อัปเดต POST /api/v1/customers รองรับ customer_type=JURISTIC | Backend | 3 | TBD | Not Started |
| T-F001-018 | Implement GET /api/v1/customers/check-duplicate รองรับ juristic_no | Backend | 1 | TBD | Not Started |
| T-F001-019 | สร้าง Juristic Customer Registration Form component (React) | Frontend | 5 | TBD | Not Started |
| T-F001-020 | Implement customer type selector — dynamic form switching | Frontend | 3 | TBD | Not Started |
| T-F001-021 | Implement KYC document checklist ตาม customer type | Frontend | 2 | TBD | Not Started |
| T-F001-022 | Write unit tests สำหรับ Juristic validation | Test | 2 | TBD | Not Started |
| T-F001-023 | Write integration tests สำหรับ Juristic registration | Test | 2 | TBD | Not Started |

**Total Estimate**: ~24 hours | **Story Points**: 5

---

## US-F001-003: อัปโหลดเอกสาร KYC (3 Points, Sprint 1)

| Task ID | Description | Type | Est. (hrs) | Assigned | Status |
|---------|-------------|------|-----------|---------|--------|
| T-F001-024 | Setup S3/MinIO client connection + environment config | Backend/Infra | 3 | TBD | Not Started |
| T-F001-025 | Implement DocumentService — uploadToS3, validateFileSize, validateMimeType | Backend | 4 | TBD | Not Started |
| T-F001-026 | Implement POST /api/v1/customers/:id/documents endpoint | Backend | 3 | TBD | Not Started |
| T-F001-027 | Implement GET /api/v1/customers/:id/documents endpoint | Backend | 2 | TBD | Not Started |
| T-F001-028 | Implement GET document pre-signed URL endpoint (15 min expiry) | Backend | 2 | TBD | Not Started |
| T-F001-029 | สร้าง DocumentUpload component — drag & drop, progress bar | Frontend | 5 | TBD | Not Started |
| T-F001-030 | Implement client-side file validation (size, type) ก่อน upload | Frontend | 2 | TBD | Not Started |
| T-F001-031 | แสดง uploaded documents list + preview/download | Frontend | 3 | TBD | Not Started |
| T-F001-032 | Write unit tests สำหรับ DocumentService | Test | 3 | TBD | Not Started |
| T-F001-033 | Write integration tests สำหรับ file upload endpoint | Test | 2 | TBD | Not Started |

**Total Estimate**: ~29 hours | **Story Points**: 3

---

## US-F001-004: ค้นหาลูกค้า (2 Points, Sprint 2)

| Task ID | Description | Type | Est. (hrs) | Assigned | Status |
|---------|-------------|------|-----------|---------|--------|
| T-F001-034 | Implement GET /api/v1/customers endpoint — query params, pagination | Backend | 4 | TBD | Not Started |
| T-F001-035 | Implement full-text search ด้วย PostgreSQL (name partial match) | Backend | 3 | TBD | Not Started |
| T-F001-036 | สร้าง CustomerSearch component — search bar, results table, pagination | Frontend | 4 | TBD | Not Started |
| T-F001-037 | Implement debounced search (300ms delay) | Frontend | 2 | TBD | Not Started |
| T-F001-038 | Write tests สำหรับ search functionality | Test | 3 | TBD | Not Started |

**Total Estimate**: ~16 hours | **Story Points**: 2

---

## US-F001-005: Supervisor Review และ Approve/Reject (5 Points, Sprint 2)

| Task ID | Description | Type | Est. (hrs) | Assigned | Status |
|---------|-------------|------|-----------|---------|--------|
| T-F001-039 | สร้าง `customer_approval_history` table migration | Database | 2 | TBD | Not Started |
| T-F001-040 | Implement POST /api/v1/customers/:id/approve endpoint | Backend | 3 | TBD | Not Started |
| T-F001-041 | Implement POST /api/v1/customers/:id/reject endpoint | Backend | 3 | TBD | Not Started |
| T-F001-042 | Implement NotificationService — sendApprovalNotification (email) | Backend | 4 | TBD | Not Started |
| T-F001-043 | สร้าง email template สำหรับ approve/reject notification | Backend | 2 | TBD | Not Started |
| T-F001-044 | สร้าง Pending Registrations list view สำหรับ Supervisor | Frontend | 4 | TBD | Not Started |
| T-F001-045 | สร้าง Registration Review modal — ดูข้อมูล + เอกสาร + Approve/Reject buttons | Frontend | 5 | TBD | Not Started |
| T-F001-046 | Implement RBAC guard สำหรับ approve/reject (MANAGER role only) | Frontend/Backend | 2 | TBD | Not Started |
| T-F001-047 | Write integration tests สำหรับ approval workflow | Test | 4 | TBD | Not Started |

**Total Estimate**: ~29 hours | **Story Points**: 5

---

## Sprint Allocation / การจัดสรรใส่ Sprint

| Sprint | Stories | Story Points | Est. Hours | Focus |
|--------|---------|-------------|-----------|-------|
| Sprint 1 (2 สัปดาห์) | US-F001-001, 002, 003 | 13 pts | ~97 hrs | Customer form + KYC upload |
| Sprint 2 (2 สัปดาห์) | US-F001-004, 005 | 7 pts | ~45 hrs | Search + Approval workflow |

---

## Team Capacity / ความสามารถของทีม

| Member | Role | Capacity (pts/sprint) | Notes |
|--------|------|---------------------|-------|
| TBD | Frontend Dev | TBD | — |
| TBD | Backend Dev | TBD | — |
| TBD | QA | TBD | — |

*จะกรอกหลัง Sprint Planning session*

---

## Dependencies / การพึ่งพา

| Task | Depends On | Notes |
|------|-----------|-------|
| T-F001-001 ถึง T-F001-014 | F-AUTH module (Login, JWT) | Auth ต้องพร้อมก่อน Sprint 1 |
| T-F001-024 ถึง T-F001-033 | S3/MinIO infrastructure | DevOps ต้อง setup ก่อน Sprint 1 |
| T-F001-042 ถึง T-F001-043 | SMTP configuration | DevOps ต้อง setup ก่อน Sprint 2 |

---

*Document ID: PTL-TASKS-001 | Version: 1.0.0 | อัปเดตล่าสุด: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
