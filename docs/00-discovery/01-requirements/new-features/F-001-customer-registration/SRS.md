---
doc_id: "PTL-F001-SRS"
title: "SRS: Customer Registration"
project: ptl_leasing
type: srs
version: "1.0.0"
status: final
owner: siriporn.san@snocko-tech.com
phase: "02-design"
feature_id: "F-001"
jira_issue: "PTL-101"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "siriporn.san@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_date: "2026-05-15"
based_on_brd: "PTL-F001-BRD v1.0.0"
---

# SRS: Customer Registration
# Software Requirements Specification

> **Feature ID**: F-001 | **Version**: 1.0.0 | **Status**: Final | **Based on BRD**: PTL-F001-BRD v1.0.0

---

## 1. Introduction / บทนำ

เอกสารนี้กำหนดความต้องการซอฟต์แวร์สำหรับ F-001 Customer Registration Feature ของระบบ PT Leasing Backoffice ครอบคลุมทั้ง Functional Requirements และ Non-Functional Requirements

---

## 2. Functional Requirements / ความต้องการเชิงหน้าที่

| Req ID | Description | Priority | Source BRD | Acceptance Criteria Ref |
|--------|-------------|---------|-----------|------------------------|
| FR-001 | ระบบต้องรองรับการลงทะเบียนลูกค้าบุคคลธรรมดา (Individual) พร้อมบันทึก: ชื่อ-นามสกุล, เลขบัตรประชาชน 13 หลัก, วันเดือนปีเกิด, ที่อยู่ปัจจุบัน, ที่อยู่ตามทะเบียนบ้าน, เบอร์โทรศัพท์, อีเมล, ข้อมูลผู้ติดต่อฉุกเฉิน | Must Have | BRD §3, §4 | AC-F001-001 |
| FR-002 | ระบบต้องรองรับการลงทะเบียนลูกค้านิติบุคคล (Juristic Person) พร้อมบันทึก: ชื่อบริษัท/ห้างหุ้นส่วน, เลขทะเบียนนิติบุคคล 13 หลัก, ที่อยู่จดทะเบียน, ชื่อผู้มีอำนาจลงนาม, เลขบัตรประชาชนผู้มีอำนาจ, เบอร์โทรบริษัท, อีเมลบริษัท | Must Have | BRD §3, §4 | AC-F001-002 |
| FR-003 | ระบบต้องตรวจสอบเลขบัตรประชาชน (สำหรับบุคคลธรรมดา) และเลขทะเบียนนิติบุคคล (สำหรับนิติบุคคล) ไม่ให้ซ้ำกับที่มีอยู่ในระบบ — ต้องแสดง error message ทันทีหาก duplicate และห้าม submit | Must Have | BRD BR-001 | AC-F001-003 |
| FR-004 | ระบบต้องรองรับการอัปโหลดเอกสาร KYC ในรูปแบบ PDF, JPG, PNG โดยแต่ละไฟล์ต้องมีขนาดไม่เกิน 10 MB — ระบบต้องตรวจสอบ format และขนาดก่อน upload | Must Have | BRD §4, BR-002, BR-007 | AC-F001-004 |
| FR-005 | ระบบต้องแสดง validation error message แบบ real-time ทันทีเมื่อข้อมูลในฟอร์มไม่ถูกต้อง เช่น เลขบัตรไม่ครบ 13 หลัก, email format ผิด, field บังคับที่ยังว่าง — ต้องระบุ field ที่มีปัญหาชัดเจน | Must Have | BRD §3 | AC-F001-005 |
| FR-006 | ระบบต้องบันทึก audit log สำหรับทุก action ของ staff โดยอัตโนมัติ ได้แก่: สร้างข้อมูลลูกค้า, แก้ไขข้อมูล, อัปโหลดเอกสาร, submit registration, เปิดดูข้อมูล sensitive — บันทึก: user_id, action, timestamp, IP address, ข้อมูลที่เปลี่ยน | Must Have | BRD BR-006 | AC-F001-007 |
| FR-007 | ระบบต้องส่ง email notification ไปยัง Supervisor ที่รับผิดชอบ เมื่อ staff กด Submit registration สำเร็จ — email ต้องระบุ: ชื่อลูกค้า, ประเภทลูกค้า, ผู้ลงทะเบียน, วันเวลา, link ไปยัง registration record | Must Have | BRD §3 | AC-F001-001 |
| FR-008 | ระบบต้องรองรับการค้นหาลูกค้าที่ลงทะเบียนแล้ว ด้วย: ชื่อ-นามสกุล (partial match), เลขบัตรประชาชน, เบอร์โทรศัพท์ — ผลลัพธ์แสดงแบบ paginated, เรียงตาม relevance | Must Have | BRD §3 | AC-F001-006 |
| FR-009 | ระบบต้องตรวจสอบอายุลูกค้าบุคคลธรรมดา — ลูกค้าต้องมีอายุไม่ต่ำกว่า 20 ปีบริบูรณ์ ณ วันลงทะเบียน คำนวณจากวันเกิดที่กรอก | Must Have | BRD BR-005 | AC-F001-005 |
| FR-010 | ระบบต้องรองรับ Approval Workflow — หลัง staff submit, registration อยู่ใน status "Pending Review"; Supervisor สามารถ Approve หรือ Reject พร้อมให้เหตุผล; staff รับ notification ผล | Must Have | BRD BR-004 | AC-F001-001 |
| FR-011 | ระบบต้องแสดงรายการเอกสาร KYC ที่จำเป็นตามประเภทลูกค้า — Individual: บัตรประชาชน + ทะเบียนบ้าน; Juristic: หนังสือรับรองบริษัท + บัตรประชาชนผู้มีอำนาจ + หนังสือมอบอำนาจ (ถ้ามี) | Should Have | BRD BR-002 | AC-F001-002 |

