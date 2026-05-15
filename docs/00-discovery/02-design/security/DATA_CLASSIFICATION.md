---
doc_id: "PTL-DC-001"
title: "Data Classification — PT Leasing"
project: ptl_leasing
type: security_design
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
phase: "02-design"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Data Classification / การจำแนกประเภทข้อมูล

> **Version**: 0.1.0 | **Based on**: ISO27001:2022 Annex A 5.12

---

## Classification Levels / ระดับการจำแนก

| Level | ชื่อ | คำอธิบาย |
|-------|------|---------|
| **C1** | Public / สาธารณะ | ข้อมูลที่เปิดเผยได้ เช่น marketing materials |
| **C2** | Internal / ภายใน | ข้อมูลใช้ภายในองค์กร เช่น policies |
| **C3** | Confidential / ลับ | ข้อมูลธุรกิจที่ไม่ควรเปิดเผยนอกองค์กร |
| **C4** | Restricted / ลับมาก | ข้อมูล PII, ข้อมูลการเงิน ต้องการ encryption |

---

## Data Classification Table / ตารางจำแนกข้อมูล

### Customer Data

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
| Audit logs | C3 | Restrict access, retain 1 year |
| System config | C3 | Restrict access |

---

## Access Control by Classification / การควบคุมการเข้าถึงตามระดับ

| Classification | Who Can Access | Encryption | Audit Log |
|---------------|---------------|-----------|-----------|
| C1 | Everyone | No | No |
| C2 | All employees | No | Optional |
| C3 | Role-based (OFFICER+) | Optional | Yes |
| C4 | Role-based (MANAGER+ for financial) | Required | Yes, mandatory |

---

## Data Retention Policy / นโยบายการเก็บข้อมูล

| Data Type | Retention Period | After Retention |
|-----------|----------------|----------------|
| Active contracts | Duration + 7 years | Archive |
| Closed contracts | 10 years | Secure delete |
| Payment records | 10 years | Archive |
| KYC documents | 5 years after contract end | Secure delete |
| Audit logs | 1 year | Archive (3 years) |
| User access logs | 90 days | Delete |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
