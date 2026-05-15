---
doc_id: "PTL-F001-AC"
title: "Acceptance Criteria: Customer Registration"
project: ptl_leasing
type: acceptance_criteria
version: "1.0.0"
status: final
owner: orawan.nus@snocko-tech.com
phase: "04-breakdown"
feature_id: "F-001"
jira_issue: "PTL-101"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "orawan.nus@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_date: "2026-05-15"
---

# Acceptance Criteria: Customer Registration

> **Feature ID**: F-001 | **Version**: 1.0.0 | **Status**: Final

---

## Overview / ภาพรวม

เอกสารนี้กำหนด Acceptance Criteria สำหรับ F-001 Customer Registration ในรูปแบบ Gherkin (Given-When-Then) เพื่อใช้เป็น basis สำหรับ UAT และ automated testing

---

## AC-F001-001: Happy Path — ลงทะเบียนลูกค้าบุคคลธรรมดาสำเร็จ

**Story**: US-F001-001 | **Priority**: Must Have | **Test Case Ref**: TC-F001-001

```gherkin
Feature: Customer Registration — Individual

  Background:
    Given staff ได้ login เข้าระบบด้วย role OFFICER แล้ว
    And staff อยู่บนหน้า "ลงทะเบียนลูกค้าใหม่"

  Scenario: ลงทะเบียนลูกค้าบุคคลธรรมดาสำเร็จ
    Given staff เลือกประเภทลูกค้า "บุคคลธรรมดา (Individual)"
    And staff กรอกข้อมูลส่วนตัวครบถ้วน:
      | Field              | Value                    |
      | ชื่อ               | สมชาย                   |
      | นามสกุล            | ใจดี                    |
      | เลขบัตรประชาชน     | 1100100123456           |
      | วันเกิด            | 15/03/1985              |
      | ที่อยู่ปัจจุบัน    | 123 ถ.สุขุมวิท กรุงเทพฯ  |
      | เบอร์โทรศัพท์      | 081-234-5678            |
      | อีเมล              | somchai@email.com       |
    And staff อัปโหลดเอกสาร KYC ครบ:
      | เอกสาร          | ไฟล์             |
      | บัตรประชาชน     | id_card.jpg     |
      | ทะเบียนบ้าน     | house_reg.pdf   |
    When staff กดปุ่ม "Submit Registration"
    Then ระบบแสดง confirmation dialog "ยืนยันการส่ง registration?"
    When staff กดยืนยัน
    Then ระบบบันทึก registration สำเร็จ
    And ระบบแสดง success message "ส่ง Registration สำเร็จ — รอ Supervisor อนุมัติ"
    And ระบบแสดง Customer ID ที่สร้างใหม่ เช่น "CUS-2026-000001"
    And status ของ registration เป็น "Pending Review"
    And ระบบส่ง email notification ให้ Supervisor
    And ระบบบันทึก audit log: action=CUSTOMER_CREATED, user=staff_id, timestamp=now
```

---

## AC-F001-002: Happy Path — ลงทะเบียนลูกค้านิติบุคคลสำเร็จ

**Story**: US-F001-002 | **Priority**: Must Have | **Test Case Ref**: TC-F001-002

```gherkin
Feature: Customer Registration — Juristic Person

  Background:
    Given staff ได้ login เข้าระบบด้วย role OFFICER แล้ว

  Scenario: ลงทะเบียนลูกค้านิติบุคคลสำเร็จ
    Given staff เลือกประเภทลูกค้า "นิติบุคคล (Juristic)"
    And staff กรอกข้อมูลบริษัทครบถ้วน:
      | Field                    | Value                           |
      | ชื่อบริษัท              | บริษัท เอบีซี จำกัด             |
      | เลขทะเบียนนิติบุคคล    | 0105562012345                   |
      | ที่อยู่จดทะเบียน        | 456 ถ.พระราม 4 กรุงเทพฯ 10110  |
      | ชื่อผู้มีอำนาจลงนาม      | นายวิชาญ สมาร์ท                |
      | เลขบัตรผู้มีอำนาจ        | 1100200345678                  |
      | เบอร์โทรบริษัท           | 02-234-5678                    |
      | อีเมลบริษัท              | info@abc-company.co.th          |
    And staff อัปโหลดเอกสาร KYC ครบ:
      | เอกสาร                  | ไฟล์                           |
      | หนังสือรับรองบริษัท     | company_cert.pdf               |
      | บัตรประชาชนผู้มีอำนาจ   | director_id.jpg                |
    When staff กดปุ่ม "Submit Registration"
    And staff กดยืนยัน
    Then ระบบบันทึก registration สำเร็จ
    And ระบบแสดง Customer ID "CUS-2026-000002"
    And status เป็น "Pending Review"
    And ฟอร์มแสดง section "ผู้มีอำนาจลงนาม" แทน section "ข้อมูลส่วนตัว"
    And ระบบส่ง email notification ให้ Supervisor
```

