# Decision Log / บันทึกการตัดสินใจ

> บันทึกการตัดสินใจสำคัญของโปรเจกต์ PT Leasing
> สำหรับการตัดสินใจด้าน Architecture ให้ใช้ [ADR](docs/00-discovery/02-design/architecture/adr/) แทน

---

## Format / รูปแบบ

| Field | Description |
|-------|-------------|
| **ID** | DEC-XXX (sequential) |
| **Date** | YYYY-MM-DD |
| **Decision** | สิ่งที่ตัดสินใจ |
| **Rationale** | เหตุผลในการตัดสินใจ |
| **Decided By** | ผู้ตัดสินใจ (ระบุ role/name) |
| **Impact** | ผลกระทบต่อโปรเจกต์ |
| **Status** | Open / Closed / Superseded |

---

## Decisions / การตัดสินใจ

### DEC-001 — Use Jira as Project Tracking Tool

| Field | Value |
|-------|-------|
| **ID** | DEC-001 |
| **Date** | 2026-05-15 |
| **Decision** | ใช้ Jira (snocko-main.atlassian.net) เป็น project tracking tool หลักสำหรับโปรเจกต์ PTL |
| **Rationale** | ทีมงานมีความคุ้นเคยกับ Jira อยู่แล้ว และ organization ใช้ Jira เป็น standard tool อยู่แล้ว ทำให้ลด overhead ในการ onboard ทีมใหม่ |
| **Decided By** | PM: Bovornsak Pan (bovornsak.pan@snocko-tech.com) |
| **Impact** | ต้องตั้งค่า Jira project key PTL, สร้าง workflow mapping ระหว่าง document status และ Jira issue status |
| **Status** | Closed |

---

### DEC-002 — Use GitHub Actions for CI/CD and Document Validation

| Field | Value |
|-------|-------|
| **ID** | DEC-002 |
| **Date** | 2026-05-15 |
| **Decision** | ใช้ GitHub Actions สำหรับ validate frontmatter, role-based access check, และ auto-deploy dashboard |
| **Rationale** | Repository อยู่บน GitHub อยู่แล้ว การใช้ GitHub Actions ไม่ต้องการ infrastructure เพิ่มเติม และ integrate กับ PR workflow ได้โดยตรง |
| **Decided By** | PM: Bovornsak Pan |
| **Impact** | ต้องตั้งค่า secrets: JIRA_API_TOKEN, JIRA_USER_EMAIL ใน GitHub repository settings |
| **Status** | Closed |

---

### DEC-003 — SDLC Framework Structure: 5 Discovery Phases

| Field | Value |
|-------|-------|
| **ID** | DEC-003 |
| **Date** | 2026-05-15 |
| **Decision** | แบ่ง Discovery phase ออกเป็น 5 ขั้นตอน: (1) Requirement Gathering, (2) Make Design, (3) Validate Design, (4) Story & Task Breakdown, (5) Ready for Develop |
| **Rationale** | การแบ่ง phase ชัดเจนช่วยให้ทีมรู้ว่าตอนนี้อยู่ที่ไหน และมี gate criteria ที่ชัดเจนก่อนข้ามไปเฟสถัดไป ป้องกัน scope creep |
| **Decided By** | PM: Bovornsak Pan + BA: Orawan Nus |
| **Impact** | SLA รวม 52 วัน (14+21+7+7+3) สำหรับ full discovery cycle |
| **Status** | Closed |

---

## Template สำหรับ Decision ใหม่

```markdown
### DEC-XXX — [ชื่อการตัดสินใจ]

| Field | Value |
|-------|-------|
| **ID** | DEC-XXX |
| **Date** | YYYY-MM-DD |
| **Decision** | [อธิบายการตัดสินใจ] |
| **Rationale** | [เหตุผล] |
| **Decided By** | [Role: Name] |
| **Impact** | [ผลกระทบ] |
| **Status** | Open / Closed / Superseded |
```
