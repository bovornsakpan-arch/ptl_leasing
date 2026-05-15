---
doc_id: "PTL-SF-001"
title: "System Flow — PT Leasing"
project: ptl_leasing
type: design
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
phase: "02-design"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# System Flow / ระบบ Flow

> **Version**: 0.1.0 | **Status**: Draft

---

## Overview / ภาพรวม

เอกสารนี้อธิบาย system flow หลักจากมุมมองของระบบ (ไม่ใช่ผู้ใช้)

---

## Main System Flows / System Flow หลัก

### 1. Request Processing Flow

```mermaid
flowchart TD
    A[HTTP Request] --> B[Nginx Reverse Proxy]
    B --> C[Rate Limiter]
    C --> D{Rate Limit OK?}
    D -->|เกินกำหนด| E[429 Too Many Requests]
    D -->|ผ่าน| F[Auth Middleware]
    F --> G{Token Valid?}
    G -->|ไม่ valid| H[401 Unauthorized]
    G -->|valid| I[Permission Check]
    I --> J{Has Permission?}
    J -->|ไม่มีสิทธิ์| K[403 Forbidden]
    J -->|มีสิทธิ์| L[Input Validation]
    L --> M{Valid Input?}
    M -->|ไม่ valid| N[400/422 Validation Error]
    M -->|valid| O[Business Logic]
    O --> P[Database Operation]
    P --> Q[Audit Log]
    Q --> R[Response]
```

---

### 2. Notification System Flow

```mermaid
flowchart TD
    A[Business Event] --> B[Event Queue]
    B --> C{Event Type}
    C -->|contract.approved| D[Contract Approved Handler]
    C -->|payment.due| E[Payment Due Handler]
    C -->|contract.expiring| F[Expiring Handler]
    C -->|payment.overdue| G[Overdue Handler]
    D & E & F & G --> H[Notification Builder]
    H --> I{Channel}
    I -->|Email| J[Email Service]
    I -->|SMS| K[SMS Gateway]
    J & K --> L[Log Notification]
    L --> M{Success?}
    M -->|ไม่สำเร็จ| N[Retry Queue]
    N --> O{Retry < 3?}
    O -->|ใช่| B
    O -->|เกิน| P[Dead Letter Queue]
    P --> Q[Alert Operations]
```

---

### 3. Document Upload Flow

```mermaid
flowchart TD
    A[User Uploads Document] --> B[Validate file type/size]
    B --> C{Valid?}
    C -->|ไม่ valid| D[Return error]
    C -->|valid| E[Scan for malware]
    E --> F{Safe?}
    F -->|ไม่ปลอดภัย| G[Reject file]
    F -->|ปลอดภัย| H[Upload to S3/MinIO]
    H --> I[Generate signed URL]
    I --> J[Save metadata to DB]
    J --> K[Return file URL]
```

---

### 4. Report Generation Flow

```mermaid
flowchart TD
    A[Report Request] --> B{Complex Report?}
    B -->|เล็ก: < 1000 rows| C[Process Synchronously]
    B -->|ใหญ่: > 1000 rows| D[Queue Background Job]
    C --> E[Query DB]
    E --> F[Format Data]
    F --> G[Return Response]
    D --> H[Notify User: "กำลังประมวล..."]
    H --> I[Worker Processes Job]
    I --> J[Query DB paginated]
    J --> K[Generate Excel/PDF]
    K --> L[Upload to S3]
    L --> M[Email Link to User]
```

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
