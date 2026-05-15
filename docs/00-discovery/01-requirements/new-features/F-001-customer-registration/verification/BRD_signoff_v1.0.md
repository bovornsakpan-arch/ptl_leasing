---
doc_id: "PTL-F001-BRD-SIGNOFF-v1.0"
title: "BRD Sign-off: Customer Registration v1.0.0"
project: ptl_leasing
type: signoff
version: "1.0.0"
status: approved
owner: bovornsak.pan@snocko-tech.com
feature_id: "F-001"
document_ref: "PTL-F001-BRD"
document_version: "1.0.0"
signoff_date: "2026-05-15"
created_at: "2026-05-15"
---

# BRD Sign-off Record
# บันทึกการอนุมัติ Business Requirements Document

---

## Document Information / ข้อมูลเอกสาร

| Field | Value |
|-------|-------|
| Document ID | PTL-F001-BRD |
| Document Title | BRD: Customer Registration |
| Document Version | 1.0.0 |
| Feature | F-001 Customer Registration |
| Sign-off Date | 2026-05-15 |
| Sign-off Status | **Approved** |

---

## Review Summary / สรุปการ Review

BRD ฉบับนี้ได้ผ่านการ review session เมื่อ 2026-05-15 โดย BA และ PM ร่วมกับ Business Owner (ฝ่ายสินเชื่อ)

**ประเด็นที่หารือ**:
1. ขอบเขต (Scope) ของ feature — ตกลงว่า credit scoring อยู่นอก scope
2. Business Rule BR-005 เพิ่ม field วันเกิดลูกค้า — ได้แก้ไขใน BRD section 4 และ SRS FR-001 แล้ว
3. Success Metrics — ปรับ target เวลาลงทะเบียนจาก 15 นาทีเป็น 10 นาที ตามข้อเสนอของ Business Owner

**การแก้ไขจาก Draft v0.1.0 → Final v1.0.0**:
- เพิ่ม field วันเกิด (Date of Birth) ใน In Scope
- เพิ่ม BR-005 (age validation ≥ 20 ปี)
- เพิ่ม BR-006 (audit trail)
- ปรับ Success Metrics ให้ชัดเจนขึ้น
- เพิ่ม Assumptions & Constraints section

---

## Signatories / ผู้ลงนาม

| Role | Name | Email | Status | Date |
|------|------|-------|--------|------|
| Project Manager (PM) | Bovornsak Pan | bovornsak.pan@snocko-tech.com | ✅ Approved | 2026-05-15 |
| Business Analyst (BA) | Orawan Nus | orawan.nus@snocko-tech.com | ✅ Approved | 2026-05-15 |

---

## Decision / ผลการพิจารณา

> **APPROVED** — BRD: Customer Registration v1.0.0 ได้รับการอนุมัติ และพร้อมใช้เป็น basis สำหรับ SRS และ Design

---

## Next Steps / ขั้นตอนต่อไป

1. SA (siriporn.san) ดำเนินการเขียน SRS โดยอ้างอิง BRD v1.0.0 นี้ ✅ Done
2. BA (orawan.nus) ดำเนินการเขียน Acceptance Criteria ✅ Done
3. ดำเนินการ Phase 2: Design

---

*Sign-off record created: 2026-05-15 | Created by: orawan.nus@snocko-tech.com*
