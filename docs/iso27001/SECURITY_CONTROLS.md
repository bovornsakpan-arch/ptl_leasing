---
doc_id: "PTL-ISO-CTRL-001"
title: "Security Controls — ISO27001:2022 Annex A"
project: ptl_leasing
type: security_design
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Security Controls / มาตรการความปลอดภัย

> **ISO27001:2022 Annex A Controls Mapping**
> แสดงเฉพาะ controls ที่ applicable สำหรับ PT Leasing Backoffice (internal backoffice system)

---

## Control Status Legend
- **Implemented**: ดำเนินการแล้ว
- **Planned**: วางแผนแล้ว รอ implement
- **Not Applicable**: ไม่เกี่ยวข้อง
- **Accepted Risk**: ยอมรับความเสี่ยง (พร้อมเหตุผล)

---

## A.5: Organizational Controls / มาตรการองค์กร

| Control | Description | Status | Notes |
|---------|-------------|--------|-------|
| A.5.1 | Information security policy | Planned | ต้องสร้าง IS policy |
| A.5.2 | Information security roles | Planned | กำหนดใน config/roles.yaml |
| A.5.10 | Acceptable use of assets | Planned | IT acceptable use policy |
| A.5.12 | Classification of information | Planned | ดู DATA_CLASSIFICATION.md |
| A.5.15 | Access control | Implemented | RBAC ใน application |
| A.5.17 | Authentication information | Implemented | JWT + bcrypt + MFA option |
| A.5.23 | Information security for cloud services | Planned | Cloud security checklist |
| A.5.36 | Compliance with policies | Planned | Audit schedule |

---

## A.6: People Controls / มาตรการด้านบุคลากร

| Control | Description | Status | Notes |
|---------|-------------|--------|-------|
| A.6.1 | Screening (background check) | Not Applicable | HR policy |
| A.6.2 | Terms and conditions of employment | Not Applicable | HR/Legal |
| A.6.3 | Information security awareness | Planned | Annual training program |
| A.6.4 | Disciplinary process | Not Applicable | HR policy |
| A.6.5 | Responsibilities after termination | Planned | Account revocation SLA: same day |

---

## A.7: Physical Controls / มาตรการทางกายภาพ

| Control | Description | Status | Notes |
|---------|-------------|--------|-------|
| A.7.1 | Physical security perimeters | Implemented | Cloud provider (AWS/GCP) handles |
| A.7.8 | Equipment siting and protection | Not Applicable | Cloud hosted |
| A.7.13 | Equipment maintenance | Not Applicable | Cloud hosted |

---

## A.8: Technological Controls / มาตรการด้านเทคโนโลยี

| Control | Description | Status | Notes |
|---------|-------------|--------|-------|
| A.8.1 | User endpoint devices | Planned | Device policy for dev laptops |
| A.8.2 | Privileged access rights | Implemented | RBAC, admin accounts separate |
| A.8.3 | Information access restriction | Implemented | RBAC + data classification |
| A.8.4 | Access to source code | Implemented | GitHub branch protection |
| A.8.5 | Secure authentication | Implemented | JWT, MFA available |
| A.8.6 | Capacity management | Planned | Monitoring + auto-scaling |
| A.8.7 | Protection against malware | Planned | WAF, dependency scanning |
| A.8.8 | Management of technical vulnerabilities | Planned | Snyk, monthly patches |
| A.8.9 | Configuration management | Planned | IaC, config as code |
| A.8.10 | Information deletion | Planned | Data retention policy |
| A.8.11 | Data masking | Implemented | PII masking in logs |
| A.8.12 | Data leakage prevention | Planned | DLP controls |
| A.8.15 | Logging | Implemented | Winston, centralized logs |
| A.8.16 | Monitoring activities | Planned | APM + security monitoring |
| A.8.17 | Clock synchronization | Implemented | NTP on all servers |
| A.8.20 | Networks security | Implemented | VPC, security groups, WAF |
| A.8.21 | Security of network services | Implemented | TLS 1.2+, HTTPS only |
| A.8.24 | Use of cryptography | Implemented | AES-256, bcrypt, TLS |
| A.8.25 | Secure development lifecycle | Planned | This SDLC framework |
| A.8.28 | Secure coding | Planned | Coding guidelines, SAST |
| A.8.29 | Security testing in development | Planned | OWASP ZAP, pen testing |
| A.8.33 | Test information | Planned | Anonymized test data |
| A.8.34 | Protection of information systems during audit testing | Planned | Staging environment policy |

---

## Compliance Summary

| Category | Total Controls | Implemented | Planned | N/A |
|---------|--------------|-------------|---------|-----|
| Organizational (A.5) | 8 | 3 | 5 | 0 |
| People (A.6) | 5 | 0 | 2 | 3 |
| Physical (A.7) | 3 | 1 | 0 | 2 |
| Technological (A.8) | 20 | 8 | 10 | 2 |
| **Total** | **36** | **12** | **17** | **7** |
| **% Implemented** | | **33%** | | |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
