---
doc_id: "PTL-DPIA-001"
title: "DPIA — PT Leasing Backoffice"
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

# Data Protection Impact Assessment (DPIA)
# การประเมินผลกระทบต่อการคุ้มครองข้อมูลส่วนบุคคล

> **Version**: 0.1.0 | **Status**: Draft
> ตาม พ.ร.บ. คุ้มครองข้อมูลส่วนบุคคล พ.ศ. 2562 (PDPA)

---

## 1. Project Description / คำอธิบายโครงการ

| Field | Value |
|-------|-------|
| ชื่อโครงการ | PT Leasing Backoffice System |
| วัตถุประสงค์ | ระบบจัดการสัญญาเช่า ลูกค้า และการชำระเงิน |
| ผู้ควบคุมข้อมูล | PT Leasing Co., Ltd. |
| DPO | *(กรอกชื่อ DPO)* |
| วันที่ประเมิน | 2026-05-15 |

---

## 2. Data Processing Activities / กิจกรรมการประมวลผลข้อมูล

| กิจกรรม | ประเภทข้อมูล | วัตถุประสงค์ | ฐานทางกฎหมาย |
|--------|------------|------------|-------------|
| ลงทะเบียนลูกค้า | ชื่อ, ที่อยู่, เลขบัตร, โทรศัพท์ | ระบุตัวตน, KYC | ความจำเป็นเพื่อสัญญา |
| ตรวจสอบเครดิต | เลขบัตร, รายได้ | ประเมินความเสี่ยง | ความจำเป็นเพื่อสัญญา |
| การชำระเงิน | เลขบัญชี, จำนวนเงิน | ประมวลการชำระ | ความจำเป็นเพื่อสัญญา |
| เก็บ audit log | User ID, IP, action | ความปลอดภัย | ผลประโยชน์อันชอบด้วยกฎหมาย |
| ส่ง notification | Email, เบอร์โทร | แจ้งเตือนลูกค้า | ความจำเป็นเพื่อสัญญา / consent |

---

## 3. Risk Assessment / การประเมินความเสี่ยง

| ความเสี่ยง | Likelihood | Impact | Score | มาตรการ |
|---------|-----------|--------|-------|---------|
| Data breach (ข้อมูลรั่ว) | Low | High | High | Encryption, access control |
| Unauthorized access | Medium | High | High | RBAC, MFA |
| Data integrity compromise | Low | High | Medium | Audit log, validation |
| Excessive data retention | Medium | Medium | Medium | Retention policy, auto-delete |
| Third-party sharing | Low | High | Medium | Data sharing agreements |

---

## 4. Rights of Data Subjects / สิทธิ์ของเจ้าของข้อมูล

| สิทธิ์ | การรองรับในระบบ |
|-------|--------------|
| สิทธิ์รับทราบ (Right to be Informed) | Privacy notice ก่อนเก็บข้อมูล |
| สิทธิ์เข้าถึง (Right of Access) | ลูกค้าดูข้อมูลตัวเองได้ผ่าน portal |
| สิทธิ์แก้ไข (Right to Rectification) | เจ้าหน้าที่แก้ไขตามคำขอ |
| สิทธิ์ลบ (Right to Erasure) | Soft delete + encrypt (ยกเว้นที่ต้องเก็บตามกฎหมาย) |
| สิทธิ์คัดค้าน (Right to Object) | Opt-out สำหรับ marketing |
| สิทธิ์โอนย้าย (Data Portability) | Export ข้อมูลตัวเองเป็น JSON/CSV |

---

## 5. Technical Safeguards / มาตรการทางเทคนิค

- Encryption at rest: AES-256 สำหรับ PII fields
- Encryption in transit: TLS 1.2+
- Access control: RBAC
- Audit logging: ทุก CRUD operation
- Data masking: ใน logs และ non-production environments
- Backup: Encrypted backups ทุกวัน

---

## 6. Conclusion / บทสรุป

*(กรอกหลังจาก review กับ DPO)*

- [ ] ความเสี่ยงอยู่ในระดับที่ยอมรับได้
- [ ] มาตรการทั้งหมดได้รับการยืนยัน
- [ ] DPO review และอนุมัติแล้ว
- [ ] พร้อม implement

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
