---
doc_id: "PTL-SEQ-001"
title: "Sequence Diagrams — PT Leasing"
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

# Sequence Diagrams / ผัง Sequence

> **Version**: 0.1.0 | **Status**: Draft

---

## 1. Login Flow

```mermaid
sequenceDiagram
    actor User
    participant Browser
    participant API
    participant DB
    participant Redis

    User->>Browser: กรอก email/password
    Browser->>API: POST /auth/login
    API->>DB: SELECT * FROM users WHERE email = ?
    DB-->>API: user record
    API->>API: bcrypt.compare(password, hash)
    alt Password valid
        API->>API: sign JWT (15min)
        API->>API: generate refresh token
        API->>Redis: SET refresh_token_{userId} = token (TTL: 7d)
        API-->>Browser: 200 { access_token, refresh_token }
        Browser->>Browser: Store tokens
        Browser-->>User: Redirect to dashboard
    else Password invalid
        API-->>Browser: 401 { error: "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง" }
        Browser-->>User: แสดง error message
    end
```

---

## 2. Create Contract Flow

```mermaid
sequenceDiagram
    actor Officer
    participant Browser
    participant API
    participant DB
    participant CreditAPI as Credit Bureau API
    participant Queue

    Officer->>Browser: กรอกข้อมูลสัญญา
    Browser->>API: POST /contracts
    API->>API: Validate input (Joi/Zod)
    API->>DB: Check customer exists & KYC status
    DB-->>API: Customer data
    
    alt KYC not approved
        API-->>Browser: 422 { error: "KYC ยังไม่ผ่านการตรวจสอบ" }
    else KYC approved
        API->>CreditAPI: GET /credit-score/{id_card}
        CreditAPI-->>API: { score: 750 }
        
        alt Credit score below threshold
            API-->>Browser: 422 { error: "เครดิตไม่ผ่านเกณฑ์" }
        else Credit score OK
            API->>DB: INSERT INTO contracts (status='draft')
            DB-->>API: New contract ID
            API->>Queue: Emit 'contract.created' event
            API-->>Browser: 201 { contract_id, contract_no }
            Browser-->>Officer: แสดง success + contract detail
        end
    end
```

---

## 3. Payment Recording Flow

```mermaid
sequenceDiagram
    actor Officer
    participant Browser
    participant API
    participant DB
    participant Queue
    participant EmailSvc as Email Service

    Officer->>Browser: บันทึกการชำระเงิน
    Browser->>API: POST /payments
    API->>DB: Check contract exists & installment due
    DB-->>API: Installment data
    API->>DB: INSERT INTO payments
    DB-->>API: Payment ID
    API->>DB: UPDATE installment status = 'paid'
    
    alt All installments paid
        API->>DB: UPDATE contract status = 'completed'
    end
    
    API->>Queue: Emit 'payment.recorded' event
    Queue->>EmailSvc: Send payment receipt email
    EmailSvc-->>Queue: Email queued
    
    API-->>Browser: 201 { payment_id, receipt_no }
    Browser-->>Officer: แสดง success + ออกใบเสร็จ
```

---

## 4. Contract Approval Flow

```mermaid
sequenceDiagram
    actor Officer
    actor Manager
    participant Browser
    participant API
    participant DB
    participant Queue
    participant EmailSvc

    Officer->>Browser: Submit contract for approval
    Browser->>API: POST /contracts/{id}/submit
    API->>DB: UPDATE contracts SET status = 'pending_approval'
    API->>Queue: Emit 'contract.submitted' event
    Queue->>EmailSvc: Notify manager
    EmailSvc-->>Manager: Email: "มีสัญญารอ approve"
    
    Manager->>Browser: เปิด contract detail
    Browser->>API: GET /contracts/{id}
    API->>DB: SELECT contract + documents
    DB-->>API: Contract detail
    API-->>Browser: Contract data
    Browser-->>Manager: แสดงรายละเอียด
    
    alt Manager approves
        Manager->>Browser: กด Approve
        Browser->>API: POST /contracts/{id}/approve
        API->>DB: UPDATE contracts SET status = 'active'
        API->>Queue: Emit 'contract.approved' event
        Queue->>EmailSvc: Notify officer & customer
        API-->>Browser: 200 { message: "อนุมัติสำเร็จ" }
    else Manager rejects
        Manager->>Browser: กด Reject + ระบุเหตุผล
        Browser->>API: POST /contracts/{id}/reject { reason: "..." }
        API->>DB: UPDATE contracts SET status = 'rejected'
        API->>Queue: Emit 'contract.rejected' event
        Queue->>EmailSvc: Notify officer
        API-->>Browser: 200 { message: "ปฏิเสธแล้ว" }
    end
```

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
