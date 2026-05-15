# Discovery Phase / เฟส Discovery

> ภาพรวมของ Discovery phase ทั้ง 5 ขั้นตอนสำหรับโปรเจกต์ PT Leasing

---

## What is Discovery? / Discovery คืออะไร

Discovery phase คือกระบวนการที่ทีมทำความเข้าใจ business requirements, ออกแบบ solution, และตรวจสอบความถูกต้องก่อนเริ่มพัฒนา เป้าหมายคือให้ทีม Dev มีข้อมูลครบพอที่จะเริ่ม sprint แรกได้โดยไม่ต้องหยุดถามคำถาม

---

## Phase Structure / โครงสร้างเฟส

```
00-discovery/
├── 01-requirements/     Phase 1: รวบรวมความต้องการ (14 วัน)
├── 02-design/           Phase 2: ออกแบบ (21 วัน)
│   ├── business/        Business flow
│   ├── uxui/            UX/UI design
│   ├── architecture/    System architecture + ADRs
│   ├── system/          System design, APIs, sequences
│   ├── testing/         Test strategy
│   └── security/        Security design + DPIA
├── 03-validation/       Phase 3: ตรวจสอบ (7 วัน)
├── 04-breakdown/        Phase 4: แบ่ง Stories & Tasks (7 วัน)
└── 05-ready-for-develop/ Phase 5: พร้อม Develop (3 วัน)
```

---

## Phase Descriptions / คำอธิบายแต่ละ Phase

### Phase 1: Requirement Gathering (14 วัน)
**เป้าหมาย**: เข้าใจ business needs อย่างครบถ้วน
- รวบรวม requirements จาก stakeholders
- เขียน BRD (Business Requirements Document)
- กำหนด scope และ priorities
- ดูรายละเอียดที่ [01-requirements/README.md](01-requirements/README.md)

### Phase 2: Make Design (21 วัน)
**เป้าหมาย**: ออกแบบทุกมิติก่อนพัฒนา
- Business flow design
- UX/UI wireframes (Figma)
- System & architecture design
- Security design
- Test strategy
- ดูรายละเอียดที่ [02-design/](02-design/)

### Phase 3: Validate Design (7 วัน)
**เป้าหมาย**: ยืนยันว่าสิ่งที่ออกแบบตรงกับความต้องการ
- จัด validation sessions กับ stakeholders
- รับ sign-off จากทุก role ที่เกี่ยวข้อง
- ดูรายละเอียดที่ [03-validation/README.md](03-validation/README.md)

### Phase 4: Story & Task Breakdown (7 วัน)
**เป้าหมาย**: แปลง requirements เป็น dev-ready stories
- เขียน user stories พร้อม acceptance criteria
- แบ่ง tasks และประเมิน story points
- สร้าง traceability matrix
- ดูรายละเอียดที่ [04-breakdown/](04-breakdown/)

### Phase 5: Ready for Develop (3 วัน)
**เป้าหมาย**: Handoff ที่สมบูรณ์ให้ทีม Dev
- ตรวจสอบ readiness checklist
- จัด handoff session
- ดูรายละเอียดที่ [05-ready-for-develop/](05-ready-for-develop/)

---

## Getting Started / เริ่มต้น

### สร้าง Feature ใหม่
```bash
./scripts/new-feature.sh F-001 "contract-management"
```

### สร้าง Change Request
```bash
./scripts/new-cr.sh CR-001 "add-renewal-date" "F-001"
```

### ดู Phase Progress
ดูได้ที่ [PROJECT_STATUS.md](../../PROJECT_STATUS.md) หรือ [Dashboard](../../dashboard/index.html)

---

## Document Status Flow / ลำดับ Status เอกสาร

```
draft → in_review → approved → final
                └→ rejected → draft (revise)
```

---

*SLA รวม: 52 วัน | อัปเดตล่าสุด: 2026-05-15*
