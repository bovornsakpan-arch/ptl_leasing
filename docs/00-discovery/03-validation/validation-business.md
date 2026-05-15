---
doc_id: "PTL-VAL-BUSINESS"
title: "Validation: Business Design"
project: ptl_leasing
type: validation
version: "1.0.0"
status: approved
owner: orawan.nus@snocko-tech.com
phase: "03-validation"
feature_id: "F-001"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "orawan.nus@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_date: "2026-05-15"
---

# Validation: Business Design / การตรวจสอบ Business Design

> **Version**: 1.0.0 | **Status**: Approved | **Feature**: F-001 Customer Registration

---

## Session Information / ข้อมูล Session

| Field | Value |
|-------|-------|
| Session Date | 2026-05-15 |
| Session Time | 10:00–12:00 น. |
| Facilitator | Orawan Nus (BA) |
| Duration | 2 ชั่วโมง |
| Location | Meeting Room B / Microsoft Teams |
| Recording | Available (ขอจาก BA) |

---

## Participants / ผู้เข้าร่วม

| Role | Name | Email | Sign-off |
|------|------|-------|---------|
| PM | Bovornsak Pan | bovornsak.pan@snocko-tech.com | ✅ Signed |
| BA | Orawan Nus | orawan.nus@snocko-tech.com | ✅ Signed |
| Business Owner (Head of Credit) | — | credit-head@ptleasing.co.th | ✅ Signed |
| SA (Observer) | Siriporn San | siriporn.san@snocko-tech.com | — (Observer) |

---

## Documents Reviewed / เอกสารที่ Review

| Document | Version | Path | Status |
|----------|---------|------|--------|
| BRD: Customer Registration | 1.0.0 | docs/00-discovery/01-requirements/new-features/F-001-customer-registration/BRD.md | ✅ Reviewed |
| Business Flow | 1.0.0 | docs/00-discovery/02-design/business/BUSINESS_FLOW.md | ✅ Reviewed |
| Acceptance Criteria | 1.0.0 | docs/00-discovery/01-requirements/new-features/F-001-customer-registration/ACCEPTANCE_CRITERIA.md | ✅ Reviewed |

---

## Checklist / รายการตรวจสอบ

- [x] Business flow ครอบคลุม happy path ทั้งหมด (Individual + Juristic)
- [x] Business flow ครอบคลุม error cases สำคัญ (duplicate, missing docs)
- [x] Business rules BR-001 ถึง BR-007 ถูกต้องและครบถ้วน
- [x] Supervisor approval workflow ชัดเจน
- [x] Stakeholders เห็นด้วยกับ scope (In/Out scope)
- [x] ไม่มี critical ambiguities ค้างอยู่
- [x] Scope ชัดเจน — credit scoring ยืนยันอยู่นอก scope

---

## Discussion Points / ประเด็นที่หารือ

### 1. Field วันเกิดลูกค้า
**ประเด็น**: BRD ฉบับ draft ไม่มี field วันเกิด (Date of Birth) ทั้งที่จำเป็นสำหรับตรวจสอบอายุขั้นต่ำและ credit assessment ในอนาคต

**Decision**: เพิ่ม field วันเกิดใน Individual Customer registration (บังคับ) พร้อมกับ BR-005 (อายุ ≥ 20 ปี)

**Owner**: Orawan Nus (BA) | **Due**: 2026-05-15 | **Status**: ✅ Done

---

### 2. ประเภทเอกสาร KYC สำหรับ Juristic Customer
**ประเด็น**: Business Owner ต้องการให้ระบุเอกสาร KYC ที่บังคับชัดเจนสำหรับแต่ละประเภทลูกค้า

**Decision**:
- Individual: บัตรประชาชน + ทะเบียนบ้าน (บังคับ), รายได้ (optional)
- Juristic: หนังสือรับรองบริษัท + บัตรประชาชนผู้มีอำนาจ (บังคับ), หนังสือมอบอำนาจ (ถ้ามีตัวแทน)

**Owner**: Orawan Nus | **Due**: 2026-05-15 | **Status**: ✅ Done (อัปเดตใน BRD BR-002)

---

### 3. Workflow เมื่อ Supervisor Reject
**ประเด็น**: หลัง Supervisor reject ต้องทำอะไรต่อ — Staff สามารถแก้ไขแล้ว submit ใหม่ได้หรือไม่?

**Decision**: Staff สามารถแก้ไขข้อมูล/เอกสาร แล้ว submit ใหม่ได้ — เก็บ history ของ rejection ไว้ใน registration record

**Owner**: Siriporn San (SA) | **Due**: 2026-05-16 | **Status**: ✅ Done (อัปเดตใน SYSTEM_DESIGN.md)

---

## Action Items / สิ่งที่ต้องทำ

| # | Action | Owner | Due | Status |
|---|--------|-------|-----|--------|
| 1 | แก้ BRD section 4 เพิ่ม field วันเกิด (Date of Birth) | orawan.nus | 2026-05-15 | ✅ Done |
| 2 | อัปเดต BRD เพิ่ม BR-005 (age validation) | orawan.nus | 2026-05-15 | ✅ Done |
| 3 | อัปเดต SRS FR-001 เพิ่ม date_of_birth field | siriporn.san | 2026-05-15 | ✅ Done |
| 4 | ระบุ KYC documents ที่บังคับสำหรับแต่ละประเภทลูกค้าใน BRD BR-002 | orawan.nus | 2026-05-15 | ✅ Done |
| 5 | Update BUSINESS_FLOW.md เพิ่ม reject → re-submit flow | orawan.nus | 2026-05-15 | ✅ Done |

---

## Outcome / ผลลัพธ์

**Decision**: ✅ **Approved with Minor Changes**

Business design สำหรับ F-001 Customer Registration ได้รับการอนุมัติ โดยมีการแก้ไขเล็กน้อย (เพิ่ม field วันเกิด, ระบุ KYC documents ให้ชัดเจน) ซึ่งได้ดำเนินการแก้ไขครบถ้วนแล้ว

**Notes**:
- Business Owner ให้ feedback ว่า flow ชัดเจน ใช้งานได้จริง
- ทีมเห็นพ้องว่าระบบใหม่จะช่วยลดเวลาลงทะเบียนได้จริงตาม target 10 นาที/ราย

---

## Sign-offs / ลายเซ็น

| Role | Name | Status | Date |
|------|------|--------|------|
| Business Owner | Head of Credit | ✅ Approved | 2026-05-15 |
| BA | Orawan Nus | ✅ Approved | 2026-05-15 |
| PM | Bovornsak Pan | ✅ Approved | 2026-05-15 |

---

*Document ID: PTL-VAL-BUSINESS | Version: 1.0.0 | อัปเดตล่าสุด: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
