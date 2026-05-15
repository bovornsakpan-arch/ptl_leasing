---
doc_id: "PTL-DS-001"
title: "Data Structure — PT Leasing"
project: ptl_leasing
type: architecture
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
phase: "02-design"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Data Structure / โครงสร้างข้อมูล

> **Version**: 0.1.0 | **Status**: Draft

---

## Overview / ภาพรวม

เอกสารนี้อธิบาย data model หลักของระบบ PT Leasing Backoffice รวมถึง entity relationships

---

## Entity Relationship Diagram / ผัง ER

```mermaid
erDiagram
    USERS {
        uuid id PK
        string email
        string name
        string role
        string status
        timestamp created_at
    }

    CUSTOMERS {
        uuid id PK
        string customer_code
        string name_th
        string name_en
        string id_card
        string phone
        string email
        decimal risk_score
        string kyc_status
        timestamp created_at
    }

    CONTRACTS {
        uuid id PK
        string contract_no
        uuid customer_id FK
        uuid asset_id FK
        uuid officer_id FK
        decimal amount
        decimal monthly_installment
        integer tenor_months
        decimal interest_rate
        date start_date
        date end_date
        string status
        timestamp created_at
    }

    ASSETS {
        uuid id PK
        string asset_code
        string asset_type
        string brand
        string model
        decimal value
        string status
    }

    PAYMENTS {
        uuid id PK
        uuid contract_id FK
        integer installment_no
        date due_date
        date paid_date
        decimal amount_due
        decimal amount_paid
        string status
        string payment_method
    }

    DOCUMENTS {
        uuid id PK
        uuid ref_id FK
        string ref_type
        string doc_type
        string file_name
        string storage_path
        timestamp uploaded_at
    }

    AUDIT_LOGS {
        uuid id PK
        uuid user_id FK
        string action
        string table_name
        uuid record_id
        jsonb old_value
        jsonb new_value
        string ip_address
        timestamp created_at
    }

    USERS ||--o{ CONTRACTS : "handles"
    CUSTOMERS ||--o{ CONTRACTS : "has"
    ASSETS ||--o{ CONTRACTS : "used in"
    CONTRACTS ||--o{ PAYMENTS : "has"
    CONTRACTS ||--o{ DOCUMENTS : "has"
    USERS ||--o{ AUDIT_LOGS : "creates"
```

---

## Table Definitions / นิยามตาราง

### Table: contracts

| Column | Type | Nullable | Default | Description |
|--------|------|---------|---------|-------------|
| id | UUID | NOT NULL | gen_random_uuid() | Primary key |
| contract_no | VARCHAR(20) | NOT NULL | — | รหัสสัญญา (CTR-YYYY-XXXXXX) |
| customer_id | UUID | NOT NULL | — | FK → customers.id |
| asset_id | UUID | NOT NULL | — | FK → assets.id |
| officer_id | UUID | NOT NULL | — | FK → users.id |
| amount | DECIMAL(15,2) | NOT NULL | — | มูลค่าสัญญา |
| monthly_installment | DECIMAL(12,2) | NOT NULL | — | ค่างวดรายเดือน |
| tenor_months | INTEGER | NOT NULL | — | ระยะเวลา (เดือน) |
| interest_rate | DECIMAL(5,4) | NOT NULL | — | อัตราดอกเบี้ยต่อปี |
| start_date | DATE | NOT NULL | — | วันเริ่มต้น |
| end_date | DATE | NOT NULL | — | วันสิ้นสุด |
| status | ENUM | NOT NULL | 'draft' | draft, active, suspended, terminated, expired |
| created_at | TIMESTAMPTZ | NOT NULL | NOW() | — |
| updated_at | TIMESTAMPTZ | NOT NULL | NOW() | — |

**Indexes**:
- `contracts_contract_no_idx` UNIQUE on `contract_no`
- `contracts_customer_id_idx` on `customer_id`
- `contracts_status_idx` on `status`
- `contracts_end_date_idx` on `end_date` (for renewal queries)

---

### Table: customers

*(กรอกรายละเอียด columns ให้ครบหลังได้รับ requirements)*

---

### Table: payments

*(กรอกรายละเอียด columns ให้ครบหลังได้รับ requirements)*

---

## Data Lifecycle / วงจรชีวิตข้อมูล

### Contract Status Transitions

```mermaid
stateDiagram-v2
    [*] --> draft: สร้างสัญญา
    draft --> active: Manager อนุมัติ
    draft --> rejected: Manager ปฏิเสธ
    active --> suspended: ผิดนัดชำระ
    suspended --> active: ชำระหนี้ค้างทั้งหมด
    active --> expired: สัญญาหมดอายุ
    active --> terminated: บอกเลิกสัญญา
    rejected --> [*]
    expired --> [*]
    terminated --> [*]
```

---

## Sensitive Data Fields / Fields ข้อมูลสำคัญ

ข้อมูลเหล่านี้ต้องได้รับการปกป้องพิเศษตาม PDPA:

| Table | Column | Sensitivity | Handling |
|-------|--------|------------|---------|
| customers | id_card | PII - High | Encrypt at rest |
| customers | phone | PII - Medium | Mask in logs |
| customers | email | PII - Medium | Mask in logs |
| customers | bank_account | Financial - High | Encrypt at rest |
| audit_logs | ip_address | PII - Low | Retain 90 days |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
