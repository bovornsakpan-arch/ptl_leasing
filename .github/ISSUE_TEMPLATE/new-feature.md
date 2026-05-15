---
name: New Feature
about: Request documentation and tracking for a new feature
title: '[FEATURE] F-XXX — Feature Name'
labels: new-feature, phase-1-requirements
assignees: orawan-nus
---

## Feature Information / ข้อมูล Feature

- **Feature ID**: `F-XXX` *(กำหนดโดย BA)*
- **Epic**: `EPIC-XX — Epic Name`
- **Jira Epic**: PTL-XXX
- **Figma**: https://www.figma.com/files/project/587761135 *(link ไปยัง frame/page ที่เกี่ยวข้อง)*
- **Priority**: High / Medium / Low
- **Estimated Effort**: X story points *(ประมาณเบื้องต้น)*

---

## Business Context / บริบทธุรกิจ

<!-- อธิบาย context ทางธุรกิจ ทำไมต้องมี feature นี้ -->

---

## Problem Statement / ปัญหาที่ต้องการแก้ไข

<!-- อธิบายปัญหาปัจจุบัน — ปัจจุบันทำอะไรไม่ได้ หรือทำได้ยาก -->

---

## Description / คำอธิบาย Feature

<!-- อธิบาย feature ที่ต้องการในรูปแบบ user perspective -->

**As a** [ประเภทผู้ใช้]
**I want to** [สิ่งที่ต้องการทำ]
**So that** [ประโยชน์ที่ได้รับ]

---

## Business Value / คุณค่าทางธุรกิจ

<!-- ผลลัพธ์ที่คาดหวัง เช่น ลดเวลา, เพิ่มรายได้, ลดต้นทุน, compliance -->

---

## Acceptance Criteria (High Level) / เกณฑ์การยอมรับเบื้องต้น

<!-- AC ละเอียดจะอยู่ใน ACCEPTANCE_CRITERIA.md -->
- [ ] AC 1:
- [ ] AC 2:
- [ ] AC 3:

---

## Stakeholders / ผู้มีส่วนได้เสีย

| Role | Name | Email | Responsibility |
|------|------|-------|---------------|
| Business Owner | | | Final approval |
| End User | | | User acceptance |

---

## Documents to Create / เอกสารที่ต้องสร้าง

```bash
./scripts/new-feature.sh F-XXX "feature-name"
```

- [ ] `docs/00-discovery/01-requirements/new-features/F-XXX/BRD.md`
- [ ] `docs/00-discovery/01-requirements/new-features/F-XXX/SRS.md`
- [ ] `docs/00-discovery/01-requirements/new-features/F-XXX/ACCEPTANCE_CRITERIA.md`

---

## Dependencies / ความต้องพึ่งพา

<!-- feature อื่นหรือระบบอื่นที่ต้องพึ่งพา -->

---

## Out of Scope / นอก Scope

<!-- สิ่งที่ไม่รวมใน feature นี้ -->