---

## AC-F001-003: Error Case — เลขบัตรประชาชนซ้ำในระบบ

**Story**: US-F001-001 | **Priority**: Must Have | **Test Case Ref**: TC-F001-003

```gherkin
Feature: Duplicate ID Card Validation

  Background:
    Given ในระบบมีลูกค้า "สมหญิง รักดี" ที่ใช้เลขบัตร "1100100999888" อยู่แล้ว
    And staff ได้ login เข้าระบบแล้ว

  Scenario: ป้อนเลขบัตรประชาชนที่มีอยู่แล้วในระบบ
    Given staff กำลังกรอกฟอร์มลงทะเบียนลูกค้าบุคคลธรรมดา
    When staff กรอกเลขบัตรประชาชน "1100100999888"
    And staff คลิกออกจาก field (onBlur)
    Then ระบบแสดง error message ใต้ field เลขบัตร:
      "เลขบัตรประชาชน 1100100999888 มีอยู่ในระบบแล้ว (ลูกค้า: CUS-2026-XXXXX)"
    And ปุ่ม "Submit Registration" ถูก disable
    And ระบบแสดง link "ดูข้อมูลลูกค้าที่มีอยู่"

  Scenario: พยายาม submit ทั้งที่มี duplicate error
    Given staff กรอกเลขบัตรซ้ำและมี validation error
    When staff พยายาม submit โดยใช้ keyboard shortcut
    Then ระบบไม่ยอม submit
    And แสดง toast error "กรุณาแก้ไขข้อมูลก่อน Submit"
```

---

## AC-F001-004: Error Case — ไฟล์เอกสาร KYC ไม่ถูกต้อง

**Story**: US-F001-003 | **Priority**: Must Have | **Test Case Ref**: TC-F001-004

```gherkin
Feature: KYC Document Upload Validation

  Background:
    Given staff ได้ login และอยู่บนหน้า upload เอกสาร

  Scenario: อัปโหลดไฟล์ที่มีขนาดเกิน 10 MB
    When staff เลือกไฟล์ "large_document.pdf" ขนาด 15 MB
    Then ระบบแสดง error ทันทีก่อน upload:
      "ไฟล์มีขนาด 15 MB เกินขีดจำกัด 10 MB — กรุณาลดขนาดไฟล์"
    And ระบบไม่ทำการ upload ไฟล์นั้น
    And ปุ่ม Submit ยังคง disable อยู่

  Scenario: อัปโหลดไฟล์ประเภทที่ไม่รองรับ
    When staff เลือกไฟล์ "document.docx"
    Then ระบบแสดง error:
      "ไม่รองรับไฟล์ประเภท .docx — รองรับเฉพาะ PDF, JPG, PNG"
    And ระบบไม่ทำการ upload

  Scenario: Submit โดยไม่ครบเอกสาร KYC บังคับ
    Given staff กรอกข้อมูลส่วนตัวครบแล้ว
    But staff อัปโหลดเฉพาะ "บัตรประชาชน" แต่ยังไม่ได้อัปโหลด "ทะเบียนบ้าน"
    When staff กดปุ่ม "Submit Registration"
    Then ระบบแสดง error:
      "เอกสาร KYC ยังไม่ครบ: ต้องอัปโหลด ทะเบียนบ้าน"
    And ระบบ highlight section เอกสารที่ขาด
    And ไม่ทำการ submit
```

---

## AC-F001-005: Error Case — ข้อมูลฟอร์มไม่ถูกต้อง (Validation)

**Story**: US-F001-001 | **Priority**: Must Have | **Test Case Ref**: TC-F001-005

