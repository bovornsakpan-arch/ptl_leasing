## Summary / สรุปการเปลี่ยนแปลง

<!-- อธิบายสิ่งที่เปลี่ยนแปลงในภาษาที่ทุกคนเข้าใจ -->

## Type of Change / ประเภทการเปลี่ยนแปลง

<!-- เลือกหนึ่งข้อ -->
- [ ] New Feature — เอกสารสำหรับ feature ใหม่
- [ ] Change Request (CR) — เอกสารสำหรับ change request
- [ ] Documentation Update — แก้ไข/อัปเดตเอกสาร
- [ ] Config Change — แก้ไข configuration
- [ ] Template Update — แก้ไข template
- [ ] Dashboard/Script — แก้ไข dashboard หรือ scripts

## Related Feature / CR ID

<!-- ระบุ Feature ID หรือ CR ID ที่เกี่ยวข้อง -->
- Feature/CR ID: `F-XXX` หรือ `CR-XXX`
- Jira Issue: `PTL-XXX` (https://snocko-main.atlassian.net/jira/software/projects/PTL/)
- Epic: (ถ้ามี)

## Documents Changed / เอกสารที่เปลี่ยนแปลง

<!-- รายการไฟล์ที่เปลี่ยนแปลง พร้อมอธิบายสั้น ๆ -->

| File | Action | Description |
|------|--------|-------------|
| `path/to/file.md` | Created / Updated / Deleted | อธิบาย |

## Phase / ขั้นตอน SDLC

<!-- PR นี้อยู่ในขั้นตอนใด -->
- [ ] Phase 1: Requirement Gathering
- [ ] Phase 2: Make Design
- [ ] Phase 3: Validate Design
- [ ] Phase 4: Story & Task Breakdown
- [ ] Phase 5: Ready for Develop
- [ ] Post-Discovery (Documentation update)

## Checklist / รายการตรวจสอบ

### Document Quality
- [ ] Frontmatter ครบทุก field ที่ required (doc_id, title, version, status, owner)
- [ ] Version bump เหมาะสม (ถ้าแก้ไขเอกสารที่มีอยู่แล้ว)
- [ ] CHANGELOG.md อัปเดตแล้ว (ถ้าเป็น significant change)
- [ ] เนื้อหาสมบูรณ์ ไม่มี TODO ที่ยังค้างอยู่

### Review
- [ ] Peer review โดย role ที่เกี่ยวข้อง
- [ ] ไม่มี sensitive data (รหัสผ่าน, API key) ใน commit

### Tracking
- [ ] Jira issue อัปเดต status แล้ว
- [ ] config/feature-versions.yaml อัปเดตแล้ว (ถ้าเกี่ยวข้อง)

## Screenshots / ภาพประกอบ

<!-- แนบภาพ (ถ้ามี) -->

## Notes for Reviewer / หมายเหตุสำหรับ Reviewer

<!-- สิ่งที่ควรให้ความสนใจเป็นพิเศษ -->

---
*PR นี้ต้องได้รับ approval จาก CODEOWNERS ตาม .github/CODEOWNERS*
