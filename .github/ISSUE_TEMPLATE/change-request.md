---
name: Change Request
about: Request a change to an existing feature or document
title: '[CR] CR-XXX — Change Description'
labels: change-request, phase-1-requirements
assignees: orawan-nus
---

## Change Request Information / ข้อมูล CR

- **CR ID**: `CR-XXX` *(กำหนดโดย BA)*
- **Related Feature**: `F-XXX — Feature Name`
- **Related Jira**: PTL-XXX
- **CR Date**: YYYY-MM-DD
- **Requested By**: *(name/role)*
- **Priority**: Critical / High / Medium / Low
- **Target Phase**: Phase 1 / 2 / 3 / 4 / 5

---

## Change Request Background / ที่มาของการขอเปลี่ยนแปลง

<!-- อธิบายว่าทำไมถึงมีการขอเปลี่ยนแปลง context คืออะไร -->

---

## Current State (As-Is) / สถานะปัจจุบัน

<!-- อธิบายระบบหรือ feature ในสถานะปัจจุบัน -->

---

## Requested Change / การเปลี่ยนแปลงที่ขอ

<!-- อธิบายสิ่งที่ต้องการเปลี่ยนแปลงอย่างชัดเจน -->

---

## Business Justification / เหตุผลทางธุรกิจ

<!-- ทำไมต้องเปลี่ยนแปลง? ผลกระทบถ้าไม่เปลี่ยน? -->

---

## Impact Assessment (Preliminary) / ผลกระทบเบื้องต้น

<!-- ผลกระทบต่อระบบ ประเมินเบื้องต้น (ละเอียดจะอยู่ใน IMPACT_ANALYSIS.md) -->

| Area | Impact Level | Notes |
|------|-------------|-------|
| Business Logic | High / Med / Low | |
| Database | High / Med / Low | |
| UI/UX | High / Med / Low | |
| API | High / Med / Low | |
| Timeline | High / Med / Low | |
| Cost | High / Med / Low | |

---

## Success Criteria / เกณฑ์ความสำเร็จ

<!-- จะรู้ได้อย่างไรว่าการเปลี่ยนแปลงสำเร็จ -->
- [ ]
- [ ]
- [ ]

---

## Documents to Create / เอกสารที่ต้องสร้าง

```bash
./scripts/new-cr.sh CR-XXX "change-name" "F-XXX"
```

- [ ] `docs/00-discovery/01-requirements/new-features/F-XXX/changes/CR-XXX/BRD.md`
- [ ] `docs/00-discovery/01-requirements/new-features/F-XXX/changes/CR-XXX/GAP_ANALYSIS.md`
- [ ] `docs/00-discovery/01-requirements/new-features/F-XXX/changes/CR-XXX/IMPACT_ANALYSIS.md`
- [ ] `docs/00-discovery/01-requirements/new-features/F-XXX/changes/CR-XXX/SRS.md`
- [ ] `docs/00-discovery/01-requirements/new-features/F-XXX/changes/CR-XXX/ACCEPTANCE_CRITERIA.md`

---

## Approval Required / ต้องการ Approval จาก

- [ ] PM: Bovornsak Pan
- [ ] BA: Orawan Nus
- [ ] SA (if technical change): Siriporn San / Thamonwan San
