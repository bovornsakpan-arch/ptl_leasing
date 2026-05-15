---
doc_id: "PTL-TRACE-001"
title: "Traceability Matrix — PT Leasing"
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

# Traceability Matrix / เมทริกซ์การติดตาม

> **Version**: 1.0.0 | **Status**: Final | **Feature**: F-001 Customer Registration
> เชื่อมโยง: Requirements → Design doc → Story → Test Case → Code (placeholder)

---

## Overview / ภาพรวม

Traceability matrix ช่วยให้มั่นใจว่าทุก requirement มี:
- Design ที่รองรับ
- Story/Task ที่ implement
- Test case ที่ verify
- Code ที่ตรงกัน (กรอกเมื่อ development เสร็จ)

---

## F-001 Full Traceability Table

| Req ID | Requirement | BRD Ref | Design Doc | Story ID | Test Case ID | Code (placeholder) | Status |
|--------|------------|---------|-----------|---------|------------|-------------------|--------|
| FR-001 | ลงทะเบียนลูกค้าบุคคลธรรมดา (Individual) | BRD §4 In Scope | SYSTEM_DESIGN §DB Schema; API_SPEC POST /customers | US-F001-001 | TC-F001-001 | `src/modules/customers/customers.service.ts#createIndividual` | Sprint 1 |
| FR-002 | ลงทะเบียนลูกค้านิติบุคคล (Juristic) | BRD §4 In Scope | SYSTEM_DESIGN §DB Schema; API_SPEC POST /customers | US-F001-002 | TC-F001-002 | `src/modules/customers/customers.service.ts#createJuristic` | Sprint 1 |
| FR-003 | ตรวจสอบเลขบัตร/เลขทะเบียนไม่ซ้ำ | BRD BR-001 | SYSTEM_DESIGN §Error Codes DUPLICATE_ID_CARD; API_SPEC GET /check-duplicate | US-F001-001, US-F001-002 | TC-F001-003 | `src/modules/customers/customers.service.ts#checkDuplicate` | Sprint 1 |
| FR-004 | อัปโหลดเอกสาร PDF/JPG/PNG ≤ 10MB | BRD §4, BR-002, BR-007 | SYSTEM_DESIGN §DB Schema customer_documents; API_SPEC POST /documents | US-F001-003 | TC-F001-004 | `src/modules/documents/documents.service.ts#upload` | Sprint 1 |
| FR-005 | Real-time validation error | BRD §3 | SYSTEM_DESIGN §Error Handling; API_SPEC Error Responses | US-F001-001, US-F001-002 | TC-F001-005 | `src/modules/customers/customers.validator.ts` | Sprint 1 |
| FR-006 | Audit log ทุก action | BRD BR-006 | SYSTEM_DESIGN §DB Schema audit_logs; DATA_CLASSIFICATION | US-F001-001, US-F001-002, US-F001-003 | TC-F001-007 | `src/modules/audit/audit.service.ts#logAction` | Sprint 1 |
| FR-007 | Email notification เมื่อ submit สำเร็จ | BRD §3 | SYSTEM_DESIGN §Component Diagram NotificationService | US-F001-001, US-F001-002 | TC-F001-001 (step 12) | `src/modules/notifications/notification.service.ts` | Sprint 1 |
| FR-008 | ค้นหาลูกค้าด้วยชื่อ/เลขบัตร/เบอร์โทร | BRD §3 | API_SPEC GET /customers query params | US-F001-004 | TC-F001-006 | `src/modules/customers/customers.controller.ts#search` | Sprint 2 |
| FR-009 | ตรวจสอบอายุ ≥ 20 ปี | BRD BR-005 | SYSTEM_DESIGN §Error Codes AGE_BELOW_MINIMUM | US-F001-001 | TC-F001-005 (age step) | `src/modules/customers/customers.service.ts#validateAge` | Sprint 1 |
| FR-010 | Approval Workflow | BRD BR-004 | SYSTEM_DESIGN §Data Flow; API_SPEC POST /approve, /reject | US-F001-005 | TC-F001-001 (approval) | `src/modules/customers/customers.service.ts#approve` | Sprint 2 |
| FR-011 | แสดงรายการ KYC ที่จำเป็นตาม customer type | BRD BR-002 | SYSTEM_DESIGN §Module customers | US-F001-001, US-F001-002 | TC-F001-001 (step 8-9) | `src/modules/customers/kyc-requirements.config.ts` | Sprint 1 |

