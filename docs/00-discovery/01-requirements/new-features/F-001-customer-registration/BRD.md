---
doc_id: "PTL-F001-BRD"
title: "BRD: Customer Registration"
project: ptl_leasing
type: new_feature
version: "1.0.0"
status: final
owner: orawan.nus@snocko-tech.com
phase: "01-requirements"
feature_id: "F-001"
jira_issue: "PTL-101"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "orawan.nus@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_date: "2026-05-15"
---

# BRD: Customer Registration
# Business Requirements Document

> **Feature ID**: F-001 | **Version**: 1.0.0 | **Status**: Final | **Doc ID**: PTL-F001-BRD

---

## 1. Business Context / บริบทธุรกิจ

PT Leasing เป็นบริษัทให้เช่าซื้อสินทรัพย์ (equipment/vehicle leasing) ในประเทศไทย ปัจจุบันมีลูกค้าทั้งบุคคลธรรมดาและนิติบุคคลที่ต้องการเช่าซื้อสินทรัพย์ประเภทต่างๆ

ฝ่ายสินเชื่อ (Credit Department) มีหน้าที่รับเรื่องและลงทะเบียนลูกค้าใหม่ก่อนดำเนินการพิจารณาสินเชื่อ กระบวนการลงทะเบียนลูกค้าเป็นจุดเริ่มต้นของ customer lifecycle ทั้งหมดในระบบ

เพื่อรองรับการเติบโตของธุรกิจและยกระดับประสิทธิภาพการทำงาน PT Leasing ต้องการพัฒนาระบบ **Web Backoffice** สำหรับ staff ในการลงทะเบียนและจัดการข้อมูลลูกค้า ทดแทนกระบวนการด้วยมือที่ใช้ Excel และกระดาษในปัจจุบัน

---

## 2. Problem Statement / ปัญหาที่ต้องการแก้ไข

### ปัญหาปัจจุบัน (As-Is)

ขั้นตอนการลงทะเบียนลูกค้าในปัจจุบันมีปัญหาดังนี้:

| ปัญหา | ผลกระทบ | ความรุนแรง |
|-------|---------|-----------|
| Staff กรอกข้อมูลลูกค้าลง Excel แล้วส่ง email ให้ supervisor | ข้อมูลหาย กระจัดกระจายใน inbox | สูง |
| ไม่มีการตรวจสอบข้อมูลซ้ำ (duplicate) อัตโนมัติ | ลูกค้าคนเดียวถูกลงทะเบียนหลายครั้ง | สูง |
| ไม่มี validation — staff กรอกข้อมูลไม่ครบ/ไม่ถูกต้อง | เอกสารขาด ต้องขอเพิ่มซ้ำหลายรอบ | สูง |
| ไฟล์เอกสาร KYC ส่งผ่าน email attachment | ไฟล์หาย/ขนาดใหญ่เกิน limit | กลาง |
| ไม่มี audit trail — ไม่รู้ว่าใคร แก้ไขอะไร เมื่อไหร่ | ปัญหาด้าน compliance และ PDPA | สูง |
| ใช้เวลาลงทะเบียนลูกค้าใหม่เฉลี่ย 30 นาที/ราย | ต้นทุนเวลาสูง รับลูกค้าได้น้อย | กลาง |

### Root Cause
ขาดระบบ centralized สำหรับจัดการข้อมูลลูกค้า — พึ่งพา manual process และเครื่องมือที่ไม่ได้ออกแบบมาสำหรับ workflow นี้โดยตรง

---

## 3. Proposed Solution / วิธีแก้ไขที่เสนอ

พัฒนา **F-001 Customer Registration Module** ภายใน PT Leasing Backoffice System ซึ่งเป็น web application สำหรับ staff ฝ่ายสินเชื่อ โดยมีความสามารถหลักดังนี้:

1. **ฟอร์มลงทะเบียนลูกค้า** — รองรับทั้งบุคคลธรรมดา (Individual) และนิติบุคคล (Juristic Person) พร้อม real-time validation
2. **KYC Document Upload** — อัปโหลดเอกสาร PDF/JPG พร้อมจัดเก็บ secure storage
3. **Duplicate Detection** — ตรวจสอบเลขบัตรประชาชน/เลขทะเบียนนิติบุคคลไม่ซ้ำก่อน submit
4. **Approval Workflow** — ส่งเรื่องให้ Supervisor review และ approve/reject ผ่านระบบ
5. **Customer Search** — ค้นหาลูกค้าด้วยชื่อ เลขบัตร เบอร์โทร
6. **Audit Log** — บันทึกทุก action ของ staff โดยอัตโนมัติ

---

## 4. Scope / ขอบเขต

### In Scope / ขอบเขตที่รวม

- [x] ลงทะเบียนลูกค้าบุคคลธรรมดา (Individual Customer) — ชื่อ-นามสกุล, เลขบัตรประชาชน, วันเกิด, ที่อยู่, เบอร์โทร, email, ข้อมูลการติดต่อฉุกเฉิน
- [x] ลงทะเบียนลูกค้านิติบุคคล (Juristic Customer) — ชื่อบริษัท, เลขทะเบียนนิติบุคคล, ที่อยู่จดทะเบียน, ผู้มีอำนาจลงนาม
- [x] อัปโหลดเอกสาร KYC — บัตรประชาชน, ทะเบียนบ้าน, หนังสือรับรองบริษัท, หนังสือมอบอำนาจ (แล้วแต่ประเภทลูกค้า)
- [x] ตรวจสอบความถูกต้องข้อมูลเบื้องต้น (validation)
- [x] ตรวจสอบข้อมูลซ้ำในระบบ (duplicate check)
- [x] ส่ง registration ให้ Supervisor review ผ่าน workflow
- [x] ค้นหาลูกค้าด้วยชื่อ/เลขบัตร/เบอร์โทร
- [x] บันทึก audit log ทุก action
- [x] ส่ง notification email เมื่อ registration สำเร็จ

