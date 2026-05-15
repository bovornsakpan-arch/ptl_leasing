---
doc_id: "PTL-STORIES-001"
title: "User Stories — PT Leasing"
project: ptl_leasing
type: requirements
version: "1.0.0"
status: final
owner: orawan.nus@snocko-tech.com
phase: "04-breakdown"
feature_id: "F-001"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "orawan.nus@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_date: "2026-05-15"
---

# User Stories / User Stories

> **Version**: 1.0.0 | **Status**: Final | **Feature**: F-001 Customer Registration

---

## Overview / ภาพรวม

เอกสารนี้รวบรวม User Stories ทั้งหมดของโปรเจกต์ PT Leasing จัดกลุ่มตาม Epic
แต่ละ story มีรายละเอียดครบถ้วนสำหรับ development

---

## EPIC-03: Customer Management — F-001 Customer Registration

### US-F001-001: ลงทะเบียนลูกค้าบุคคลธรรมดา

```
As a staff (credit officer)
I want to register a new individual customer through the backoffice system
So that I can process the leasing application and maintain accurate customer records
```

| Field | Value |
|-------|-------|
| **Story ID** | US-F001-001 |
| **Story Points** | 5 |
| **Priority** | Must Have |
| **Sprint** | Sprint 1 |
| **Jira** | PTL-101 |
| **Epic** | EPIC-03 Customer Management |
| **FR Refs** | FR-001, FR-003, FR-005, FR-006, FR-007, FR-009 |
| **AC Ref** | AC-F001-001, AC-F001-003, AC-F001-005 |

**Acceptance Criteria (Summary)**:
- Staff สามารถกรอกข้อมูลบุคคลธรรมดาครบถ้วนและ submit ได้
- ระบบ validate เลขบัตร 13 หลัก, อายุ ≥ 20 ปี, email format
- ระบบตรวจสอบ duplicate เลขบัตรก่อน submit
- ระบบบันทึก audit log เมื่อสร้างลูกค้า
- ระบบส่ง email notification ให้ Supervisor เมื่อ submit สำเร็จ

**Definition of Done**:
- [ ] Unit tests pass (coverage ≥ 80%)
- [ ] Integration test pass
- [ ] Deployed to staging
- [ ] BA UAT sign-off

---

### US-F001-002: ลงทะเบียนลูกค้านิติบุคคล

```
As a staff (credit officer)
I want to register a new juristic customer (company/partnership) through the backoffice system
So that I can process the business leasing application with complete company information
```

| Field | Value |
|-------|-------|
| **Story ID** | US-F001-002 |
| **Story Points** | 5 |
| **Priority** | Must Have |
| **Sprint** | Sprint 1 |
| **Jira** | PTL-102 |
| **Epic** | EPIC-03 Customer Management |
| **FR Refs** | FR-002, FR-003, FR-005, FR-006, FR-007, FR-011 |
| **AC Ref** | AC-F001-002, AC-F001-005 |

**Acceptance Criteria (Summary)**:
- Staff สามารถเลือกประเภทลูกค้าเป็น Juristic และกรอกข้อมูลบริษัทครบ
- ฟอร์มแสดง fields สำหรับนิติบุคคล (ชื่อบริษัท, เลขทะเบียน, ผู้มีอำนาจ)
- ระบบตรวจสอบ duplicate เลขทะเบียนนิติบุคคล
- รายการเอกสาร KYC ที่บังคับถูกต้องสำหรับ Juristic

---

### US-F001-003: อัปโหลดเอกสาร KYC

```
As a staff (credit officer)
I want to upload KYC documents for a customer directly in the system
So that all documents are stored securely in one place and I don't need to send them via email
```

| Field | Value |
|-------|-------|
| **Story ID** | US-F001-003 |
| **Story Points** | 3 |
| **Priority** | Must Have |
| **Sprint** | Sprint 1 |
| **Jira** | PTL-103 |
| **Epic** | EPIC-03 Customer Management |
| **FR Refs** | FR-004, FR-006 |
| **AC Ref** | AC-F001-004 |

**Acceptance Criteria (Summary)**:
- Staff สามารถอัปโหลดไฟล์ PDF, JPG, PNG ได้
- ระบบ validate ขนาดไฟล์ ≤ 10 MB และ file type ก่อน upload
- ระบบแสดง progress bar ระหว่าง upload
- เอกสารเก็บใน secure storage (ไม่สามารถ access โดยตรงผ่าน URL)
- ระบบบันทึก audit log เมื่ออัปโหลดเอกสาร

---

### US-F001-004: ค้นหาลูกค้าด้วยชื่อ/เลขบัตร/เบอร์โทร