---

## Non-Functional Requirements Traceability

| Req ID | Requirement | SRS Ref | Design Doc | Test Approach | Status |
|--------|------------|---------|-----------|--------------|--------|
| NFR-001 | Response time < 2s (p95) | SRS §3.1 | SYSTEM_DESIGN §Caching | Load test — Locust/k6 Sprint 2 | Planned |
| NFR-002 | Authentication required | SRS §3.2 | SYSTEM_DESIGN §Auth Flow | Integration test — all endpoints | Sprint 1 |
| NFR-003 | HTTPS enforced | SRS §3.2 | SYSTEM_DESIGN §API Standards | Security scan Sprint 2 | Planned |
| NFR-004 | AES-256 encryption for sensitive data | SRS §3.2 | DATA_CLASSIFICATION §C4 | Security review Sprint 1 | Planned |
| NFR-005 | PDPA compliance | SRS §3.3 | DATA_CLASSIFICATION | Privacy review + audit log test TC-F001-007 | Sprint 1 |
| NFR-006 | Uptime 99.5% | SRS §3.4 | SYSTEM_DESIGN | Monitoring setup — post Sprint 2 | Future |
| NFR-007 | 50 concurrent users | SRS §3.1 | SYSTEM_DESIGN §Caching | Load test Sprint 2 | Planned |

---

## Business Rules Traceability

| Rule ID | Business Rule | BRD Ref | FR Linked | Story | Test Case |
|---------|-------------|---------|----------|-------|----------|
| BR-001 | เลขบัตร 13 หลัก unique | BRD §6 | FR-003 | US-F001-001, 002 | TC-F001-003 |
| BR-002 | KYC ต้องครบก่อน submit | BRD §6 | FR-004, FR-011 | US-F001-001, 002, 003 | TC-F001-004 |
| BR-003 | ข้อมูลลูกค้า = Confidential | BRD §6 | FR-006 | US-F001-001, 002 | TC-F001-007 |
| BR-004 | ต้อง Supervisor approve | BRD §6 | FR-010 | US-F001-005 | TC-F001-001 (approval) |
| BR-005 | อายุ ≥ 20 ปี | BRD §6 | FR-009 | US-F001-001 | TC-F001-005 |
| BR-006 | Audit log ทุก action | BRD §6 | FR-006 | US-F001-001, 002, 003 | TC-F001-007 |
| BR-007 | ไฟล์ ≤ 10 MB | BRD §6 | FR-004 | US-F001-003 | TC-F001-004 |

---

## Coverage Summary / สรุป Coverage

| Category | Total | Traced | Coverage % |
|----------|-------|--------|-----------|
| Functional Requirements | 11 | 11 | **100%** ✅ |
| Non-Functional Requirements | 7 | 7 | **100%** ✅ |
| Business Rules | 7 | 7 | **100%** ✅ |
| User Stories | 5 | 5 | **100%** ✅ |
| Test Cases | 7 | 7 | **100%** ✅ |

---

## Orphan Items / รายการที่ไม่มี trace

### Requirements without Stories
*ไม่มี — ทุก requirement มี story รองรับ* ✅

### Stories without Test Cases
*ไม่มี — ทุก story มี test case รองรับ* ✅

### Test Cases without Requirements
*ไม่มี — ทุก test case trace กลับไปยัง requirement และ AC* ✅

---

*Document ID: PTL-TRACE-001 | Version: 1.0.0 | อัปเดตล่าสุด: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