---

## 3. Non-Functional Requirements / ความต้องการที่ไม่ใช่หน้าที่

### 3.1 Performance / ประสิทธิภาพ

| Requirement | Target | Measurement |
|------------|--------|------------|
| Page load time | < 2 วินาที (p95) | Lighthouse / APM |
| API response time | < 500ms (p95) สำหรับ read; < 1s (p95) สำหรับ write | APM |
| File upload time | < 10 วินาที สำหรับไฟล์ 10MB | Frontend timer |
| Search result | < 1 วินาที | API timing |
| Concurrent users | รองรับ ≥ 50 concurrent users โดยไม่เกิน degradation | Load test |

### 3.2 Security / ความปลอดภัย

| Requirement | Description |
|------------|-------------|
| Authentication | ทุก endpoint ต้อง authenticate ด้วย JWT token ก่อน access |
| Authorization | RBAC — เฉพาะ role OFFICER และ MANAGER ที่เข้าถึง customer module ได้ |
| HTTPS | บังคับ HTTPS สำหรับทุก communication |
| Data Encryption | เข้ารหัส sensitive fields (เลขบัตร, เบอร์โทร) at rest ด้วย AES-256 |
| File Storage | เอกสาร KYC เก็บใน private S3 bucket — ไม่สามารถ access โดยตรงผ่าน URL |
| Input Sanitization | Sanitize ทุก input ป้องกัน XSS และ SQL Injection |
| Rate Limiting | 100 requests/minute/user สำหรับ API ทั่วไป |

### 3.3 PDPA Compliance / ความสอดคล้อง PDPA

| Requirement | Description |
|------------|-------------|
| Data Minimization | เก็บเฉพาะข้อมูลที่จำเป็นต่อ leasing process |
| Consent | แสดงข้อความแจ้ง privacy notice ก่อน submit registration |
| Access Control | เฉพาะ staff ที่ได้รับมอบหมายเท่านั้นที่เข้าถึงข้อมูลลูกค้าได้ |
| Data Retention | ข้อมูลลูกค้าเก็บตาม policy ใน DATA_CLASSIFICATION.md |
| Audit Trail | บันทึก log ทุกครั้งที่มีการเข้าถึงข้อมูลส่วนบุคคล |
| Right to Erasure | รองรับการลบข้อมูลลูกค้า (soft delete) เมื่อได้รับ request |

### 3.4 Availability & Reliability / ความพร้อมใช้งาน

| Requirement | Target |
|------------|--------|
| Uptime | ≥ 99.5% (ไม่เกิน ~43 ชั่วโมง downtime/ปี) |
| RTO (Recovery Time Objective) | ≤ 2 ชั่วโมง |
| RPO (Recovery Point Objective) | ≤ 1 ชั่วโมง (database backup interval) |
| Maintenance window | วันเสาร์ 00:00–04:00 |

### 3.5 Usability / ความสะดวกในการใช้งาน

| Requirement | Description |
|------------|-------------|
| Browser support | Chrome ≥ 120, Edge ≥ 120 |
| Language | Thai (primary), English (field labels) |
| Error messages | ข้อความ error เป็นภาษาไทย ชัดเจน บอก field และวิธีแก้ไข |
| Responsive | รองรับ Desktop (1920x1080) และ Tablet (1024x768) |

---

## 4. Constraints / ข้อจำกัด

- ต้องใช้ tech stack ตาม TECH_STACK.md (React frontend, Node.js backend, PostgreSQL)
- ต้อง integrate กับ Auth module (F-AUTH) — ไม่พัฒนา auth เอง
- ต้อง integrate กับ File Storage service (S3/MinIO) ที่ configured ไว้แล้ว
- ต้องออกแบบ API ตาม REST standard ใน API_SPEC.md
- ต้องผ่าน code review และ automated tests ก่อน deploy

---

## 5. Dependencies / การพึ่งพา

| Dependency | Type | Description |
|-----------|------|-------------|
| F-AUTH (Authentication) | Feature dependency | ต้องมี auth module ก่อน — staff ต้อง login ก่อน access |
| File Storage (S3/MinIO) | Infrastructure | เก็บ KYC documents |
| Email Service (SMTP) | Infrastructure | ส่ง notification |
| PostgreSQL Database | Infrastructure | จัดเก็บข้อมูลลูกค้า |

---

## Sign-off / การอนุมัติ

| Role | Name | Status | Date |
|------|------|--------|------|
| SA | Siriporn San | ✅ Approved | 2026-05-15 |
| BA | Orawan Nus | ✅ Approved | 2026-05-15 |
| PM | Bovornsak Pan | ✅ Approved | 2026-05-15 |

---

*Document ID: PTL-F001-SRS | Version: 1.0.0 | Last updated: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
