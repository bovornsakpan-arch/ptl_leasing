---
doc_id: "PTL-DC-001"
title: "Data Classification — PT Leasing"
project: ptl_leasing
type: security_design
version: "1.0.0"
status: final
owner: siriporn.san@snocko-tech.com
phase: "02-design"
feature_id: "F-001"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "siriporn.san@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_date: "2026-05-15"
---

# Data Classification / การจำแนกประเภทข้อมูล

> **Version**: 1.0.0 | **Status**: Final | **Based on**: ISO27001:2022 Annex A 5.12 | **PDPA**: พ.ร.บ. คุ้มครองข้อมูลส่วนบุคคล พ.ศ. 2562

---

## Classification Levels / ระดับการจำแนก

| Level | ชื่อ | คำอธิบาย |
|-------|------|---------|
| **C1** | Public / สาธารณะ | ข้อมูลที่เปิดเผยได้ เช่น marketing materials |
| **C2** | Internal / ภายใน | ข้อมูลใช้ภายในองค์กร เช่น policies, procedures |
| **C3** | Confidential / ลับ | ข้อมูลลูกค้าและธุรกิจที่ไม่ควรเปิดเผยนอกองค์กร — ต้องการ access control |
| **C4** | Highly Confidential / ลับสูงสุด | ข้อมูล PII sensitive, เอกสาร KYC, ข้อมูลการเงิน ต้องการ encryption + strict access |

---

## F-001: Customer Registration Data Classification

### ข้อมูลลูกค้า (Customer Data) — F-001

| Data Element | Classification | PDPA Category | Handling Required | Access Level |
|-------------|---------------|--------------|------------------|-------------|
| ชื่อ-นามสกุล | **C3 Confidential** | Personal Data | Mask ใน logs, restrict access | OFFICER+ |
| เลขบัตรประชาชน 13 หลัก | **C4 Highly Confidential** | Sensitive Personal Data | Encrypt at rest (AES-256), mask display (xxxxx6789), mask ใน logs | OFFICER+ (ดูได้ครั้งละ 1 audit entry) |
| วันเดือนปีเกิด | **C3 Confidential** | Personal Data | Restrict access, mask ใน logs | OFFICER+ |
| ที่อยู่ปัจจุบัน/ทะเบียนบ้าน | **C3 Confidential** | Personal Data | Restrict access | OFFICER+ |
| เบอร์โทรศัพท์ | **C4 Highly Confidential** | Personal Data | Encrypt at rest, mask display (08x-xxx-x678), mask ใน logs | OFFICER+ |
| อีเมล | **C3 Confidential** | Personal Data | Mask ใน logs | OFFICER+ |
| ข้อมูลผู้ติดต่อฉุกเฉิน | **C3 Confidential** | Personal Data | Restrict access | OFFICER+ |

### เอกสาร KYC (KYC Documents) — F-001

| Data Element | Classification | PDPA Category | Handling Required | Access Level |
|-------------|---------------|--------------|------------------|-------------|
| ไฟล์บัตรประชาชน | **C4 Highly Confidential** | Sensitive Personal Data — รูปถ่าย + เลขบัตร | Encrypted storage (S3 SSE), private bucket, pre-signed URL (expire 15 min) | OFFICER+, audit log บังคับ |
| ไฟล์ทะเบียนบ้าน | **C4 Highly Confidential** | Sensitive Personal Data — ที่อยู่ | Encrypted storage, private bucket | OFFICER+, audit log บังคับ |
| ไฟล์หนังสือรับรองบริษัท | **C4 Highly Confidential** | Personal Data (Juristic) | Encrypted storage, private bucket | OFFICER+, audit log บังคับ |
| ไฟล์บัตรประชาชนผู้มีอำนาจ | **C4 Highly Confidential** | Sensitive Personal Data | Encrypted storage, private bucket | OFFICER+, audit log บังคับ |
| ไฟล์หนังสือมอบอำนาจ | **C4 Highly Confidential** | Personal Data | Encrypted storage, private bucket | OFFICER+, audit log บังคับ |

### ข้อมูลนิติบุคคล (Juristic Data) — F-001

| Data Element | Classification | Handling |
|-------------|---------------|---------|
| ชื่อบริษัท/ห้างหุ้นส่วน | **C3 Confidential** | Restrict access |
| เลขทะเบียนนิติบุคคล | **C3 Confidential** | Restrict access (ข้อมูลสาธารณะแต่ต้อง restrict ใน context ของบริษัท) |
| ที่อยู่จดทะเบียน | **C3 Confidential** | Restrict access |
| ชื่อผู้มีอำนาจลงนาม | **C4 Highly Confidential** | Encrypt at rest, mask ใน logs |
| เลขบัตรผู้มีอำนาจลงนาม | **C4 Highly Confidential** | Encrypt at rest (AES-256), mask display |

### Audit Logs — F-001

| Data Element | Classification | Handling |
|-------------|---------------|---------|
| Audit log entries | **C2 Internal** | Restrict access (Admin+ only), retain 1 year, ไม่สามารถ delete ได้ |
| User action records | **C2 Internal** | Compress และ archive หลัง 1 ปี, retain รวม 3 ปี |

