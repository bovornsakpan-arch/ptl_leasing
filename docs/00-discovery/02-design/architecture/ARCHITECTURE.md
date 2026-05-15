---
doc_id: "PTL-ARCH-001"
title: "System Architecture — PT Leasing Backoffice"
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

# System Architecture — PT Leasing Backoffice
# สถาปัตยกรรมระบบ

> **Version**: 0.1.0 | **Status**: Draft
> ดู ADRs สำหรับการตัดสินใจด้าน architecture: [adr/](adr/)

---

## Overview / ภาพรวม

PT Leasing Backoffice เป็นระบบ web application แบบ multi-tier ที่ออกแบบให้รองรับ 100+ concurrent users ด้วย architecture ที่ scalable และ maintainable

---

## Architecture Style / รูปแบบสถาปัตยกรรม

**Selected**: Monolithic Modular Architecture (ระยะแรก)
**Future**: Microservices (ตาม ADR-002)

เหตุผล: ขนาดทีมเล็ก (< 10 Dev) — monolith with clear module boundaries ง่ายกว่าในการพัฒนาและ maintain ระยะแรก

---

## System Context / บริบทระบบ

```mermaid
C4Context
    title PT Leasing Backoffice — System Context

    Person(officer, "Leasing Officer", "เจ้าหน้าที่ลีสซิ่ง")
    Person(manager, "Manager", "ผู้จัดการ")
    Person(admin, "System Admin", "ผู้ดูแลระบบ")

    System(ptl, "PT Leasing Backoffice", "Web application สำหรับจัดการสัญญาเช่า, ลูกค้า, และการชำระเงิน")

    System_Ext(credit_bureau, "Credit Bureau API", "ระบบตรวจสอบเครดิต")
    System_Ext(payment_gw, "Payment Gateway", "ประมวลการชำระเงิน")
    System_Ext(email_svc, "Email Service (SendGrid/SES)", "ส่ง email notifications")
    System_Ext(storage, "Object Storage (S3)", "เก็บเอกสาร PDF")
    System_Ext(sms_svc, "SMS Gateway", "ส่ง SMS")

    Rel(officer, ptl, "ใช้งาน", "HTTPS")
    Rel(manager, ptl, "ใช้งาน", "HTTPS")
    Rel(admin, ptl, "จัดการ", "HTTPS")
    Rel(ptl, credit_bureau, "ตรวจสอบเครดิต", "REST API")
    Rel(ptl, payment_gw, "ประมวลชำระเงิน", "REST API")
    Rel(ptl, email_svc, "ส่ง email", "API")
    Rel(ptl, storage, "Upload/download เอกสาร", "S3 API")
    Rel(ptl, sms_svc, "ส่ง SMS", "API")
```

---

## Component Architecture / สถาปัตยกรรมส่วนประกอบ

*(กรอกรายละเอียดหลัง architecture decisions finalised)*

### Technology Stack Summary

| Layer | Technology | Rationale |
|-------|-----------|-----------|
| Frontend | React 18 + TypeScript | — *(ดู ADR-00X)* |
| Backend | Node.js + Express | — *(ดู ADR-00X)* |
| Database | PostgreSQL 15 | — *(ดู ADR-00X)* |
| Cache | Redis 7 | Session, cache |
| Container | Docker | Consistency |
| Orchestration | Kubernetes / Docker Compose | Scalability |
| CI/CD | GitHub Actions | Repository integration |

ดู [TECH_STACK.md](TECH_STACK.md) สำหรับรายละเอียดเพิ่มเติม

---

## Architecture Decisions / การตัดสินใจ Architecture

ดู [adr/](adr/) สำหรับ Architecture Decision Records ทั้งหมด

| ADR | Title | Status |
|-----|-------|--------|
| ADR-0001 | Use Jira as task tracking system | Accepted |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
