---
doc_id: "PTL-TC-MASTER"
title: "Test Cases Master List — PT Leasing"
project: ptl_leasing
type: test_case
version: "1.0.0"
status: final
owner: orawan.nus@snocko-tech.com
phase: "02-design"
feature_id: "F-001"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "siriporn.san@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_date: "2026-05-15"
---

# Test Cases Master List / รายการ Test Cases

> **Version**: 1.0.0 | **Status**: Final
> เอกสารนี้รวบรวม test cases จากทุก feature สำหรับ regression testing

---

## Overview / ภาพรวม

| Epic | Feature | Total TCs | Pending | Pass | Fail |
|------|---------|-----------|---------|------|------|
| EPIC-01 | Authentication | 0 | 0 | 0 | 0 |
| EPIC-02 | Contracts | 0 | 0 | 0 | 0 |
| EPIC-03 | Customers (F-001) | 7 | 7 | 0 | 0 |
| EPIC-04 | Payments | 0 | 0 | 0 | 0 |
| **รวม** | | **7** | **7** | **0** | **0** |

---

## F-001: Customer Registration — Test Cases

### TC-F001-001: ลงทะเบียนลูกค้าบุคคลธรรมดาสำเร็จ

| Field | Value |
|-------|-------|
| **Test Case ID** | TC-F001-001 |
| **Feature** | F-001 Customer Registration |
| **Story Ref** | US-F001-001 |
| **AC Ref** | AC-F001-001 |
| **Type** | Functional — Happy Path |
| **Priority** | Critical |
| **Automation** | Planned |

**Preconditions (เงื่อนไขก่อนทดสอบ)**:
- Staff มี account และ role OFFICER
- ไม่มีลูกค้าเลขบัตร 1100100123456 ในระบบ
- เอกสาร KYC (id_card.jpg, house_reg.pdf) เตรียมพร้อม

**Test Steps / ขั้นตอนทดสอบ**:

| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | Login ด้วย officer@ptleasing.co.th | Login สำเร็จ เข้า Dashboard |
| 2 | คลิก "ลงทะเบียนลูกค้าใหม่" | เปิดหน้าฟอร์มลงทะเบียน |
| 3 | เลือกประเภท "บุคคลธรรมดา" | ฟอร์มแสดง fields สำหรับบุคคลธรรมดา |
| 4 | กรอก ชื่อ: สมชาย, นามสกุล: ใจดี | Field แสดงค่าที่กรอก |
| 5 | กรอก เลขบัตร: 1100100123456 | Field แสดงค่า, ไม่มี error |
| 6 | กรอก วันเกิด: 15/03/1985 | คำนวณอายุ 41 ปี — ผ่าน |
| 7 | กรอก ที่อยู่, เบอร์โทร, email ครบ | ไม่มี validation error |
| 8 | อัปโหลด id_card.jpg (500KB) | แสดง "อัปโหลดสำเร็จ ✓ บัตรประชาชน" |
| 9 | อัปโหลด house_reg.pdf (2MB) | แสดง "อัปโหลดสำเร็จ ✓ ทะเบียนบ้าน" |
| 10 | กด "Submit Registration" | แสดง Confirmation Dialog |
| 11 | กด "ยืนยัน" | แสดง success message + Customer ID |
| 12 | ตรวจสอบ email Supervisor | Supervisor ได้รับ email notification |
| 13 | ตรวจสอบ audit log | พบ record CUSTOMER_CREATED |

**Expected Final Result**: Customer สร้างสำเร็จ status = PENDING_REVIEW

---

### TC-F001-002: ลงทะเบียนลูกค้านิติบุคคลสำเร็จ

| Field | Value |
|-------|-------|
| **Test Case ID** | TC-F001-002 |
| **Feature** | F-001 Customer Registration |
| **Story Ref** | US-F001-002 |
| **AC Ref** | AC-F001-002 |
| **Type** | Functional — Happy Path |
| **Priority** | Critical |
| **Automation** | Planned |

**Preconditions**:
- Staff มี account role OFFICER
- ไม่มีเลขทะเบียนนิติบุคคล 0105562012345 ในระบบ

**Test Steps**:

| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | Login สำเร็จ | เข้า Dashboard |
| 2 | เปิดหน้าลงทะเบียนลูกค้าใหม่ | แสดงฟอร์ม |
| 3 | เลือก "นิติบุคคล (Juristic)" | ฟอร์มเปลี่ยนเป็น Juristic fields |
| 4 | กรอกชื่อบริษัท: บริษัท เอบีซี จำกัด | Field แสดงค่า |
| 5 | กรอกเลขทะเบียน: 0105562012345 | ไม่มี error |
| 6 | กรอกที่อยู่จดทะเบียน, เบอร์โทร, email | ไม่มี error |
| 7 | กรอกชื่อผู้มีอำนาจ + เลขบัตร | ไม่มี error |
| 8 | อัปโหลดหนังสือรับรองบริษัท (PDF) | อัปโหลดสำเร็จ |
| 9 | อัปโหลดบัตรประชาชนผู้มีอำนาจ (JPG) | อัปโหลดสำเร็จ |
| 10 | Submit และยืนยัน | สร้างสำเร็จ status = PENDING_REVIEW |

**Expected Final Result**: Juristic Customer สร้างสำเร็จ

---

### TC-F001-003: เลขบัตรประชาชนซ้ำในระบบ → Error

| Field | Value |
|-------|-------|
| **Test Case ID** | TC-F001-003 |
| **Feature** | F-001 Customer Registration |
| **Story Ref** | US-F001-001 |
| **AC Ref** | AC-F001-003 |
| **Type** | Functional — Error Case |
| **Priority** | Critical |
| **Automation** | Planned |

**Preconditions**:
- มีลูกค้า "สมหญิง รักดี" เลขบัตร 1100100999888 ในระบบแล้ว

**Test Steps**:

| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | เปิดหน้าลงทะเบียนลูกค้าบุคคลธรรมดา | แสดงฟอร์ม |
| 2 | กรอกเลขบัตร: 1100100999888 | — |
| 3 | คลิกออกจาก field (Tab) | แสดง error: "เลขบัตรประชาชนมีอยู่ในระบบแล้ว" |
| 4 | ตรวจสอบปุ่ม Submit | ปุ่ม Submit ถูก disable |
| 5 | คลิก link "ดูข้อมูลลูกค้าที่มีอยู่" | นำทางไปหน้า CUS-2026-XXXXX |
| 6 | กลับแก้ไขเลขบัตรใหม่เป็นเลขอื่น | error หายไป, ปุ่ม Submit ใช้ได้ |

**Expected Final Result**: ระบบป้องกัน duplicate ได้สำเร็จ

---

### TC-F001-004: อัปโหลดไฟล์เกิน 10 MB → Error

| Field | Value |
|-------|-------|
| **Test Case ID** | TC-F001-004 |
| **Feature** | F-001 Customer Registration |
| **Story Ref** | US-F001-003 |
| **AC Ref** | AC-F001-004 |
| **Type** | Functional — Error Case |
| **Priority** | High |
| **Automation** | Planned |

**Test Steps**:

| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | เปิดหน้าลงทะเบียนลูกค้า | แสดงฟอร์ม |
| 2 | คลิก Upload ที่ section บัตรประชาชน | เปิด file picker |
| 3 | เลือกไฟล์ขนาด 15 MB | — |
| 4 | ระบบตรวจสอบขนาด | แสดง error: "ไฟล์มีขนาด 15 MB เกินขีดจำกัด 10 MB" |
| 5 | ตรวจสอบว่าไฟล์ถูก upload หรือไม่ | ไม่มี HTTP request ออกไป |
| 6 | อัปโหลดไฟล์ประเภท .docx | error: "ไม่รองรับไฟล์ประเภท .docx" |
| 7 | อัปโหลดไฟล์ PDF ขนาด 5 MB | อัปโหลดสำเร็จ ✓ |

---

### TC-F001-005: ข้อมูลฟอร์มไม่ครบ/ไม่ถูกต้อง → Validation Error

| Field | Value |
|-------|-------|
| **Test Case ID** | TC-F001-005 |
| **Feature** | F-001 Customer Registration |
| **Story Ref** | US-F001-001 |
| **AC Ref** | AC-F001-005 |
| **Type** | Functional — Validation |
| **Priority** | High |
| **Automation** | Planned |

**Test Steps**:

| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | กรอกเลขบัตร: 1100100 (7 หลัก) | error: "เลขบัตรประชาชนต้องมี 13 หลัก" |
| 2 | กรอก email: notvalidemail | error: "รูปแบบ email ไม่ถูกต้อง" |
| 3 | กรอกวันเกิด: 15/03/2010 | error: "ลูกค้าต้องมีอายุไม่ต่ำกว่า 20 ปี" |
| 4 | ไม่กรอก field "ชื่อ" แล้ว Submit | highlight ชื่อด้วย red, scroll ไปที่ field |
| 5 | แก้ไขทุก error | ปุ่ม Submit ใช้ได้ |