---

## General Data Classification Table

### Customer Data (All Features)

| Data Element | Classification | PDPA Category | Handling |
|-------------|---------------|--------------|---------|
| ชื่อ-นามสกุล | C3 | Personal Data | Mask in logs |
| เลขบัตรประชาชน | C4 | Sensitive Personal Data | Encrypt at rest, mask display |
| วันเดือนปีเกิด | C3 | Personal Data | Restrict access |
| ที่อยู่ | C3 | Personal Data | Restrict access |
| เบอร์โทรศัพท์ | C4 | Personal Data | Encrypt, mask in logs |
| Email | C3 | Personal Data | Mask in logs |
| เลขบัญชีธนาคาร | C4 | Financial Data | Encrypt at rest |
| ข้อมูลรายได้ | C4 | Financial Data | Encrypt, strict access |
| Credit Score | C4 | Financial Data | Encrypt, Manager+ only |
| เอกสาร KYC | C4 | Sensitive Personal Data | Encrypted storage |

### Contract Data

| Data Element | Classification | Handling |
|-------------|---------------|---------|
| รหัสสัญญา | C2 | Normal |
| มูลค่าสัญญา | C3 | Restrict access |
| อัตราดอกเบี้ย | C3 | Restrict access |
| ประวัติการชำระ | C3 | Restrict access |
| เงื่อนไขพิเศษ | C3 | Restrict access |

### System Data

| Data Element | Classification | Handling |
|-------------|---------------|---------|
| User credentials | C4 | Hash (bcrypt), never store plaintext |
| API keys/tokens | C4 | Encrypt, rotate regularly |
| Audit logs | C2 | Restrict access, retain 1 year |
| System config | C3 | Restrict access |

---

## Access Control by Classification / การควบคุมการเข้าถึงตามระดับ

| Classification | Who Can Access | Encryption | Audit Log | F-001 Examples |
|---------------|---------------|-----------|-----------|----------------|
| C1 | Everyone | No | No | — |
| C2 | All employees | No | Optional | Audit log entries |
| C3 | Role-based (OFFICER+) | Optional | Yes | ชื่อลูกค้า, ที่อยู่, email |
| C4 | Role-based + audit log mandatory | Required (AES-256) | Yes, mandatory | เลขบัตร, เบอร์โทร, เอกสาร KYC |

### F-001 Specific Access Rules

| Action | Minimum Role | Audit Log | Notes |
|--------|-------------|-----------|-------|
| ดูรายการลูกค้า | OFFICER | No | แสดง masked data เท่านั้น |
| ดูข้อมูลลูกค้าเต็ม | OFFICER | Yes | บันทึกว่าใครดูเมื่อไหร่ |
| ดูเลขบัตรประชาชนเต็ม | OFFICER | Yes (mandatory) | แสดงได้ครั้งละ 1 ราย, audit ทุกครั้ง |
| ดูไฟล์เอกสาร KYC | OFFICER | Yes (mandatory) | Pre-signed URL หมดอายุ 15 นาที |
| สร้างลูกค้า | OFFICER | Yes | — |
| แก้ไขข้อมูลลูกค้า | OFFICER | Yes | เฉพาะ PENDING_REVIEW status |
| Approve/Reject | MANAGER | Yes | — |
| ลบข้อมูลลูกค้า (soft) | MANAGER | Yes | PDPA Right to Erasure |

---

## Data Retention Policy / นโยบายการเก็บข้อมูล

| Data Type | Retention Period | After Retention | Notes |
|-----------|----------------|----------------|-------|
| ข้อมูลลูกค้า Active | ตลอดระยะ active + 7 ปี | Archive | ตาม PDPA และกฎหมายการเงิน |
| ข้อมูลลูกค้า Inactive/Closed | 10 ปี | Secure delete | ตามกฎหมายธุรกิจ |
| เอกสาร KYC | 5 ปีหลังสัญญาสุดท้ายสิ้นสุด | Secure delete + บันทึกการลบ | PDPA compliant |
| Audit logs | 1 ปี (active) | Archive 3 ปี แล้ว delete | ISO27001 compliance |
| Registration ที่ Rejected | 1 ปี | Secure delete | — |
| User access logs | 90 วัน | Delete | — |

---

## PDPA Compliance Summary / สรุปความสอดคล้อง PDPA

| PDPA Requirement | Implementation |
|-----------------|----------------|
| Lawful basis for processing | Contractual necessity (leasing application) |
| Privacy notice | แสดงก่อน submit registration form |
| Data minimization | เก็บเฉพาะ fields ที่จำเป็นสำหรับ leasing process |
| Access control | RBAC — เฉพาะผู้ได้รับมอบหมาย |
| Data subject rights | รองรับ: right to access, right to erasure (soft delete) |
| Data breach notification | ต้องแจ้งภายใน 72 ชั่วโมง (procedure แยกต่างหาก) |
| Cross-border transfer | ไม่มี — data เก็บในประเทศไทย |

---

*Document ID: PTL-DC-001 | Version: 1.0.0 | อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
