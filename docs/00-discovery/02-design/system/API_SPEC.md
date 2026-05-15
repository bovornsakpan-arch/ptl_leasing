---
doc_id: "PTL-API-001"
title: "API Specification — PT Leasing"
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

# API Specification / ข้อกำหนด API

> **Version**: 0.1.0 | **Status**: Draft
> Full OpenAPI spec: `/docs/api/openapi.yaml` (สร้างเมื่อ development เริ่ม)

---

## Base URL

```
Production:  https://api.ptleasing.snocko-tech.com/api/v1
Staging:     https://api-staging.ptleasing.snocko-tech.com/api/v1
Development: http://localhost:3000/api/v1
```

---

## Authentication / การ Authentication

ทุก endpoint (ยกเว้น `/auth/*`) ต้องส่ง JWT token ใน Authorization header:

```
Authorization: Bearer <access_token>
```

---

## Endpoints / จุดเชื่อมต่อ

### Authentication

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|--------------|
| POST | `/auth/login` | Login และรับ JWT | No |
| POST | `/auth/logout` | Logout | Yes |
| POST | `/auth/refresh` | Refresh access token | No (refresh token) |
| GET | `/auth/me` | ดูข้อมูล user ปัจจุบัน | Yes |
| POST | `/auth/change-password` | เปลี่ยนรหัสผ่าน | Yes |

---

### Contracts

| Method | Endpoint | Description | Roles |
|--------|----------|-------------|-------|
| GET | `/contracts` | รายการสัญญา (paginated, filterable) | All |
| GET | `/contracts/:id` | รายละเอียดสัญญา | All |
| POST | `/contracts` | สร้างสัญญาใหม่ | OFFICER+ |
| PUT | `/contracts/:id` | แก้ไขสัญญา (draft only) | OFFICER+ |
| POST | `/contracts/:id/submit` | ส่ง draft สัญญาขอ approve | OFFICER+ |
| POST | `/contracts/:id/approve` | อนุมัติสัญญา | MANAGER+ |
| POST | `/contracts/:id/reject` | ปฏิเสธสัญญา | MANAGER+ |
| POST | `/contracts/:id/terminate` | ยกเลิกสัญญา | MANAGER+ |
| GET | `/contracts/:id/payments` | ประวัติการชำระ | All |
| GET | `/contracts/:id/documents` | เอกสารสัญญา | All |

**Example: GET /contracts**

Query Parameters:
```
?page=1&per_page=20&status=active&customer_id=UUID&search=CTR-2026
```

Response:
```json
{
  "success": true,
  "data": [
    {
      "id": "550e8400-...",
      "contract_no": "CTR-2026-000001",
      "customer": { "id": "...", "name": "สมชาย ใจดี" },
      "amount": 500000.00,
      "monthly_installment": 15000.00,
      "status": "active",
      "start_date": "2026-01-01",
      "end_date": "2028-12-31"
    }
  ],
  "pagination": { "page": 1, "per_page": 20, "total": 150, "total_pages": 8 }
}
```

---

### Customers

| Method | Endpoint | Description | Roles |
|--------|----------|-------------|-------|
| GET | `/customers` | รายการลูกค้า | All |
| GET | `/customers/:id` | รายละเอียดลูกค้า | All |
| POST | `/customers` | สร้างลูกค้าใหม่ | OFFICER+ |
| PUT | `/customers/:id` | แก้ไขข้อมูลลูกค้า | OFFICER+ |
| GET | `/customers/:id/contracts` | สัญญาของลูกค้า | All |
| POST | `/customers/:id/kyc` | อัปโหลด KYC documents | OFFICER+ |

---

### Payments

| Method | Endpoint | Description | Roles |
|--------|----------|-------------|-------|
| GET | `/payments` | รายการการชำระเงิน | All |
| POST | `/payments` | บันทึกการชำระเงิน | OFFICER+ |
| GET | `/payments/:id` | รายละเอียดการชำระ | All |
| POST | `/payments/:id/verify` | ยืนยันการชำระ | OFFICER+ |

---

### Reports

| Method | Endpoint | Description | Roles |
|--------|----------|-------------|-------|
| GET | `/reports/overdue` | รายงานสัญญาค้างชำระ | MANAGER+ |
| GET | `/reports/portfolio` | สรุป portfolio | MANAGER+ |
| GET | `/reports/collections` | รายงานการจัดเก็บ | MANAGER+ |
| GET | `/reports/export/:type` | Export รายงาน (xlsx, pdf) | MANAGER+ |

---

## Rate Limiting / การจำกัดอัตราการเรียก

| Endpoint Group | Limit |
|---------------|-------|
| Auth endpoints | 10 requests/minute/IP |
| Regular endpoints | 100 requests/minute/user |
| Export endpoints | 5 requests/minute/user |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
