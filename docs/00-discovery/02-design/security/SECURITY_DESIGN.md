---
doc_id: "PTL-SEC-001"
title: "Security Design — PT Leasing"
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

# Security Design / การออกแบบด้านความปลอดภัย

> **Version**: 0.1.0 | **Status**: Draft
> ดู ISO27001 docs ที่ [docs/iso27001/](../../iso27001/)

---

## Security Objectives / วัตถุประสงค์ด้านความปลอดภัย

1. **Confidentiality**: ข้อมูลลูกค้าและสัญญาเข้าถึงได้เฉพาะผู้มีสิทธิ์
2. **Integrity**: ข้อมูลต้องถูกต้องและไม่ถูกแก้ไขโดยไม่ได้รับอนุญาต
3. **Availability**: ระบบต้องพร้อมใช้งาน 99.5% uptime
4. **Non-repudiation**: ทุกการกระทำมี audit log ที่ตรวจสอบได้

---

## Authentication & Authorization / การยืนยันตัวตนและการอนุญาต

### Authentication
- JWT Access Token: expire 15 นาที
- Refresh Token: expire 7 วัน (stored in Redis)
- Password policy: ≥ 8 characters, must contain uppercase, lowercase, number, special char
- Failed login: lock account หลัง 5 ครั้งใน 15 นาที
- MFA: Optional (recommended สำหรับ MANAGER+)

### Authorization
- RBAC: Role-Based Access Control
- Least privilege principle
- Permission check ทุก API endpoint
- ดูรายละเอียดใน [DATA_CLASSIFICATION.md](DATA_CLASSIFICATION.md)

---

## Data Protection / การปกป้องข้อมูล

### In Transit
- HTTPS/TLS 1.2+ สำหรับทุก connection
- HSTS header
- No sensitive data in URL parameters

### At Rest
- Encrypt PII fields: id_card, bank_account, phone
- Algorithm: AES-256-GCM
- Key management: Environment variables / AWS KMS

### PDPA Compliance
- Consent management สำหรับ data collection
- Right to erasure: soft delete + encrypt
- Data retention policy: [X] ปี
- ดูรายละเอียดใน [DPIA.md](DPIA.md)

---

## OWASP Top 10 Mitigations / การป้องกัน OWASP Top 10

| # | Vulnerability | Mitigation |
|---|--------------|-----------|
| 1 | Broken Access Control | RBAC middleware ทุก endpoint |
| 2 | Cryptographic Failures | TLS, encrypt PII, no MD5/SHA1 |
| 3 | Injection (SQL, XSS) | Parameterized queries, input sanitization |
| 4 | Insecure Design | Security review in SDLC process |
| 5 | Security Misconfiguration | IaC, hardening scripts, no debug in prod |
| 6 | Vulnerable Components | npm audit, Snyk, dependency updates |
| 7 | Authentication Failures | JWT, MFA, account lockout |
| 8 | Software & Data Integrity | Code signing, checksum verification |
| 9 | Logging & Monitoring | Centralized logging, alerts |
| 10 | SSRF | Input validation, allowlist for URLs |

---

## Security Monitoring / การติดตามด้านความปลอดภัย

- Failed login attempts: Alert เมื่อ > 10 ต่อนาที
- Unauthorized access attempts: Alert ทุกครั้ง
- Data export > 1000 records: Alert และ require approval
- Audit log retention: 1 ปี

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
