---
doc_id: "PTL-EPICS-001"
title: "Epics — PT Leasing Backoffice"
project: ptl_leasing
type: requirements
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "01-requirements"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Epics — PT Leasing Backoffice
# รายการ Epic ทั้งหมดของโปรเจกต์

> **Version**: 0.1.0 | **Status**: Draft | **อัปเดตล่าสุด**: 2026-05-15

---

## Overview / ภาพรวม

เอกสารนี้รวบรวม Epics ทั้งหมดสำหรับระบบ PT Leasing Backoffice
แต่ละ Epic ประกอบด้วยหลาย Features ที่เกี่ยวข้องกัน

---

## Epic List / รายการ Epic

| Epic ID | ชื่อ Epic | Description | Priority | Status | Features |
|---------|-----------|-------------|---------|--------|---------|
| EPIC-01 | Authentication & Authorization | ระบบ login, role management, permissions | Must | Planning | F-001, F-002 |
| EPIC-02 | Contract Management | สร้าง, แก้ไข, ดูสัญญาเช่า | Must | Planning | - |
| EPIC-03 | Customer Management | จัดการข้อมูลลูกค้า, KYC | Must | Planning | - |
| EPIC-04 | Payment Processing | ประมวลการชำระเงิน, งวด, ใบเสร็จ | Must | Planning | - |
| EPIC-05 | Credit Assessment | ประเมินเครดิตลูกค้า | Must | Planning | - |
| EPIC-06 | Document Management | จัดการเอกสารสัญญา, upload, download | Should | Planning | - |
| EPIC-07 | Reporting & Analytics | รายงาน, dashboard, export | Should | Planning | - |
| EPIC-08 | Notification System | Email, SMS notifications | Should | Planning | - |
| EPIC-09 | Admin & Configuration | ตั้งค่าระบบ, จัดการ users | Must | Planning | - |
| EPIC-10 | Audit & Compliance | Audit log, compliance reports | Must | Planning | - |

---

## Epic Details / รายละเอียด Epic

### EPIC-01: Authentication & Authorization

**Goal**: ระบบ authentication ที่ปลอดภัยและ role-based access control

**Key Features**:
- Login/Logout
- Role management (Admin, Manager, Officer, Viewer)
- Permission matrix
- Session management
- Password policy

**Business Value**: ควบคุมการเข้าถึงระบบ ปกป้องข้อมูลลูกค้าและสัญญา

**Jira Epic**: PTL-EPIC-01

---

### EPIC-02: Contract Management

**Goal**: จัดการสัญญาเช่าตลอด lifecycle ตั้งแต่สร้างจนปิด

**Key Features**:
- สร้างสัญญาใหม่
- แก้ไขสัญญา
- ดูรายละเอียดสัญญา
- ค้นหาและกรองสัญญา
- ต่ออายุสัญญา
- ยกเลิกสัญญา

**Business Value**: หัวใจหลักของธุรกิจ — ทุก revenue ผ่าน contract

**Jira Epic**: PTL-EPIC-02

---

### EPIC-03: Customer Management

**Goal**: บริหารข้อมูลลูกค้าและ KYC

**Key Features**:
- ลงทะเบียนลูกค้าใหม่
- KYC document verification
- ดูประวัติลูกค้า
- Blacklist management

**Business Value**: ลดความเสี่ยงจากลูกค้าที่ไม่มีคุณภาพ compliance กับ AML/KYC

**Jira Epic**: PTL-EPIC-03

---

*(เพิ่ม Epic ใหม่โดยใช้ format ด้านบน)*

---

## Feature Status Summary / สรุปสถานะ Features

| Epic | Total Features | In Progress | Done | Not Started |
|------|--------------|-------------|------|-------------|
| EPIC-01 | 0 | 0 | 0 | 0 |
| EPIC-02 | 0 | 0 | 0 | 0 |
| EPIC-03 | 0 | 0 | 0 | 0 |
| EPIC-04 | 0 | 0 | 0 | 0 |
| **รวม** | **0** | **0** | **0** | **0** |

---

*เอกสารนี้จัดการโดย BA: orawan.nus@snocko-tech.com*
