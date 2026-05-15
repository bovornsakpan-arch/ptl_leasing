---
doc_id: "PTL-ADR-0001"
title: "ADR-0001: Use Jira as Task Tracking System"
project: ptl_leasing
type: adr
version: "1.0.0"
status: approved
owner: siriporn.san@snocko-tech.com
phase: "02-design"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: "thamonwan.san@snocko-tech.com"
approved_by: "bovornsak.pan@snocko-tech.com"
approved_at: "2026-05-15"
---

# ADR-0001: Use Jira as Task Tracking System
# การเลือกใช้ Jira สำหรับ Task Tracking

| Field | Value |
|-------|-------|
| **ADR ID** | ADR-0001 |
| **Date** | 2026-05-15 |
| **Status** | Accepted |
| **Deciders** | Bovornsak Pan (PM), Orawan Nus (BA), Siriporn San (SA) |
| **Supersedes** | — |

---

## Context / บริบท

โปรเจกต์ PT Leasing ต้องการ project tracking tool สำหรับ:
- ติดตาม stories, tasks, และ bugs
- เชื่อมโยงกับ documentation workflow ใน GitHub
- รายงาน progress ให้ stakeholders

ทีมงานมีประสบการณ์กับ tools หลายตัว และต้องเลือกหนึ่งตัวที่ใช้ทั้งโปรเจกต์

**Constraints**:
- Organization มี Jira license อยู่แล้วที่ snocko-main.atlassian.net
- ทีมขนาดเล็ก (4 คนในตอนนี้ จะขยายภายหลัง)
- ต้องการ integration กับ GitHub

---

## Decision / การตัดสินใจ

**We will use Jira (snocko-main.atlassian.net) as our primary task tracking system** with project key PTL, because the organization already has an active license, the team is familiar with Jira, and it provides native GitHub integration.

---

## Consequences / ผลที่ตามมา

### Positive / ผลดี
- ✅ ไม่ต้องเสียค่าใช้จ่ายเพิ่มเติม (มี license อยู่แล้ว)
- ✅ ทีมไม่ต้องเรียนรู้ tool ใหม่ ลด onboarding time
- ✅ Integration กับ GitHub Actions ผ่าน Jira API ทำได้ง่าย
- ✅ Stakeholders ที่ใช้ Jira ในโปรเจกต์อื่นเข้าใจ workflow ได้ทันที
- ✅ Advanced reporting และ roadmap features พร้อมใช้งาน

### Negative / ผลเสียที่ยอมรับได้
- ❌ Jira มี complexity สูง อาจ overkill สำหรับทีมเล็ก
- ❌ Jira ช้ากว่า lightweight alternatives เช่น Linear หรือ GitHub Issues
- ❌ ต้องตั้งค่า Jira workflow ใหม่ให้ตรงกับ SDLC framework ของเรา

### Neutral / เป็นกลาง
- ℹ️ ต้องตั้งค่า secrets (JIRA_API_TOKEN, JIRA_USER_EMAIL) ใน GitHub repository
- ℹ️ Jira board URL: https://snocko-main.atlassian.net/jira/software/projects/PTL/

---

## Alternatives Considered / ทางเลือกที่พิจารณา

### Option A: Jira (snocko-main.atlassian.net) ✅ Selected

**Pros**:
- มี license อยู่แล้ว ไม่เสียค่าใช้จ่ายเพิ่ม
- Team familiar
- Enterprise-grade features (roadmap, reporting, dashboards)
- Native Jira integration กับ tools อื่น ๆ ในองค์กร

**Cons**:
- Slow and complex UI
- Over-engineered สำหรับ phase เริ่มต้น

---

### Option B: GitHub Issues ❌ Rejected

**Pros**:
- Integrated กับ repository ทันที
- ฟรี
- Simple และเรียนรู้ง่าย

**Cons**:
- ขาด sprint planning, roadmap features ที่จำเป็นสำหรับ PM
- Reporting จำกัด
- Project board ยังไม่ mature เท่า Jira

---

### Option C: Linear ❌ Rejected

**Pros**:
- Fast, clean UX
- Great developer experience
- Good GitHub integration

**Cons**:
- ต้องซื้อ license ใหม่
- ไม่มีใครใน org รู้จัก — ต้อง onboard ทั้งทีม
- Organization ยังไม่มี standard สำหรับ Linear

---

## References / อ้างอิง

- Jira Project URL: https://snocko-main.atlassian.net/jira/software/projects/PTL/
- Jira REST API: https://developer.atlassian.com/cloud/jira/platform/rest/v3/
- GitHub Actions Jira integration: https://github.com/marketplace/actions/jira-issue
- config/tracking.yaml — Jira configuration details

---

*ADR-0001 Accepted: 2026-05-15 | Approved by: bovornsak.pan@snocko-tech.com*
