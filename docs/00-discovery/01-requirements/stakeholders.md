---
doc_id: "PTL-STK-001"
title: "Stakeholders — PT Leasing Backoffice"
project: ptl_leasing
type: requirements
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "01-requirements"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Stakeholders / ผู้มีส่วนได้เสีย

> ระบุผู้มีส่วนได้เสียทั้งหมดในโปรเจกต์ PT Leasing Backoffice

---

## RACI Matrix / เมทริกซ์ความรับผิดชอบ

- **R** = Responsible (ผู้รับผิดชอบดำเนินการ)
- **A** = Accountable (ผู้รับผิดชอบผลลัพธ์ — คนเดียว)
- **C** = Consulted (ขอความเห็น ก่อนตัดสินใจ)
- **I** = Informed (รับทราบ หลังตัดสินใจ)

---

## Project Team / ทีมโปรเจกต์

| Role | Name | Email | GitHub | Jira |
|------|------|-------|--------|------|
| PM | Bovornsak Pan | bovornsak.pan@snocko-tech.com | bovornsakpan-arch | 62e758fa... |
| BA | Orawan Nus | orawan.nus@snocko-tech.com | orawan-nus | 712020:e7f7... |
| SA | Siriporn San | siriporn.san@snocko-tech.com | siriporn-san | 619ca612... |
| SA | Thamonwan San | thamonwan.san@snocko-tech.com | thamonwan-san | 615bda58... |

---

## Business Stakeholders / ผู้มีส่วนได้เสียทางธุรกิจ

*(กรอกข้อมูลจากการสัมภาษณ์ stakeholders)*

| Role | Name | Department | Email | RACI | Availability |
|------|------|-----------|-------|------|-------------|
| Executive Sponsor | [Name] | Management | | A | Monthly review |
| Business Owner | [Name] | Operations | | A | Weekly |
| Leasing Manager | [Name] | Leasing Dept | | C | As needed |
| IT Manager | [Name] | IT | | C | Weekly |
| Compliance Officer | [Name] | Compliance | | C | Monthly |
| End User (Officer) | [Name] | Operations | | I | UAT phase |

---

## End User Personas / ผู้ใช้งานหลัก

### Persona 1: Leasing Officer / เจ้าหน้าที่ลีสซิ่ง

| Field | Detail |
|-------|--------|
| **Role in system** | OFFICER |
| **Primary tasks** | สร้างสัญญา, ดูข้อมูลลูกค้า, ประมวลการชำระเงิน |
| **Tech literacy** | ปานกลาง — ใช้ Excel และระบบ legacy ได้ |
| **Pain points (current)** | ต้องกรอกข้อมูลซ้ำหลายระบบ, ค้นหาข้อมูลยาก |
| **Goals** | ทำงานเร็วขึ้น ลดข้อผิดพลาด |
| **Access hours** | จันทร์-ศุกร์ 8:00-18:00 |

### Persona 2: Leasing Manager / ผู้จัดการลีสซิ่ง

| Field | Detail |
|-------|--------|
| **Role in system** | MANAGER |
| **Primary tasks** | อนุมัติสัญญา, ดู dashboard, รายงาน |
| **Tech literacy** | สูง |
| **Pain points (current)** | ขาด real-time visibility, report ล่าช้า |
| **Goals** | ตัดสินใจได้เร็วขึ้นด้วยข้อมูล real-time |
| **Access hours** | ตลอดเวลา (มี mobile access) |

### Persona 3: System Admin / ผู้ดูแลระบบ

| Field | Detail |
|-------|--------|
| **Role in system** | ADMIN |
| **Primary tasks** | จัดการ users, ตั้งค่าระบบ, monitor |
| **Tech literacy** | สูงมาก |
| **Pain points** | — (new role) |
| **Goals** | ระบบ stable, secure, easy to maintain |

---

## Stakeholder Communication Plan / แผนการสื่อสาร

| Stakeholder | Frequency | Channel | Content |
|-------------|-----------|---------|---------|
| Executive Sponsor | Monthly | Email + Presentation | Project progress, risk, budget |
| Business Owner | Weekly | Meeting + Email | Phase progress, decisions needed |
| End Users | Phase 3 | Workshop | Design review, UAT planning |
| IT Manager | Weekly | Meeting | Technical decisions, infrastructure |

---

## Sign-off Authority / อำนาจการอนุมัติ

| Document Type | Must Approve |
|--------------|-------------|
| BRD | PM + Business Owner |
| SRS | PM + SA |
| Architecture | PM + SA + IT Manager |
| UAT | Business Owner |
| Go-live | Executive Sponsor + PM |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
