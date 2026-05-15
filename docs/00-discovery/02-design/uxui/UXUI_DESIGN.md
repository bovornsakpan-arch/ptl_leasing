---
doc_id: "PTL-UXUI-001"
title: "UX/UI Design — PT Leasing Backoffice"
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

# UX/UI Design — PT Leasing Backoffice
# การออกแบบ UX/UI

> **Version**: 0.1.0 | **Status**: Draft
> Figma: https://www.figma.com/files/project/587761135

---

## Overview / ภาพรวม

เอกสารนี้อธิบายทิศทางการออกแบบ UX/UI สำหรับระบบ PT Leasing Backoffice

---

## Design Principles / หลักการออกแบบ

1. **Clarity / ความชัดเจน**: ข้อมูลทางการเงินต้องแสดงชัดเจน ไม่คลุมเครือ
2. **Efficiency / ประสิทธิภาพ**: ลด clicks ในงานที่ทำบ่อย เช่น สร้างสัญญา
3. **Error Prevention / ป้องกันข้อผิดพลาด**: validation ที่ดี confirmation ก่อนทำสิ่งสำคัญ
4. **Consistency / ความสม่ำเสมอ**: ใช้ component และ pattern เดียวกันทั้งระบบ
5. **Thai Language First**: UI text เป็นภาษาไทย ศัพท์เทคนิคเป็น English

---

## Design System / ระบบการออกแบบ

ดู [design-tokens.md](design-tokens.md) สำหรับ colors, typography, spacing

### Color Palette

| Name | Hex | Usage |
|------|-----|-------|
| Primary Blue | #1E40AF | Buttons, links, highlights |
| Success Green | #16A34A | Approved, paid status |
| Warning Amber | #D97706 | Pending, warning |
| Danger Red | #DC2626 | Error, overdue, rejected |
| Neutral Gray | #6B7280 | Secondary text, borders |
| Background | #F9FAFB | Page background |

---

## Screen Inventory / รายการหน้าจอ

| Screen ID | ชื่อหน้า | Epic | Status |
|-----------|---------|------|--------|
| SCR-001 | Login | EPIC-01 | To Design |
| SCR-002 | Dashboard (Manager) | EPIC-07 | To Design |
| SCR-003 | Dashboard (Officer) | EPIC-07 | To Design |
| SCR-004 | Contract List | EPIC-02 | To Design |
| SCR-005 | Contract Detail | EPIC-02 | To Design |
| SCR-006 | New Contract Form | EPIC-02 | To Design |
| SCR-007 | Customer List | EPIC-03 | To Design |
| SCR-008 | Customer Detail | EPIC-03 | To Design |
| SCR-009 | Payment History | EPIC-04 | To Design |
| SCR-010 | Report | EPIC-07 | To Design |
| SCR-011 | Admin: User Management | EPIC-09 | To Design |

---

## Figma Links / ลิงก์ Figma

ดูที่ [figma-links.md](figma-links.md)

---

## Accessibility / ความสามารถในการเข้าถึง

- Color contrast ratio: ≥ 4.5:1 (WCAG 2.1 AA)
- Font size: ≥ 14px สำหรับ body text
- Focus indicators ที่มองเห็นได้ชัดเจน
- Form labels ทุก input ต้องมี label
- Error messages ต้องระบุว่า field ไหนผิด

---

*อัปเดตล่าสุด: 2026-05-15*
