---
doc_id: "PTL-ISO-AC-001"
title: "Access Control Policy — PT Leasing"
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

# Access Control Policy / นโยบายการควบคุมการเข้าถึง

> **Version**: 0.1.0 | **ISO27001:2022**: A.5.15, A.8.2, A.8.3, A.8.5

---

## Purpose / วัตถุประสงค์

นโยบายนี้กำหนดหลักการและมาตรการควบคุมการเข้าถึงระบบ PT Leasing Backoffice เพื่อป้องกันการเข้าถึงโดยไม่ได้รับอนุญาต

---

## Principles / หลักการ

1. **Least Privilege**: ผู้ใช้ได้รับสิทธิ์เท่าที่จำเป็นสำหรับการทำงานเท่านั้น
2. **Need to Know**: เข้าถึงข้อมูลเฉพาะที่จำเป็นต้องรู้
3. **Separation of Duties**: แยกหน้าที่สำคัญออกจากกัน (เช่น creator ≠ approver)
4. **Regular Review**: ทบทวนสิทธิ์ทุก 6 เดือน
5. **Revocation**: เพิกถอนสิทธิ์ทันทีเมื่อไม่จำเป็นอีกต่อไป

---

## Roles and Permissions / Roles และสิทธิ์

### Application Roles

| Role | Description | Approval Required |
|------|-------------|------------------|
| ADMIN | Full system access | PM + IT Manager |
| MANAGER | Approve contracts, view all data, reports | PM |
| OFFICER | Create/manage contracts (own), manage customers | PM |
| VIEWER | Read-only access to assigned data | MANAGER |

### Role Permission Matrix

| Feature | ADMIN | MANAGER | OFFICER | VIEWER |
|---------|-------|---------|---------|--------|
| User management | ✅ | ❌ | ❌ | ❌ |
| System config | ✅ | ❌ | ❌ | ❌ |
| View all contracts | ✅ | ✅ | Own only | Own only |
| Create contract | ✅ | ✅ | ✅ | ❌ |
| Approve contract | ✅ | ✅ | ❌ | ❌ |
| Delete contract | ✅ | ❌ | ❌ | ❌ |
| View all customers | ✅ | ✅ | ✅ | ✅ |
| Edit customer | ✅ | ✅ | ✅ | ❌ |
| Record payment | ✅ | ✅ | ✅ | ❌ |
| View reports | ✅ | ✅ | ❌ | ❌ |
| Export data | ✅ | ✅ (with log) | ❌ | ❌ |
| View audit logs | ✅ | ❌ | ❌ | ❌ |

---

## Access Request Process / กระบวนการขอสิทธิ์

1. ผู้ใช้ยื่นคำขอผ่าน *(access request form URL)*
2. Line manager อนุมัติ
3. PM อนุมัติ (สำหรับ MANAGER+ roles)
4. IT Admin สร้าง account และ assign role
5. แจ้งผู้ใช้ผ่าน email

---

## Account Management / การจัดการ Account

### On-boarding
- สร้าง account ภายใน 1 วันทำการหลังได้รับ approval
- ส่ง temporary password ทาง secure channel

### Password Policy
- ความยาว: ≥ 10 characters
- ต้องมี: uppercase, lowercase, number, special character
- ห้ามใช้ซ้ำ: 5 passwords ล่าสุด
- หมดอายุ: 90 วัน
- Lock: หลังล้มเหลว 5 ครั้งใน 15 นาที

### Off-boarding
- เพิกถอนสิทธิ์ภายใน **4 ชั่วโมง** หลังพนักงานลาออก/ถูกเลิกจ้าง
- Archive audit logs ก่อน delete account
- Revoke API keys/tokens ทั้งหมด

---

## Privileged Access / การเข้าถึงระดับ Admin

- Admin accounts ต้องแยกจาก regular user accounts
- Admin actions ต้องมี MFA
- Admin sessions บันทึกทั้งหมด
- Privileged access review: ทุก 3 เดือน

---

## Access Review Schedule / ตารางทบทวนสิทธิ์

| Scope | Frequency | Reviewer |
|-------|-----------|---------|
| All user accounts | ทุก 6 เดือน | PM + IT |
| Admin/Privileged accounts | ทุก 3 เดือน | IT Manager |
| Third-party access | ทุก 12 เดือน | PM |
| On employee change | ทันที | IT + Manager |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
