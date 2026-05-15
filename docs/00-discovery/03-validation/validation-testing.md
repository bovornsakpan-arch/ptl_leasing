---
doc_id: "PTL-VAL-TESTING"
title: "Validation: Testing Design"
project: ptl_leasing
type: validation
version: "1.0.0"
status: approved
owner: siriporn.san@snocko-tech.com
phase: "03-validation"
feature_id: "F-001"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "siriporn.san@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_date: "2026-05-15"
---

# Validation: Testing Design
# การตรวจสอบ Testing Design

> **Version**: 1.0.0 | **Status**: Approved | **Feature**: F-001 Customer Registration

---

## Session Information / ข้อมูล Session

| Field | Value |
|-------|-------|
| Session Date | 2026-05-15 |
| Session Time | 15:00–16:30 น. |
| Facilitator | Siriporn San (SA) |
| Duration | 1.5 ชั่วโมง |
| Location | Microsoft Teams |

---

## Participants / ผู้เข้าร่วม

| Role | Name | Email | Sign-off |
|------|------|-------|---------|
| PM | Bovornsak Pan | bovornsak.pan@snocko-tech.com | ✅ Signed |
| SA | Siriporn San | siriporn.san@snocko-tech.com | ✅ Signed |
| SA | Thamonwan San | thamonwan.san@snocko-tech.com | ✅ Signed |
| BA | Orawan Nus | orawan.nus@snocko-tech.com | ✅ Signed |

---

## Documents Reviewed / เอกสารที่ Review

| Document | Version | Path | Status |
|----------|---------|------|--------|
| Test Cases Master List | 1.0.0 | docs/00-discovery/02-design/testing/TEST_CASES.md | ✅ Reviewed |
| Acceptance Criteria | 1.0.0 | docs/00-discovery/01-requirements/new-features/F-001-customer-registration/ACCEPTANCE_CRITERIA.md | ✅ Reviewed |
| SRS (NFR section) | 1.0.0 | docs/00-discovery/01-requirements/new-features/F-001-customer-registration/SRS.md | ✅ Reviewed |

---

## Test Cases Reviewed / Test Cases ที่ Review

| TC ID | Description | Type | Coverage | Status |
|-------|-------------|------|---------|--------|
| TC-F001-001 | ลงทะเบียนบุคคลธรรมดาสำเร็จ | Happy Path | AC-F001-001 ✅ | Approved |
| TC-F001-002 | ลงทะเบียนนิติบุคคลสำเร็จ | Happy Path | AC-F001-002 ✅ | Approved |
| TC-F001-003 | เลขบัตรซ้ำ → error | Error Case | AC-F001-003 ✅ | Approved |
| TC-F001-004 | ไฟล์เกิน 10MB → error | Error Case | AC-F001-004 ✅ | Approved |
| TC-F001-005 | Validation error | Validation | AC-F001-005 ✅ | Approved |
| TC-F001-006 | ค้นหาลูกค้า | Happy Path | AC-F001-006 ✅ | Approved |
| TC-F001-007 | Audit log ครบ | Compliance | AC-F001-001 (audit) ✅ | Approved |

**Total test cases reviewed**: 7
**Coverage**: Happy Path ✅ | Error Cases ✅ | Validation ✅ | Compliance ✅ | Edge Cases ✅

---

## Checklist / รายการตรวจสอบ

- [x] Test cases ครอบคลุม happy path ทั้งหมด (Individual + Juristic)
- [x] Test cases ครอบคลุม error cases จาก AC ทั้งหมด
- [x] Test cases ครอบคลุม validation scenarios
- [x] Test cases ครอบคลุม compliance requirements (PDPA audit log)
- [x] Test cases ครอบคลุม edge cases (file size, file type, age boundary)
- [x] แต่ละ test case มี preconditions ชัดเจน
- [x] แต่ละ test case มี expected results ชัดเจน
- [x] Traceability ครบ: TC → AC → FR (สามารถ trace ได้ทุก test case)
- [x] ไม่มี AC ที่ไม่มี test case รองรับ
- [x] No blocking issues outstanding
- [x] Sign-offs obtained

---

## Discussion Points / ประเด็นที่หารือ