---

### TC-F001-006: ค้นหาลูกค้าด้วยชื่อ/เลขบัตร/เบอร์โทร

| Field | Value |
|-------|-------|
| **Test Case ID** | TC-F001-006 |
| **Feature** | F-001 Customer Registration |
| **Story Ref** | US-F001-004 |
| **AC Ref** | AC-F001-006 |
| **Type** | Functional — Happy Path |
| **Priority** | High |
| **Automation** | Planned |

**Preconditions**: มีลูกค้าในระบบ: สมชาย ใจดี (CUS-001), สมหญิง รักดี (CUS-002), บริษัท เอบีซี (CUS-003)

**Test Steps**:

| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | ค้นหา "สมชาย" | แสดง CUS-001 สมชาย ใจดี |
| 2 | ค้นหา "สม" | แสดง CUS-001 และ CUS-002 |
| 3 | ค้นหาเลขบัตร "1100200654321" | แสดง CUS-002 เท่านั้น |
| 4 | ค้นหาเบอร์ "02-234" | แสดง CUS-003 |
| 5 | ค้นหา "xyz123ไม่มีในระบบ" | แสดง "ไม่พบลูกค้า" + ปุ่มลงทะเบียนใหม่ |
| 6 | กดปุ่มลงทะเบียนใหม่ | นำทางไปหน้าฟอร์มลงทะเบียน |

---

### TC-F001-007: Audit Log บันทึกทุก Action ครบ

| Field | Value |
|-------|-------|
| **Test Case ID** | TC-F001-007 |
| **Feature** | F-001 Customer Registration |
| **Story Ref** | US-F001-001, US-F001-003 |
| **AC Ref** | AC-F001-001 |
| **Type** | Functional — Security/Compliance |
| **Priority** | High |
| **Automation** | Planned |

**Test Steps**:

| Step | Action | Expected Audit Log Entry |
|------|--------|--------------------------|
| 1 | Staff สร้างลูกค้าใหม่ | action=CUSTOMER_CREATED, user_id=staff_id, resource_id=CUS-001, timestamp=now |
| 2 | Staff อัปโหลดเอกสาร | action=DOCUMENT_UPLOADED, doc_type=ID_CARD, customer_id=CUS-001 |
| 3 | Staff submit registration | action=REGISTRATION_SUBMITTED, customer_id=CUS-001 |
| 4 | Staff เปิดดูข้อมูล sensitive (เลขบัตร) | action=SENSITIVE_DATA_VIEWED, field=id_card_no |
| 5 | Supervisor approve | action=REGISTRATION_APPROVED, reviewer_id=supervisor_id |
| 6 | ตรวจสอบ audit log ใน DB | ครบทุก record, ไม่สามารถ delete ได้ |

---

## Test Case Registry / ทะเบียน Test Cases

| TC ID | Feature | Description | Type | Priority | Status |
|-------|---------|-------------|------|---------|--------|
| TC-F001-001 | F-001 | ลงทะเบียนบุคคลธรรมดาสำเร็จ | Happy Path | Critical | Pending |
| TC-F001-002 | F-001 | ลงทะเบียนนิติบุคคลสำเร็จ | Happy Path | Critical | Pending |
| TC-F001-003 | F-001 | เลขบัตรซ้ำ → error | Error Case | Critical | Pending |
| TC-F001-004 | F-001 | ไฟล์เกิน 10MB → error | Error Case | High | Pending |
| TC-F001-005 | F-001 | Validation error | Validation | High | Pending |
| TC-F001-006 | F-001 | ค้นหาลูกค้า | Happy Path | High | Pending |
| TC-F001-007 | F-001 | Audit log ครบ | Compliance | High | Pending |

---

## Regression Test Suite / ชุด Regression Test

### Critical Path Tests (ต้องรันทุกครั้งก่อน deploy)

| TC ID | Description | Automation Status |
|-------|-------------|------------------|
| TC-F001-001 | ลงทะเบียนบุคคลธรรมดาสำเร็จ | Planned — Sprint 1 |
| TC-F001-002 | ลงทะเบียนนิติบุคคลสำเร็จ | Planned — Sprint 1 |
| TC-F001-003 | Duplicate check | Planned — Sprint 1 |

---

*Document ID: PTL-TC-MASTER | Version: 1.0.0 | อัปเดตล่าสุด: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
