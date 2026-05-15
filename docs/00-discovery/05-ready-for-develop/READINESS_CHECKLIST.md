---
doc_id: "PTL-READY-001"
title: "Readiness Checklist — PT Leasing"
project: ptl_leasing
type: readiness
version: "0.1.0"
status: draft
owner: bovornsak.pan@snocko-tech.com
phase: "05-ready"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Readiness Checklist / รายการตรวจสอบความพร้อม

> **Version**: 0.1.0 | **Status**: Draft

ต้องผ่าน **100%** ก่อนเริ่ม Sprint แรก

---

## Phase 1: Requirement Gathering ✅

- [ ] EPICS.md อัปเดตแล้ว — Epics ทั้งหมดถูกต้อง
- [ ] Stakeholders document ครบถ้วน — ทุก stakeholder ระบุแล้ว
- [ ] BRD ทุก feature ได้รับ PM approval
- [ ] Scope ชัดเจน — in-scope/out-of-scope ระบุแล้ว
- [ ] Business rules ครบถ้วนและถูกต้อง
- [ ] ไม่มี critical ambiguities ค้างอยู่
- [ ] Requirements ได้รับ review จาก business owner

---

## Phase 2: Design ✅

### Business Design
- [ ] Business flow ครอบคลุม happy path ทั้งหมด
- [ ] Business flow ครอบคลุม exception cases สำคัญ
- [ ] Business rules implement แล้ว

### UX/UI Design
- [ ] ทุก screen ใน screen inventory ออกแบบแล้วใน Figma
- [ ] Navigation flow สมเหตุสมผล
- [ ] Error states, loading states ออกแบบแล้ว
- [ ] Design tokens กำหนดแล้ว
- [ ] Responsive design (tablet + desktop)

### System Design
- [ ] System architecture เอกสารเสร็จแล้ว
- [ ] API spec ครบทุก endpoint
- [ ] Database schema กำหนดแล้ว
- [ ] Sequence diagrams สำหรับ critical flows
- [ ] ADRs สำหรับ key decisions

### Security Design
- [ ] DPIA เสร็จแล้ว
- [ ] Data classification กำหนดแล้ว
- [ ] Threat model เสร็จแล้ว
- [ ] Security controls กำหนดแล้ว
- [ ] PDPA compliance check เสร็จแล้ว

### Testing
- [ ] Test strategy กำหนดแล้ว
- [ ] Test environment plan เสร็จแล้ว
- [ ] UAT plan เสร็จแล้ว

---

## Phase 3: Design Validation ✅

- [ ] Business design validation: sign-off ได้แล้ว
- [ ] UX/UI design validation: sign-off ได้แล้ว
- [ ] Architecture validation: sign-off ได้แล้ว
- [ ] System design validation: sign-off ได้แล้ว
- [ ] Testing strategy validation: sign-off ได้แล้ว
- [ ] Security design validation: sign-off ได้แล้ว
- [ ] Action items จากทุก session แก้ไขแล้ว

---

## Phase 4: Story Breakdown ✅

- [ ] ทุก story มี acceptance criteria ที่ชัดเจน
- [ ] ทุก story มี story point estimates
- [ ] Stories sync กับ Jira แล้ว
- [ ] Traceability matrix ครบถ้วน (REQ → Design → Story → Test)
- [ ] Dev team review stories แล้วและไม่มีคำถามค้างอยู่
- [ ] Sprint 1 planning เสร็จแล้ว
- [ ] Team velocity ประเมินแล้ว
- [ ] Definition of Done กำหนดแล้ว

---

## Technical Readiness / ความพร้อมด้านเทคนิค

- [ ] Repository สร้างแล้ว
- [ ] Branch strategy กำหนดแล้ว (main, develop, feature/...)
- [ ] CI/CD pipeline ตั้งค่าแล้ว (อย่างน้อย build + test)
- [ ] Development environment documented (README.md)
- [ ] Dev environment ทุกคนใน Dev team setup ได้แล้ว
- [ ] Staging environment พร้อมใช้งาน
- [ ] Database schema migration scripts เตรียมไว้แล้ว
- [ ] Secrets management กำหนดแล้ว (ไม่มี secrets ใน code)

---

## Team Readiness / ความพร้อมของทีม

- [ ] Dev team รู้ทุก story ใน Sprint 1
- [ ] Dev team เข้าใจ tech stack และ architecture
- [ ] Dev team เข้าใจ coding standards
- [ ] QA team มี test environment
- [ ] QA team เข้าใจ acceptance criteria ของทุก story
- [ ] PM ได้แจ้ง stakeholders เรื่อง timeline

---

## Final Sign-off / การอนุมัติสุดท้าย

- [ ] PM sign-off: โปรเจกต์พร้อมเริ่ม development

**Sign-off Date**: *(กรอกวันที่)*
**Signed by**: Bovornsak Pan (PM)

---

## Progress / ความคืบหน้า

| Section | Items | Completed | % |
|---------|-------|-----------|---|
| Phase 1 | 7 | 0 | 0% |
| Phase 2 | 17 | 0 | 0% |
| Phase 3 | 7 | 0 | 0% |
| Phase 4 | 8 | 0 | 0% |
| Technical | 8 | 0 | 0% |
| Team | 6 | 0 | 0% |
| **Total** | **53** | **0** | **0%** |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: bovornsak.pan@snocko-tech.com*
