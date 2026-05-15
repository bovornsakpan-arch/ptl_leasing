---
doc_id: "PTL-API-001"
title: "API Specification — PT Leasing"
project: ptl_leasing
type: design
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

# API Specification / ข้อกำหนด API

> **Version**: 1.0.0 | **Status**: Final
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

## F-001 Customer Registration Endpoints

---

### POST /api/v1/customers — สร้างลูกค้าใหม่

**Description**: ลงทะเบียนลูกค้าใหม่ พร้อม KYC documents ที่อัปโหลดไว้แล้ว

**Auth**: Required | **Roles**: OFFICER, MANAGER

#### Request Body

```json
{
  "customer_type": "INDIVIDUAL",
  "first_name": "สมชาย",
  "last_name": "ใจดี",
  "id_card_no": "1100100123456",
  "date_of_birth": "1985-03-15",
  "address_current": "123 ถ.สุขุมวิท แขวงคลองเตย เขตคลองเตย กรุงเทพฯ 10110",
  "address_registered": "456 ถ.พระราม 4 แขวงสาทร เขตสาทร กรุงเทพฯ 10120",
  "phone": "0812345678",
  "email": "somchai@email.com",
  "emergency_contact_name": "สมหญิง ใจดี",
  "emergency_contact_phone": "0898765432",
  "document_ids": [
    "doc-uuid-001",
    "doc-uuid-002"
  ]
}
```

**Fields สำหรับ JURISTIC customer_type:**

```json
{
  "customer_type": "JURISTIC",
  "company_name": "บริษัท เอบีซี จำกัด",
  "juristic_no": "0105562012345",
  "address_registered": "456 ถ.พระราม 4 กรุงเทพฯ 10110",
  "address_current": "456 ถ.พระราม 4 กรุงเทพฯ 10110",
  "authorized_person_name": "นายวิชาญ สมาร์ท",
  "authorized_person_id_card": "1100200345678",
  "phone": "022345678",
  "email": "info@abc-company.co.th",
  "document_ids": [
    "doc-uuid-003",
    "doc-uuid-004"
  ]
}
```

#### Response — 201 Created

```json
{
  "success": true,
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440001",
    "customer_no": "CUS-2026-000001",
    "customer_type": "INDIVIDUAL",
    "full_name": "สมชาย ใจดี",
    "id_card_no": "110010012****",
    "status": "PENDING_REVIEW",
    "registered_by": {
      "id": "usr-uuid-001",
      "name": "มาลี ทำงาน"
    },
    "created_at": "2026-05-15T10:30:00Z"
  },
  "message": "ส่ง Registration สำเร็จ — รอ Supervisor อนุมัติ"
}
```

#### Error Responses

| Status | Code | Message |
|--------|------|---------|
| 400 | VALIDATION_ERROR | field validation ไม่ผ่าน |
| 409 | DUPLICATE_ID_CARD | เลขบัตรประชาชน 1100100123456 มีในระบบแล้ว (CUS-2026-XXXXX) |
| 409 | DUPLICATE_JURISTIC_NO | เลขทะเบียนนิติบุคคลมีในระบบแล้ว |
| 422 | AGE_BELOW_MINIMUM | ลูกค้าต้องมีอายุไม่ต่ำกว่า 20 ปี |
| 422 | MISSING_KYC_DOCUMENTS | เอกสาร KYC ไม่ครบ: ต้องอัปโหลด ทะเบียนบ้าน |
| 401 | UNAUTHORIZED | กรุณา login ก่อน |
| 403 | FORBIDDEN | ไม่มีสิทธิ์สร้างลูกค้า |

---

### GET /api/v1/customers — ค้นหา/รายการลูกค้า

**Description**: ค้นหาลูกค้าพร้อม pagination รองรับหลาย filter

**Auth**: Required | **Roles**: OFFICER, MANAGER

#### Query Parameters

| Parameter | Type | Required | Description | Example |
|-----------|------|----------|-------------|---------|
| `name` | string | No | ค้นหาด้วยชื่อ/บริษัท (partial match, case-insensitive) | `?name=สมชาย` |
| `id_card` | string | No | ค้นหาด้วยเลขบัตรประชาชน/เลขทะเบียนนิติบุคคล | `?id_card=1100100` |
| `phone` | string | No | ค้นหาด้วยเบอร์โทร (partial match) | `?phone=0812` |
| `customer_type` | string | No | กรอง: INDIVIDUAL หรือ JURISTIC | `?customer_type=INDIVIDUAL` |
| `status` | string | No | กรอง: PENDING_REVIEW, ACTIVE, REJECTED, INACTIVE | `?status=ACTIVE` |
| `page` | integer | No | หน้าที่ต้องการ (default: 1) | `?page=2` |
| `limit` | integer | No | จำนวนต่อหน้า (default: 20, max: 100) | `?limit=50` |

#### Response — 200 OK

```json
{
  "success": true,
  "data": [
    {
      "id": "550e8400-e29b-41d4-a716-446655440001",
      "customer_no": "CUS-2026-000001",
      "customer_type": "INDIVIDUAL",
      "full_name": "สมชาย ใจดี",
      "id_card_no": "110010012****",
      "phone": "0812***678",
      "email": "somchai@email.com",
      "status": "ACTIVE",
      "created_at": "2026-05-15T10:30:00Z"
    },
    {
      "id": "550e8400-e29b-41d4-a716-446655440002",
      "customer_no": "CUS-2026-000002",
      "customer_type": "JURISTIC",
      "full_name": "บริษัท เอบีซี จำกัด",
      "juristic_no": "0105562****",
      "phone": "02-234-5678",
      "email": "info@abc-company.co.th",
      "status": "PENDING_REVIEW",
      "created_at": "2026-05-15T11:00:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 2,
    "total_pages": 1
  }
}
```