```
As a staff (credit officer)
I want to search for existing customers by name, ID card number, or phone number
So that I can quickly find a customer without registering duplicates
```

| Field | Value |
|-------|-------|
| **Story ID** | US-F001-004 |
| **Story Points** | 2 |
| **Priority** | Must Have |
| **Sprint** | Sprint 2 |
| **Jira** | PTL-104 |
| **Epic** | EPIC-03 Customer Management |
| **FR Refs** | FR-008 |
| **AC Ref** | AC-F001-006 |

**Acceptance Criteria (Summary)**:
- Staff สามารถค้นหาด้วย partial name, เลขบัตรเต็ม, เบอร์โทร partial
- ผลลัพธ์แสดงแบบ paginated (20 รายการ/หน้า)
- ถ้าไม่พบ แสดงข้อความพร้อมปุ่มลงทะเบียนใหม่
- ค้นหาเสร็จใน < 1 วินาที

---

### US-F001-005: Supervisor Review และ Approve/Reject Registration

```
As a supervisor (credit manager)
I want to review pending customer registrations and approve or reject them
So that I can ensure all customer information and KYC documents meet our standards before activation
```

| Field | Value |
|-------|-------|
| **Story ID** | US-F001-005 |
| **Story Points** | 5 |
| **Priority** | Must Have |
| **Sprint** | Sprint 2 |
| **Jira** | PTL-105 |
| **Epic** | EPIC-03 Customer Management |
| **FR Refs** | FR-010, FR-006 |
| **AC Ref** | AC-F001-001 (approval part) |

**Acceptance Criteria (Summary)**:
- Supervisor เห็น list ของ registrations ที่ pending review
- Supervisor สามารถดูข้อมูลและเอกสาร KYC ของแต่ละ registration
- Supervisor สามารถ Approve → status เปลี่ยนเป็น ACTIVE
- Supervisor สามารถ Reject พร้อมกรอกเหตุผล → status เปลี่ยนเป็น REJECTED
- Staff ที่ลงทะเบียนได้รับ notification ผลการ review
- ระบบบันทึก audit log สำหรับทุก approve/reject action

---

## Stories สำหรับ Epic อื่น (Placeholder)

### EPIC-01: Authentication & Authorization

*(กรอกหลัง BRD ของ feature ใน epic นี้ได้รับ approval)*

| Story ID | Story | Points | Priority | Sprint | Jira |
|----------|-------|--------|---------|--------|------|
| S-001 | As an employee, I want to login with email/password... | TBD | Must | Sprint 0 | PTL-TBD |
| S-002 | As an employee, I want to stay logged in (refresh token)... | TBD | Should | Sprint 0 | PTL-TBD |
| S-003 | As an admin, I want to manage user roles... | TBD | Must | Sprint 0 | PTL-TBD |

---

### EPIC-02: Contract Management

*(กรอกหลัง design ของ EPIC-02 ได้รับ approval)*

| Story ID | Story | Points | Priority | Sprint | Jira |
|----------|-------|--------|---------|--------|------|
| S-010 | As an officer, I want to create a new contract... | TBD | Must | TBD | PTL-TBD |
| S-011 | As a manager, I want to approve/reject contracts... | TBD | Must | TBD | PTL-TBD |
| S-012 | As an officer, I want to search contracts... | TBD | Must | TBD | PTL-TBD |

---

## Story Status Summary / สรุปสถานะ

| Status | Count |
|--------|-------|
| Ready for Sprint 1 | 3 (US-F001-001, 002, 003) |
| Ready for Sprint 2 | 2 (US-F001-004, 005) |
| Not Started (Other Epics) | TBD |
| **Total (F-001)** | **5** |

---

## Sprint Plan Summary / แผน Sprint

| Sprint | Stories | Story Points | Focus |
|--------|---------|-------------|-------|
| Sprint 1 | US-F001-001, 002, 003 | 13 pts | Customer registration + KYC upload |
| Sprint 2 | US-F001-004, 005 | 7 pts | Search + Approval workflow |

---

## Notes for Dev Team / หมายเหตุสำหรับ Dev

1. **US-F001-001 และ US-F001-002** share backend customer service — ควร develop ไปพร้อมกัน
2. **US-F001-003** ต้อง setup S3/MinIO ก่อน develop — coordinate กับ DevOps
3. **Authentication** ต้องพร้อมก่อน Sprint 1 เริ่ม — depend on F-AUTH module
4. **Database migrations** ต้อง run ก่อน deploy ทุกครั้ง

---

*Document ID: PTL-STORIES-001 | Version: 1.0.0 | อัปเดตล่าสุด: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
