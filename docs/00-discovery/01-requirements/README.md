# Phase 1: Requirement Gathering / รวบรวมความต้องการ

> **SLA**: 14 วัน | **Owner**: BA (Orawan Nus) | **Status**: In Progress

---

## Overview / ภาพรวม

Phase 1 คือจุดเริ่มต้นของทุก feature และ CR โดยทีม BA ทำงานร่วมกับ stakeholders เพื่อทำความเข้าใจและเอกสาร business requirements ก่อนส่งต่อให้ทีม SA ทำ design

---

## Folder Structure / โครงสร้าง Folder

```
01-requirements/
├── README.md              # ไฟล์นี้
├── EPICS.md               # รายการ Epics ทั้งหมด
├── stakeholders.md        # ผู้มีส่วนได้เสีย
└── new-features/          # Features และ CRs
    └── F-XXX-feature-name/
        ├── BRD.md         # Business Requirements
        ├── SRS.md         # Software Requirements
        ├── ACCEPTANCE_CRITERIA.md
        ├── verification/  # Verification artifacts
        └── changes/       # Change requests
            └── CR-XXX-change-name/
                ├── BRD.md
                ├── GAP_ANALYSIS.md
                ├── IMPACT_ANALYSIS.md
                ├── SRS.md
                └── ACCEPTANCE_CRITERIA.md
```

---

## How to Create a New Feature / วิธีสร้าง Feature ใหม่

1. สร้าง GitHub Issue โดยใช้ template "New Feature"
2. รันคำสั่ง:
   ```bash
   ./scripts/new-feature.sh F-001 "feature-name"
   ```
3. กรอกข้อมูลใน BRD.md (ใน `docs/00-discovery/01-requirements/new-features/F-001/`)
4. Create PR เมื่อ BRD ร่างเสร็จแล้ว
5. ขอ review จาก PM

---

## Gate Criteria / เกณฑ์ผ่าน Phase

ก่อนข้ามไป Phase 2 ต้องผ่านเกณฑ์ต่อไปนี้:

- [ ] EPICS.md อัปเดตแล้ว
- [ ] Stakeholders document ครบถ้วน
- [ ] BRD ของทุก feature/CR ในรอบนี้ได้รับ approval จาก PM
- [ ] ไม่มี critical ambiguities ที่ยังค้างอยู่
- [ ] Scope ชัดเจน — in-scope และ out-of-scope ระบุแล้ว

---

## Key Documents / เอกสารสำคัญ

| Document | Description | Owner |
|----------|-------------|-------|
| [EPICS.md](EPICS.md) | รายการ Epics ทั้งหมด | BA |
| [stakeholders.md](stakeholders.md) | ผู้มีส่วนได้เสีย | BA |
| BRD per feature | Business requirements | BA |
| SRS per feature | Software requirements | SA |

---

*อัปเดตล่าสุด: 2026-05-15*
