---
doc_id: "PTL-VAL-SYSTEM"
title: "Validation: System Design"
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

# Validation: System Design
# การตรวจสอบ System Design

> **Version**: 1.0.0 | **Status**: Approved | **Feature**: F-001 Customer Registration

---

## Session Information / ข้อมูล Session

| Field | Value |
|-------|-------|
| Session Date | 2026-05-15 |
| Session Time | 13:00–15:00 น. |
| Facilitator | Siriporn San (SA) |
| Duration | 2 ชั่วโมง |
| Location | Meeting Room A / Microsoft Teams |

---

## Participants / ผู้เข้าร่วม

| Role | Name | Email | Sign-off |
|------|------|-------|---------|
| PM | Bovornsak Pan | bovornsak.pan@snocko-tech.com | ✅ Signed |
| SA | Siriporn San | siriporn.san@snocko-tech.com | ✅ Signed |
| SA | Thamonwan San | thamonwan.san@snocko-tech.com | ✅ Signed |
| BA (Observer) | Orawan Nus | orawan.nus@snocko-tech.com | — (Observer) |

---

## Documents Reviewed / เอกสารที่ Review

| Document | Version | Path | Status |
|----------|---------|------|--------|
| System Design | 1.0.0 | docs/00-discovery/02-design/system/SYSTEM_DESIGN.md | ✅ Reviewed |
| API Specification | 1.0.0 | docs/00-discovery/02-design/system/API_SPEC.md | ✅ Reviewed |
| Data Classification | 1.0.0 | docs/00-discovery/02-design/security/DATA_CLASSIFICATION.md | ✅ Reviewed |
| SRS | 1.0.0 | docs/00-discovery/01-requirements/new-features/F-001-customer-registration/SRS.md | ✅ Reviewed |

---

## Checklist / รายการตรวจสอบ

- [x] Component architecture ครอบคลุมทุก component ที่จำเป็น
- [x] Database schema รองรับ Individual และ Juristic customer types
- [x] API endpoints ครบตาม SRS functional requirements ทุกข้อ
- [x] Error handling strategy ครอบคลุม error cases ทั้งหมดใน AC
- [x] Security design — encryption, access control ผ่าน review
- [x] PDPA compliance requirements ถูก implement ใน design
- [x] File upload design — S3, validation, size limit ชัดเจน
- [x] Audit log design — schema และ triggers ครบถ้วน
- [x] Performance requirements สอดคล้องกับ SRS NFR
- [x] No blocking issues outstanding

---

## Discussion Points / ประเด็นที่หารือ

### 1. API Response Format — Pagination
**ประเด็น**: Thamonwan เสนอให้ใช้ `limit` แทน `per_page` ใน pagination เพื่อความ consistent กับ cursor-based pagination ที่อาจใช้ในอนาคต

**Decision**: ปรับ response format ใช้ `limit` แทน `per_page` ใน GET /customers endpoint

**Owner**: Siriporn San | **Due**: 2026-05-15 | **Status**: ✅ Done (อัปเดตใน API_SPEC.md)

---

### 2. Duplicate Check — Timing
**ประเด็น**: ควรตรวจสอบ duplicate เมื่อไหร่ — onBlur หรือ onSubmit เท่านั้น?

**Decision**: ตรวจสอบสองรอบ:
1. onBlur ของ field เลขบัตร (เรียก GET /customers/check-duplicate) — UX feedback ทันที
2. onSubmit (server-side validation) — ป้องกัน race condition

**Owner**: Siriporn San | **Status**: ✅ Done (อัปเดตใน SYSTEM_DESIGN.md)

---

### 3. File Storage Pre-signed URL Expiry
**ประเด็น**: Pre-signed URL สำหรับดูเอกสาร KYC ควร expire เมื่อไหร่?

**Decision**: 15 นาที — สั้นพอสำหรับ security แต่นานพอสำหรับ staff ดู/download เอกสาร

**Owner**: Siriporn San | **Status**: ✅ Done (อัปเดตใน DATA_CLASSIFICATION.md)

---

### 4. Soft Delete สำหรับ Customer
**ประเด็น**: ต้องการ hard delete หรือ soft delete?

**Decision**: Soft delete เท่านั้น (deleted_at field) เพราะต้อง maintain audit trail และ PDPA right to erasure ต้องการ paper trail ว่ามีการ delete

**Owner**: Siriporn San | **Status**: ✅ Done (ใน database schema)

---

## Action Items / สิ่งที่ต้องทำ

| # | Action | Owner | Due | Status |
|---|--------|-------|-----|--------|
| 1 | ปรับ pagination ใน API_SPEC.md ใช้ `limit` แทน `per_page` | siriporn.san | 2026-05-15 | ✅ Done |
| 2 | เพิ่ม duplicate check endpoint ใน API_SPEC.md | siriporn.san | 2026-05-15 | ✅ Done |
| 3 | อัปเดต DATA_CLASSIFICATION.md ระบุ pre-signed URL expiry = 15 min | siriporn.san | 2026-05-15 | ✅ Done |
| 4 | เพิ่ม soft delete field ใน database schema | siriporn.san | 2026-05-15 | ✅ Done |

---

## Outcome / ผลลัพธ์

**Decision**: ✅ **Approved with Minor Changes**

System design สำหรับ F-001 ได้รับการอนุมัติ โดยมีการปรับ API response format เล็กน้อย (pagination field name) และ clarify timing ของ duplicate check ซึ่งแก้ไขครบถ้วนแล้ว

**Notes**:
- Thamonwan เห็นว่า architecture เหมาะสม scalable ได้ดี
- Database schema รองรับ future features (credit scoring, contracts) ได้โดยไม่ต้องแก้โครงสร้างหลัก

---

## Sign-offs / ลายเซ็น

| Role | Name | Status | Date |
|------|------|--------|------|
| SA | Siriporn San | ✅ Approved | 2026-05-15 |
| SA | Thamonwan San | ✅ Approved | 2026-05-15 |
| PM | Bovornsak Pan | ✅ Approved | 2026-05-15 |

---

*Document ID: PTL-VAL-SYSTEM | Version: 1.0.0 | อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