### Out of Scope / ขอบเขตที่ไม่รวม

- Credit Scoring / การประเมินสินเชื่อ (Feature แยกต่างหาก)
- การอนุมัติสัญญาเช่าซื้อ
- ระบบ Customer Self-Service / Customer Portal
- การชำระเงิน / Payment Processing
- การออกใบเสร็จ
- Mobile Application

---

## 5. Stakeholders / ผู้มีส่วนได้เสีย

| Role | Name | Email | Responsibility |
|------|------|-------|---------------|
| Business Owner | ฝ่ายสินเชื่อ (Head of Credit) | credit-head@ptleasing.co.th | Final business approval, UAT |
| PM | Bovornsak Pan | bovornsak.pan@snocko-tech.com | Project management, timeline |
| BA | Orawan Nus | orawan.nus@snocko-tech.com | Requirements gathering & documentation |
| SA | Siriporn San | siriporn.san@snocko-tech.com | System design & API spec |
| Dev Lead | TBD | TBD | Technical implementation |
| QA | TBD | TBD | Testing & acceptance |
| End Users | Staff ฝ่ายสินเชื่อ | — | ใช้งานระบบในการลงทะเบียนลูกค้า |

---

## 6. Business Rules / กฎธุรกิจ

| Rule ID | Category | Description | Notes |
|---------|---------|-------------|-------|
| BR-001 | Uniqueness | เลขบัตรประชาชน 13 หลักต้องไม่ซ้ำในระบบ — ห้ามลงทะเบียนลูกค้าซ้ำ | ตรวจสอบก่อน submit |
| BR-002 | KYC Completeness | เอกสาร KYC ต้องครบตามประเภทลูกค้าก่อนกดปุ่ม Submit | Individual: บัตรประชาชน + ทะเบียนบ้าน; Juristic: หนังสือรับรองบริษัท + บัตรประชาชนผู้มีอำนาจ |
| BR-003 | Data Classification | ข้อมูลลูกค้าทั้งหมดถูก classify เป็น Confidential (C3-C4) ตาม PDPA | ต้องเข้ารหัสข้อมูลสำคัญ |
| BR-004 | Approval Workflow | Registration ใหม่ทุกรายต้องผ่านการ review จาก Supervisor ก่อน activate | Supervisor = role MANAGER ขึ้นไป |
| BR-005 | Date of Birth | ลูกค้าบุคคลธรรมดาต้องมีอายุไม่ต่ำกว่า 20 ปีบริบูรณ์ ณ วันลงทะเบียน | ตรวจสอบจากวันเกิด |
| BR-006 | Audit Trail | ทุก action ของ staff (create, update, view sensitive data) ต้องถูกบันทึกใน audit log | ไม่สามารถลบ audit log ได้ |
| BR-007 | File Size | เอกสาร KYC แต่ละไฟล์ต้องมีขนาดไม่เกิน 10 MB | รองรับนามสกุล PDF, JPG, PNG |

---

## 7. Assumptions & Constraints / สมมติฐานและข้อจำกัด

### Assumptions (สมมติฐาน)
- Staff ทุกคนที่ใช้ระบบมี account และ role ที่ถูกต้องแล้ว (จาก Auth module)
- ระบบ email notification พร้อมใช้งาน (SMTP configured)
- File storage (S3/MinIO) พร้อมใช้งานก่อน deploy
- Database schema สำหรับ customer management ได้รับการออกแบบและ migrated แล้ว

### Constraints (ข้อจำกัด)
- ต้องทำงานบน Chrome และ Edge (latest 2 versions) — ไม่รองรับ Internet Explorer
- ต้อง comply กับ PDPA (Personal Data Protection Act) พ.ศ. 2562
- Response time ต้องไม่เกิน 2 วินาที สำหรับ 95th percentile
- ต้องรองรับ concurrent users อย่างน้อย 50 คน

---

## 8. Success Metrics / ตัวชี้วัดความสำเร็จ

| Metric | Baseline (As-Is) | Target (To-Be) | วิธีวัด |
|--------|-----------------|---------------|--------|
| เวลาลงทะเบียนลูกค้าใหม่ | 30 นาที/ราย | ≤ 10 นาที/ราย | Timer ใน system |
| ความครบถ้วนของข้อมูล | ~70% (กรอกครบ) | 100% (validation บังคับ) | Field completion rate |
| Duplicate registrations | ~5% ของ registrations | 0% | Duplicate detection report |
| กรณีต้องขอเอกสารซ้ำ | ~30% ของ cases | ≤ 5% | Rejection rate |
| Audit trail coverage | 0% (ไม่มีระบบ) | 100% | Audit log coverage |

---

## Sign-off / การอนุมัติ

| Role | Name | Status | Date |
|------|------|--------|------|
| Business Owner (Head of Credit) | — | ✅ Approved | 2026-05-15 |
| BA | Orawan Nus | ✅ Approved | 2026-05-15 |
| PM | Bovornsak Pan | ✅ Approved | 2026-05-15 |

---

*Document ID: PTL-F001-BRD | Version: 1.0.0 | Last updated: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
