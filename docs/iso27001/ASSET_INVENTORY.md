---
doc_id: "PTL-ISO-ASSET-001"
title: "Asset Inventory — PT Leasing"
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

# Asset Inventory / ทะเบียนสินทรัพย์

> **Version**: 0.1.0 | **ISO27001:2022 Clause**: A.5.9, A.5.10

---

## Asset Categories / ประเภทสินทรัพย์

| Category | คำอธิบาย |
|---------|---------|
| Data | ข้อมูลและฐานข้อมูล |
| Software | Application, OS, tools |
| Hardware | Servers, network equipment |
| Service | Cloud services, external APIs |
| People | Key personnel |

---

## Asset Inventory Table / ตารางทะเบียนสินทรัพย์

### Data Assets

| Asset ID | Asset Name | Classification | Owner | Location | Backup |
|---------|-----------|---------------|-------|---------|--------|
| DA-001 | Customer Database | C4 - Restricted | SA | PostgreSQL - Cloud DB | Daily encrypted backup |
| DA-002 | Contract Records | C3 - Confidential | SA | PostgreSQL - Cloud DB | Daily encrypted backup |
| DA-003 | Payment History | C3 - Confidential | SA | PostgreSQL - Cloud DB | Daily encrypted backup |
| DA-004 | KYC Documents | C4 - Restricted | SA | Object Storage (S3) | Daily backup |
| DA-005 | Audit Logs | C3 - Confidential | Infra | Centralized log system | 1-year retention |
| DA-006 | Application Source Code | C3 - Confidential | PM | GitHub (private) | Git history |
| DA-007 | API Keys / Secrets | C4 - Restricted | Infra | GitHub Secrets / Vault | Encrypted |
| DA-008 | User Credentials | C4 - Restricted | SA | Database (hashed) | N/A (hashed) |

### Software Assets

| Asset ID | Asset Name | Version | Owner | License | End of Support |
|---------|-----------|---------|-------|---------|---------------|
| SW-001 | Node.js | 20 LTS | Dev | MIT | April 2026+ |
| SW-002 | PostgreSQL | 15 | Infra | PostgreSQL License | Nov 2027 |
| SW-003 | Redis | 7 | Infra | BSD | TBD |
| SW-004 | React | 18 | Dev | MIT | Active |
| SW-005 | Docker | 24 | Infra | Apache 2.0 | Active |
| SW-006 | GitHub Actions | — | Infra | GitHub ToS | Active |
| SW-007 | MkDocs Material | Latest | BA | MIT | Active |

### Service Assets

| Asset ID | Service | Provider | Purpose | SLA | Data Shared |
|---------|---------|---------|---------|-----|------------|
| SV-001 | Cloud Hosting | TBD (AWS/GCP) | Application hosting | 99.9% | Yes — all data |
| SV-002 | GitHub | GitHub/Microsoft | Source control | 99.9% | Source code only |
| SV-003 | Jira | Atlassian | Project tracking | 99.9% | Project data |
| SV-004 | Email Service | SendGrid/SES | Notifications | 99.9% | Customer emails |
| SV-005 | Credit Bureau API | TBD | Credit scoring | 95% | Customer ID card |
| SV-006 | SMS Gateway | TBD | SMS notifications | 95% | Phone numbers |

---

## Asset Review Schedule / ตารางทบทวนสินทรัพย์

- **Quarterly**: ทบทวนและอัปเดตทะเบียน
- **On Change**: อัปเดตเมื่อเพิ่ม/เปลี่ยนสินทรัพย์

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
