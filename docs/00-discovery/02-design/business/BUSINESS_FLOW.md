---
doc_id: "PTL-BF-001"
title: "Business Flow — PT Leasing Backoffice"
project: ptl_leasing
type: design
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "02-design"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Business Flow — PT Leasing Backoffice
# กระบวนการธุรกิจ

> **Version**: 0.1.0 | **Status**: Draft

---

## Overview / ภาพรวม

เอกสารนี้อธิบาย business flow หลักของระบบ PT Leasing Backoffice ครอบคลุมทุก business process ตั้งแต่ต้นจนจบ

---

## Main Business Processes / กระบวนการธุรกิจหลัก

### 1. Contract Creation Flow / กระบวนการสร้างสัญญา

```mermaid
flowchart TD
    A[ลูกค้าติดต่อขอเช่า] --> B[Officer รับเรื่อง]
    B --> C[KYC & Document Collection]
    C --> D{KYC Pass?}
    D -->|ไม่ผ่าน| E[แจ้งลูกค้า - ปฏิเสธ]
    D -->|ผ่าน| F[Credit Assessment]
    F --> G{Credit Score?}
    G -->|ต่ำกว่าเกณฑ์| H[ปฏิเสธ/ขอเพิ่มหลักประกัน]
    G -->|ผ่านเกณฑ์| I[สร้างสัญญา Draft]
    I --> J[ลูกค้าตรวจสอบและเซ็นต์]
    J --> K[Manager อนุมัติสัญญา]
    K --> L{Approved?}
    L -->|ไม่อนุมัติ| M[ส่งกลับแก้ไข]
    M --> I
    L -->|อนุมัติ| N[สัญญา Active]
    N --> O[ส่งมอบสินทรัพย์]
    O --> P[เริ่มคิดค่างวด]
```

---

### 2. Payment Processing Flow / กระบวนการชำระเงิน

```mermaid
flowchart TD
    A[ถึงกำหนดชำระ] --> B[ระบบส่ง notification]
    B --> C[ลูกค้าชำระเงิน]
    C --> D{ช่องทางชำระ}
    D -->|Bank Transfer| E[ตรวจสอบ slip]
    D -->|Auto Debit| F[หักบัญชีอัตโนมัติ]
    D -->|Counter| G[เจ้าหน้าที่บันทึก]
    E & F & G --> H{ชำระครบ?}
    H -->|ใช่| I[อัปเดตสถานะชำระ]
    H -->|ไม่ครบ| J[บันทึกชำระบางส่วน]
    I --> K[ออกใบเสร็จ]
    J --> L[แจ้งเตือนยอดค้างชำระ]
    L --> M{เกินกำหนด?}
    M -->|ไม่เกิน| N[รอรอบถัดไป]
    M -->|เกินกำหนด| O[Escalation Process]
```

---

### 3. Contract Renewal Flow / กระบวนการต่ออายุสัญญา

```mermaid
flowchart TD
    A[สัญญาใกล้หมดอายุ - 60 วัน] --> B[ระบบส่ง renewal notice]
    B --> C[Officer ติดต่อลูกค้า]
    C --> D{ลูกค้าต้องการต่อ?}
    D -->|ไม่ต่อ| E[เตรียม Return Process]
    D -->|ต่อ| F[ประเมิน credit ใหม่]
    F --> G[เสนอเงื่อนไขใหม่]
    G --> H{ลูกค้ายอมรับ?}
    H -->|ไม่ยอมรับ| I[เจรจา / Return]
    H -->|ยอมรับ| J[สร้างสัญญาใหม่]
    J --> K[Manager อนุมัติ]
    K --> L[สัญญาใหม่ Active]
```

---

## Business Rules Summary / สรุปกฎธุรกิจ

*(กรอกรายละเอียดหลังได้รับ requirements จาก stakeholders)*

| Rule ID | Category | Description |
|---------|---------|-------------|
| BR-001 | Contract | สัญญาต้องได้รับ approval จาก Manager ก่อน activate |
| BR-002 | Credit | Credit score ต้องสูงกว่า [threshold] จึงผ่านได้ |
| BR-003 | Payment | Grace period [X] วันหลังครบกำหนด |
| BR-004 | KYC | ต้องมีเอกสาร: บัตรประชาชน, ทะเบียนบ้าน, รายได้ |
| BR-005 | Renewal | ต้องแจ้งลูกค้าล่วงหน้า [X] วันก่อนสัญญาหมด |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
