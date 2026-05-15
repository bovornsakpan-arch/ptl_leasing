---
doc_id: "PTL-FXXX-AC"
title: "Acceptance Criteria: [Feature Name]"
project: ptl_leasing
type: acceptance_criteria
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "04-breakdown"
feature_id: "F-XXX"
jira_issue: "PTL-XXX"
created_at: "YYYY-MM-DD"
updated_at: "YYYY-MM-DD"
reviewed_by: ""
approved_by: ""
---

# Acceptance Criteria: [Feature Name]
# เกณฑ์การยอมรับ

> **Feature ID**: F-XXX | **Version**: 0.1.0

---

## Overview / ภาพรวม

เอกสารนี้กำหนด Acceptance Criteria สำหรับ [Feature Name] ใช้รูปแบบ Given/When/Then (Gherkin)
เพื่อให้ทีม Dev, QA และ Business Owner เข้าใจตรงกัน

---

## Feature Description / คำอธิบาย Feature

*(สรุปสั้น ๆ ว่า feature นี้ทำอะไร — ดูรายละเอียดใน BRD.md)*

---

## Acceptance Criteria / เกณฑ์การยอมรับ

### AC-F-XXX-001: [Scenario Name — Happy Path]

**As a** [ประเภทผู้ใช้]
**I want to** [action]
**So that** [benefit]

**Scenario**: [ชื่อ scenario ที่อธิบายตรง ๆ]

```gherkin
Given [สถานการณ์เริ่มต้น / precondition]
  And [เงื่อนไขเพิ่มเติม]
When [action ที่ผู้ใช้ทำ]
  And [action เพิ่มเติม]
Then [ผลลัพธ์ที่คาดหวัง]
  And [ผลลัพธ์เพิ่มเติม]
```

**Test Notes**: *(ข้อมูลเพิ่มเติมสำหรับ QA)*

---

### AC-F-XXX-002: [Scenario Name — Validation]

**Scenario**: ตรวจสอบ input validation

```gherkin
Given ผู้ใช้อยู่ที่หน้า [page name]
When ผู้ใช้กรอก [field] ด้วยค่า [invalid value]
  And กดปุ่ม Submit
Then ระบบแสดง error message "[Error message text]"
  And ระบบไม่บันทึกข้อมูล
  And cursor อยู่ที่ field ที่ error
```

---

### AC-F-XXX-003: [Scenario Name — Error Handling]

**Scenario**: จัดการ error กรณีระบบขัดข้อง

```gherkin
Given ผู้ใช้กำลังทำ [action]
When ระบบ backend ไม่ตอบสนอง (timeout)
Then ระบบแสดง error message ที่เป็นมิตร
  And มีปุ่ม Retry
  And ไม่สูญเสียข้อมูลที่กรอกไว้
```

---

### AC-F-XXX-004: [Scenario Name — Permission/Authorization]

**Scenario**: ตรวจสอบสิทธิ์การเข้าถึง

```gherkin
Given ผู้ใช้ที่มี role [role X] login อยู่
When ผู้ใช้พยายามเข้าถึง [restricted resource]
Then ระบบแสดงหน้า "ไม่มีสิทธิ์เข้าถึง" (403)
  And บันทึก audit log การพยายามเข้าถึง
```

---

### AC-F-XXX-005: [Scenario Name — Performance]

**Scenario**: ตรวจสอบ performance

```gherkin
Given มีข้อมูล 10,000 records ในระบบ
When ผู้ใช้ค้นหาข้อมูลด้วย filter
Then ระบบแสดงผลลัพธ์ภายใน 2 วินาที
  And แสดงข้อมูลครบถ้วนตาม filter
  And Pagination ทำงานถูกต้อง
```

---

## Test Scenarios Summary Table / ตารางสรุป Test Scenarios

| AC ID | Scenario | Type | Priority | Status | Notes |
|-------|----------|------|---------|--------|-------|
| AC-F-XXX-001 | [Happy path] | Functional | High | Draft | |
| AC-F-XXX-002 | [Validation] | Functional | High | Draft | |
| AC-F-XXX-003 | [Error handling] | Functional | Medium | Draft | |
| AC-F-XXX-004 | [Authorization] | Security | High | Draft | |
| AC-F-XXX-005 | [Performance] | Performance | Medium | Draft | |

**Scenario Types**: Functional / Security / Performance / Usability / Regression

---

## Out of Scope for Testing / ไม่รวมในการทดสอบรอบนี้

*(สิ่งที่ไม่ทดสอบในรอบนี้ พร้อมเหตุผล)*
- X: จะทดสอบใน regression suite ภายหลัง
- Y: เป็น infrastructure concern ไม่ใช่ feature concern

---

## Sign-off / การยืนยัน

| Role | Name | Email | Status | Date |
|------|------|-------|--------|------|
| BA | Orawan Nus | orawan.nus@snocko-tech.com | Pending | |
| Business Owner | | | Pending | |
| PM | Bovornsak Pan | bovornsak.pan@snocko-tech.com | Pending | |

---

*เอกสารนี้สร้างโดย PT Leasing SDLC Framework — templates/ACCEPTANCE_CRITERIA.template.md*