```gherkin
Feature: Form Validation

  Background:
    Given staff อยู่บนหน้าลงทะเบียนลูกค้าบุคคลธรรมดา

  Scenario: กรอกเลขบัตรประชาชนไม่ครบ 13 หลัก
    When staff กรอก "11001001234" (11 หลัก)
    And staff คลิกออกจาก field
    Then แสดง error: "เลขบัตรประชาชนต้องมี 13 หลัก"

  Scenario: กรอกอีเมลในรูปแบบที่ไม่ถูกต้อง
    When staff กรอก email "notvalidemail"
    And staff คลิกออกจาก field
    Then แสดง error: "รูปแบบ email ไม่ถูกต้อง"

  Scenario: ลูกค้าอายุต่ำกว่า 20 ปี
    When staff กรอกวันเกิด "15/03/2010" (อายุ 16 ปี)
    And staff คลิกออกจาก field
    Then แสดง error: "ลูกค้าต้องมีอายุไม่ต่ำกว่า 20 ปีบริบูรณ์"

  Scenario: กด Submit โดยไม่กรอก field บังคับ
    Given staff ไม่ได้กรอก field "ชื่อ" และ "นามสกุล"
    When staff กดปุ่ม "Submit Registration"
    Then ระบบแสดง error summary ด้านบนฟอร์ม:
      "กรุณาแก้ไข 2 ข้อผิดพลาดก่อน Submit"
    And ระบบ highlight field ที่มีปัญหาด้วยสี red border
    And ระบบ scroll ไปยัง field แรกที่มีปัญหา
```

---

## AC-F001-006: ค้นหาลูกค้าด้วยชื่อ/เลขบัตร/เบอร์โทร

**Story**: US-F001-004 | **Priority**: Must Have | **Test Case Ref**: TC-F001-006

```gherkin
Feature: Customer Search

  Background:
    Given ในระบบมีลูกค้าที่ลงทะเบียนแล้ว 3 ราย:
      - สมชาย ใจดี, เลขบัตร 1100100123456, เบอร์ 081-234-5678
      - สมหญิง รักดี, เลขบัตร 1100200654321, เบอร์ 082-345-6789
      - บริษัท เอบีซี จำกัด, เลขทะเบียน 0105562012345, เบอร์ 02-234-5678
    And staff ได้ login แล้วและอยู่หน้า "รายการลูกค้า"

  Scenario: ค้นหาด้วยชื่อ (partial match)
    When staff พิมพ์ "สมชาย" ในช่องค้นหา
    Then ระบบแสดงผลลัพธ์: "สมชาย ใจดี — CUS-2026-000001"
    And ผลลัพธ์ไม่แสดงลูกค้า "สมหญิง รักดี"

  Scenario: ค้นหาด้วยเลขบัตรประชาชน
    When staff พิมพ์ "1100200654321"
    Then ระบบแสดงผลลัพธ์: "สมหญิง รักดี — CUS-2026-000002"

  Scenario: ค้นหาด้วยเบอร์โทร
    When staff พิมพ์ "02-234-5678"
    Then ระบบแสดงผลลัพธ์: "บริษัท เอบีซี จำกัด — CUS-2026-000003"

  Scenario: ค้นหาแล้วไม่พบลูกค้า
    When staff พิมพ์ "xxxxxxxxxx"
    Then ระบบแสดง: "ไม่พบลูกค้าที่ตรงกับ 'xxxxxxxxxx'"
    And ระบบแสดงปุ่ม "ลงทะเบียนลูกค้าใหม่"

  Scenario: ผลลัพธ์มากกว่า 20 รายการ
    Given มีลูกค้าชื่อ "สมชาย" ในระบบ 25 คน
    When staff ค้นหา "สมชาย"
    Then ระบบแสดง 20 รายการแรก
    And แสดง pagination "หน้า 1 จาก 2"
```

---

## Sign-off / การอนุมัติ

| Role | Name | Status | Date |
|------|------|--------|------|
| BA | Orawan Nus | ✅ Approved | 2026-05-15 |
| Business Owner | Head of Credit | ✅ Approved | 2026-05-15 |
| PM | Bovornsak Pan | ✅ Approved | 2026-05-15 |

---

*Document ID: PTL-F001-AC | Version: 1.0.0 | Last updated: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
