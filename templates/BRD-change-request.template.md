---
doc_id: "PTL-CRXXX-BRD"
title: "BRD (CR): [Change Name]"
project: ptl_leasing
type: change_request
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "01-requirements"
cr_id: "CR-XXX"
feature_id: "F-XXX"
epic: "EPIC-XX"
jira_issue: "PTL-XXX"
created_at: "YYYY-MM-DD"
updated_at: "YYYY-MM-DD"
reviewed_by: ""
approved_by: ""
approved_at: ""
---

# BRD (Change Request): [Change Name]
# Business Requirements Document — Change Request

> **CR ID**: CR-XXX | **Related Feature**: F-XXX | **Version**: 0.1.0 | **Status**: Draft

---

## 1. Change Request Background / ที่มาของการขอเปลี่ยนแปลง

### 1.1 Background / ที่มา

*(อธิบาย context ว่าทำไมถึงมี CR นี้ ใครขอ เมื่อไหร่ มีเหตุการณ์อะไร trigger)*

### 1.2 Requested By / ขอโดย

| Field | Value |
|-------|-------|
| Requested By | [Name / Role] |
| Request Date | YYYY-MM-DD |
| Priority | Critical / High / Medium / Low |
| Target Delivery | YYYY-MM-DD (ถ้ามี) |

---

## 2. Current State (As-Is) / สถานะปัจจุบัน

### 2.1 Current Behavior / พฤติกรรมปัจจุบัน

*(อธิบายระบบหรือ feature ในสถานะปัจจุบันอย่างละเอียด)*

### 2.2 Current Limitations / ข้อจำกัดปัจจุบัน

*(อธิบายว่าระบบปัจจุบันทำอะไรไม่ได้หรือทำได้ไม่ดีพอ)*

### 2.3 Current Business Process / กระบวนการธุรกิจปัจจุบัน

```
[อธิบาย flow ปัจจุบัน — ใช้ text หรือ Mermaid diagram]

Start → Step 1 → Step 2 → End
```

---

## 3. Requested Change / การเปลี่ยนแปลงที่ขอ

### 3.1 Desired State (To-Be) / สถานะที่ต้องการ

*(อธิบายสิ่งที่ต้องการเปลี่ยนแปลงอย่างละเอียด)*

### 3.2 Changed Behavior / พฤติกรรมที่เปลี่ยนแปลง

*(อธิบายว่าระบบจะทำงานอย่างไรหลังการเปลี่ยนแปลง)*

### 3.3 New Business Process / กระบวนการธุรกิจใหม่

```
[อธิบาย flow ใหม่ — ใช้ text หรือ Mermaid diagram]

Start → Step 1 (new) → Step 2 (modified) → Step 3 (new) → End
```

---

## 4. Business Justification / เหตุผลทางธุรกิจ

### 4.1 Why This Change is Needed / ทำไมต้องเปลี่ยนแปลง

*(ระบุเหตุผลที่ชัดเจน เช่น กฎระเบียบ, business need, efficiency)*

### 4.2 Impact of Not Changing / ผลกระทบหากไม่เปลี่ยนแปลง

*(อธิบายความเสี่ยงหรือผลเสียหากไม่ดำเนินการ CR นี้)*

### 4.3 Business Benefits / ประโยชน์ที่จะได้รับ

*(ระบุ benefit ที่คาดหวัง)*
1.
2.
3.

---

## 5. Scope of Change / ขอบเขตการเปลี่ยนแปลง

### 5.1 What Changes / สิ่งที่เปลี่ยนแปลง

| Area | Current | Changed To | Change Type |
|------|---------|-----------|------------|
| Business Rule | | | Modify/Add/Remove |
| UI/UX | | | |
| Data | | | |
| Integration | | | |

### 5.2 What Does NOT Change / สิ่งที่ไม่เปลี่ยน

*(ชี้แจงให้ชัดเจนว่าอะไรที่ไม่เปลี่ยน ลด confusion)*
-
-

---

## 6. Impact Summary / สรุปผลกระทบ

*(ประเมินผลกระทบเบื้องต้น — ละเอียดจะอยู่ใน IMPACT_ANALYSIS.md)*

| Area | Impact Level | Description |
|------|-------------|-------------|
| Business Logic | High / Medium / Low | |
| Database / Data Model | High / Medium / Low | |
| UI/UX | High / Medium / Low | |
| API / Integration | High / Medium / Low | |
| Existing Features | High / Medium / Low | |
| Performance | High / Medium / Low | |
| Security | High / Medium / Low | |
| Timeline | High / Medium / Low | |
| Cost | High / Medium / Low | |

**Overall Risk Level**: High / Medium / Low

---

## 7. Success Criteria / เกณฑ์ความสำเร็จ

*(จะรู้ได้อย่างไรว่า CR นี้ประสบความสำเร็จ)*

| Criteria | Measurement | Target |
|----------|------------|--------|
| | | |
| | | |

---

## Related Documents / เอกสารที่เกี่ยวข้อง

- [ ] GAP_ANALYSIS.md — Gap analysis ระหว่าง As-Is และ To-Be
- [ ] IMPACT_ANALYSIS.md — ผลกระทบต่อระบบ
- [ ] SRS.md — Software requirements หลังการเปลี่ยนแปลง
- [ ] ACCEPTANCE_CRITERIA.md — เกณฑ์การยอมรับ

---

## Sign-off / การอนุมัติ

| Role | Name | Email | Date | Decision |
|------|------|-------|------|---------|
| Business Owner | | | | Approve / Reject |
| BA | Orawan Nus | orawan.nus@snocko-tech.com | | Approve / Reject |
| PM | Bovornsak Pan | bovornsak.pan@snocko-tech.com | | Approve / Reject |
| SA | | | | Approve / Reject |

---

*เอกสารนี้สร้างโดย PT Leasing SDLC Framework — templates/BRD-change-request.template.md*
