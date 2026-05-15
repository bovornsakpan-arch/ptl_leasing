---
doc_id: "PTL-BF-001"
title: "Business Flow — PT Leasing Backoffice"
project: ptl_leasing
type: design
version: "1.0.0"
status: final
owner: orawan.nus@snocko-tech.com
phase: "02-design"
feature_id: "F-001"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "orawan.nus@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_date: "2026-05-15"
---

# Business Flow — PT Leasing Backoffice
# กระบวนการธุรกิจ

> **Version**: 1.0.0 | **Status**: Final | **Feature**: F-001 Customer Registration

---

## Overview / ภาพรวม

เอกสารนี้อธิบาย business flow หลักของระบบ PT Leasing Backoffice ครอบคลุมทุก business process ตั้งแต่ต้นจนจบ

---

## F-001: Customer Registration Flow / กระบวนการลงทะเบียนลูกค้า

### To-Be Process (Web Backoffice System)

```mermaid
flowchart TD
    A([Staff รับใบสมัครจากลูกค้า]) --> B[เปิดระบบ PT Leasing Backoffice]
    B --> C[เลือกเมนู ลงทะเบียนลูกค้าใหม่]
    C --> D{เลือกประเภทลูกค้า}
    D -->|บุคคลธรรมดา| E1[กรอกข้อมูลส่วนตัว\nชื่อ-สกุล, เลขบัตร, วันเกิด\nที่อยู่, เบอร์โทร, email]
    D -->|นิติบุคคล| E2[กรอกข้อมูลบริษัท\nชื่อบริษัท, เลขทะเบียน\nที่อยู่จดทะเบียน, ผู้มีอำนาจ]
    E1 --> F{ระบบตรวจสอบเลขบัตร\nซ้ำในระบบ?}
    E2 --> F
    F -->|ซ้ำ| G[แสดง Error — ลูกค้ามีในระบบแล้ว\nระบุ Customer ID ที่มีอยู่]
    G --> H{Staff ต้องการดู\nข้อมูลเดิม?}
    H -->|ใช่| I[นำทางไปหน้าลูกค้าที่มีอยู่]
    H -->|ไม่| B
    F -->|ไม่ซ้ำ| J[อัปโหลดเอกสาร KYC\nตามประเภทลูกค้า]
    J --> K{เอกสารครบและ\nขนาดไม่เกิน 10MB?}
    K -->|ไม่ครบ/ผิด format| L[แสดง validation error\nระบุเอกสารที่ขาด]
    L --> J
    K -->|ครบ| M[ตรวจสอบข้อมูลทั้งหมด\nReview Summary]
    M --> N{ข้อมูลถูกต้องครบถ้วน?}
    N -->|ไม่| O[แก้ไขข้อมูล]
    O --> M
    N -->|ใช่| P[กดปุ่ม Submit Registration]
    P --> Q[ระบบแสดง Confirmation Dialog]
    Q --> R{Staff ยืนยัน?}
    R -->|ยกเลิก| M
    R -->|ยืนยัน| S[ระบบบันทึกข้อมูลลูกค้า\nสร้าง Customer ID]
    S --> T[ระบบส่ง Email Notification\nให้ Supervisor]
    T --> U[ระบบบันทึก Audit Log]
    U --> V[Registration Status = Pending Review]
    V --> W([Staff รับ Customer ID\nรอ Supervisor อนุมัติ])

    W --> X{Supervisor Review}
    X -->|Approve| Y[Status = Active\nส่ง notification ให้ Staff]
    X -->|Reject| Z[Status = Rejected\nระบุเหตุผล + ส่ง notification]
    Z --> AA[Staff แก้ไขและ Submit ใหม่]
    AA --> P
```

---

### As-Is Process (Excel/กระดาษ) vs To-Be Process (Web System)