### 1. Performance Test Cases
**ประเด็น**: SRS มี NFR เรื่อง performance (< 2s) — ต้องมี test case หรือไม่?

**Decision**: เพิ่ม performance test เป็น non-functional test ใน Sprint 2 (หลัง feature พัฒนาเสร็จ) — ไม่ block Sprint 1 แต่ต้องอยู่ใน Definition of Done

**Owner**: SA | **Status**: Noted — จะเพิ่มใน Sprint 2 planning

---

### 2. Supervisor Approval Test Cases
**ประเด็น**: ยังไม่มี test case สำหรับ Supervisor approve/reject flow

**Decision**: เพิ่ม TC-F001-008 (Supervisor approve) และ TC-F001-009 (Supervisor reject) ใน Sprint 2 เนื่องจาก US-F001-005 อยู่ใน Sprint 2

**Owner**: Orawan Nus | **Status**: Noted — จะเพิ่มก่อนเริ่ม Sprint 2

---

### 3. Concurrent Users Edge Case
**ประเด็น**: ถ้า 2 Staff กรอกเลขบัตรเดียวกันพร้อมกัน — race condition?

**Decision**: Server-side unique constraint ใน DB จะ handle ได้ — เพิ่ม test case TC-F001-010 (concurrent duplicate submission) ใน test suite แต่ implement ใน integration test

**Owner**: Thamonwan San | **Status**: Noted — เพิ่มใน Sprint 2

---

## Action Items / สิ่งที่ต้องทำ

| # | Action | Owner | Due | Status |
|---|--------|-------|-----|--------|
| 1 | เพิ่ม TC-F001-008 (Supervisor approve) ก่อนเริ่ม Sprint 2 | orawan.nus | Sprint 2 start | Pending |
| 2 | เพิ่ม TC-F001-009 (Supervisor reject) ก่อนเริ่ม Sprint 2 | orawan.nus | Sprint 2 start | Pending |
| 3 | เพิ่ม Performance test plan ใน Sprint 2 | siriporn.san | Sprint 2 start | Pending |
| 4 | เพิ่ม TC-F001-010 (concurrent duplicate) ใน integration tests | thamonwan.san | Sprint 2 | Pending |

*หมายเหตุ: Action items ข้างต้นไม่ block Phase 4 และ Sprint 1 — F-001 Sprint 1 stories ได้รับการ cover แล้วด้วย 7 test cases*

---

## Test Coverage Summary / สรุป Coverage

| Category | Test Cases | AC Covered | FR Covered |
|---------|-----------|-----------|-----------|
| Happy Path | 2 (TC-001, TC-002) | AC-F001-001, AC-F001-002 | FR-001, FR-002, FR-007, FR-010 |
| Error Cases | 2 (TC-003, TC-004) | AC-F001-003, AC-F001-004 | FR-003, FR-004 |
| Validation | 1 (TC-005) | AC-F001-005 | FR-005, FR-009 |
| Search | 1 (TC-006) | AC-F001-006 | FR-008 |
| Compliance/Audit | 1 (TC-007) | AC-F001-001 (audit) | FR-006 |
| **Total** | **7** | **6/6 ACs ✅** | **8/11 FRs (Sprint 1)** |

---

## Outcome / ผลลัพธ์

**Decision**: ✅ **Approved**

Test cases สำหรับ F-001 Sprint 1 stories ได้รับการอนุมัติ ครอบคลุม happy path, error cases, validation, และ compliance requirements ครบถ้วน

**Notes**:
- Sprint 2 test cases (Supervisor approval flow, performance, concurrent) จะเพิ่มก่อนเริ่ม Sprint 2
- ทีมเห็นพ้องว่า 7 test cases ครอบคลุม Sprint 1 delivery ได้ครบถ้วน

---

## Sign-offs / ลายเซ็น

| Role | Name | Status | Date |
|------|------|--------|------|
| SA | Siriporn San | ✅ Approved | 2026-05-15 |
| SA | Thamonwan San | ✅ Approved | 2026-05-15 |
| BA | Orawan Nus | ✅ Approved | 2026-05-15 |
| PM | Bovornsak Pan | ✅ Approved | 2026-05-15 |

---

*Document ID: PTL-VAL-TESTING | Version: 1.0.0 | อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