---

### GET /api/v1/customers/{id} — ดึงข้อมูลลูกค้า

**Description**: ดึงข้อมูลลูกค้าทั้งหมด รวม documents และ approval history

**Auth**: Required | **Roles**: OFFICER, MANAGER

#### Path Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | UUID | Customer ID (UUID) |

#### Response — 200 OK

```json
{
  "success": true,
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440001",
    "customer_no": "CUS-2026-000001",
    "customer_type": "INDIVIDUAL",
    "first_name": "สมชาย",
    "last_name": "ใจดี",
    "id_card_no": "1100100123456",
    "date_of_birth": "1985-03-15",
    "address_current": "123 ถ.สุขุมวิท แขวงคลองเตย เขตคลองเตย กรุงเทพฯ 10110",
    "address_registered": "456 ถ.พระราม 4 แขวงสาทร เขตสาทร กรุงเทพฯ 10120",
    "phone": "0812345678",
    "email": "somchai@email.com",
    "emergency_contact_name": "สมหญิง ใจดี",
    "emergency_contact_phone": "0898765432",
    "status": "ACTIVE",
    "documents": [
      {
        "id": "doc-uuid-001",
        "document_type": "ID_CARD",
        "file_name": "id_card.jpg",
        "file_size_bytes": 524288,
        "mime_type": "image/jpeg",
        "uploaded_at": "2026-05-15T10:20:00Z",
        "uploaded_by": { "id": "usr-001", "name": "มาลี ทำงาน" }
      }
    ],
    "approval_history": [
      {
        "action": "APPROVED",
        "performed_by": { "id": "usr-002", "name": "สมศักดิ์ หัวหน้า" },
        "performed_at": "2026-05-15T14:00:00Z",
        "notes": null
      }
    ],
    "registered_by": { "id": "usr-001", "name": "มาลี ทำงาน" },
    "created_at": "2026-05-15T10:30:00Z",
    "updated_at": "2026-05-15T14:00:00Z"
  }
}
```

#### Error Responses

| Status | Code | Message |
|--------|------|---------|
| 404 | CUSTOMER_NOT_FOUND | ไม่พบลูกค้า id นี้ |
| 401 | UNAUTHORIZED | กรุณา login ก่อน |

---

### POST /api/v1/customers/{id}/documents — อัปโหลดเอกสาร KYC

**Description**: อัปโหลดเอกสาร KYC สำหรับลูกค้า รองรับ PDF, JPG, PNG ขนาดไม่เกิน 10 MB

**Auth**: Required | **Roles**: OFFICER, MANAGER

**Content-Type**: `multipart/form-data`

#### Path Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | UUID | Customer ID |

#### Form Data Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `file` | File | Yes | ไฟล์เอกสาร (PDF/JPG/PNG, max 10MB) |
| `document_type` | string | Yes | ประเภทเอกสาร: ID_CARD, HOUSE_REGISTRATION, COMPANY_CERTIFICATE, POWER_OF_ATTORNEY, INCOME_STATEMENT, OTHER |

#### Response — 201 Created

```json
{
  "success": true,
  "data": {
    "id": "doc-uuid-005",
    "customer_id": "550e8400-e29b-41d4-a716-446655440001",
    "document_type": "ID_CARD",
    "file_name": "id_card_somchai.jpg",
    "file_size_bytes": 524288,
    "mime_type": "image/jpeg",
    "uploaded_by": { "id": "usr-001", "name": "มาลี ทำงาน" },
    "created_at": "2026-05-15T10:20:00Z"
  },
  "message": "อัปโหลดเอกสารสำเร็จ"
}
```

#### Error Responses

| Status | Code | Message |
|--------|------|---------|
| 400 | FILE_TOO_LARGE | ไฟล์มีขนาด {X} MB เกินขีดจำกัด 10 MB |
| 400 | INVALID_FILE_TYPE | ไม่รองรับไฟล์ประเภท .{ext} — รองรับเฉพาะ PDF, JPG, PNG |
| 400 | MISSING_DOCUMENT_TYPE | กรุณาระบุประเภทเอกสาร |
| 404 | CUSTOMER_NOT_FOUND | ไม่พบลูกค้า id นี้ |

---

### GET /api/v1/customers/{id}/documents — รายการเอกสารของลูกค้า

**Description**: ดึงรายการเอกสาร KYC ทั้งหมดของลูกค้า

**Auth**: Required | **Roles**: OFFICER, MANAGER

#### Response — 200 OK

```json
{
  "success": true,
  "data": [
    {
      "id": "doc-uuid-001",
      "document_type": "ID_CARD",
      "document_type_label": "บัตรประชาชน",
      "file_name": "id_card.jpg",
      "file_size_bytes": 524288,
      "mime_type": "image/jpeg",
      "download_url": "/api/v1/customers/uuid/documents/doc-uuid-001/download",
      "uploaded_at": "2026-05-15T10:20:00Z",
      "uploaded_by": { "id": "usr-001", "name": "มาลี ทำงาน" }
    }
  ]
}
```

---

## Other Endpoints / Endpoints อื่นๆ

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
| File upload endpoints | 20 uploads/minute/user |
| Export endpoints | 5 requests/minute/user |

---

*Document ID: PTL-API-001 | Version: 1.0.0 | อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