| ขั้นตอน | As-Is (ปัจจุบัน) | To-Be (ระบบใหม่) | ประโยชน์ที่ได้ |
|--------|-----------------|-----------------|--------------|
| รับข้อมูลลูกค้า | Staff กรอก Excel template | กรอกฟอร์มใน Web UI | Real-time validation |
| ตรวจสอบข้อมูลซ้ำ | ค้นหา manual ใน Excel | ระบบตรวจสอบอัตโนมัติ | ป้องกัน duplicate 100% |
| รับเอกสาร KYC | รับเป็น hardcopy หรือ email attachment | อัปโหลดใน web form | ไม่สูญหาย, เข้าถึงได้ทุกที่ |
| ส่งให้ Supervisor | ส่ง email พร้อม attachment | Submit ผ่าน workflow | Track status ได้ real-time |
| Supervisor Review | Reply email | Approve/Reject ในระบบ | Audit trail ครบถ้วน |
| บันทึก Audit | ไม่มี | อัตโนมัติทุก action | PDPA compliance |
| เวลาเฉลี่ย | 30 นาที/ราย | ≤ 10 นาที/ราย | ลดเวลา 67% |

---

### Supervisor Approval Sub-Flow

```mermaid
flowchart TD
    A([Supervisor รับ email notification]) --> B[เปิดระบบ Backoffice]
    B --> C[เข้าเมนู Pending Registrations]
    C --> D[เลือก registration ที่ต้องการ review]
    D --> E[ตรวจสอบข้อมูลลูกค้า]
    E --> F[ตรวจสอบเอกสาร KYC]
    F --> G{ข้อมูลครบถ้วน\nถูกต้อง?}
    G -->|ไม่ผ่าน| H[กด Reject\nกรอกเหตุผล]
    G -->|ผ่าน| I[กด Approve]
    H --> J[ระบบอัปเดต Status = Rejected]
    I --> K[ระบบอัปเดต Status = Active]
    J --> L[ส่ง notification ให้ Staff ที่ลงทะเบียน]
    K --> L
    L --> M([End])
```

---

## Main Business Processes อื่นๆ / Other Business Processes

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

### F-001 Customer Registration Business Rules

| Rule ID | Category | Description | Flow Step |
|---------|---------|-------------|-----------|
| BR-001 | Uniqueness | เลขบัตรประชาชน 13 หลักต้องไม่ซ้ำในระบบ | ขั้นตอนตรวจสอบ duplicate |
| BR-002 | KYC Completeness | เอกสาร KYC ต้องครบตามประเภทลูกค้าก่อน submit | ขั้นตอนอัปโหลดเอกสาร |
| BR-003 | Data Classification | ข้อมูลลูกค้าทั้งหมดเป็น Confidential (PDPA) | ทุกขั้นตอน |
| BR-004 | Approval Required | Registration ทุกรายต้องผ่าน Supervisor approve | ขั้นตอน submit → review |
| BR-005 | Age Validation | ลูกค้าบุคคลธรรมดาอายุ ≥ 20 ปี | ขั้นตอนกรอกข้อมูล |
| BR-006 | Audit Trail | บันทึก audit log ทุก action | ทุกขั้นตอน |
| BR-007 | File Size | เอกสาร KYC แต่ละไฟล์ ≤ 10 MB | ขั้นตอน upload |

### Other Business Rules (ระบบอื่น)

| Rule ID | Category | Description |
|---------|---------|-------------|
| BR-C001 | Contract | สัญญาต้องได้รับ approval จาก Manager ก่อน activate |
| BR-C002 | Credit | Credit score ต้องสูงกว่า threshold จึงผ่านได้ |
| BR-P001 | Payment | Grace period 7 วันหลังครบกำหนด |
| BR-KYC001 | KYC | ต้องมีเอกสาร: บัตรประชาชน, ทะเบียนบ้าน, รายได้ |
| BR-R001 | Renewal | ต้องแจ้งลูกค้าล่วงหน้า 60 วันก่อนสัญญาหมด |

---

*Document ID: PTL-BF-001 | Version: 1.0.0 | อัปเดตล่าสุด: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
