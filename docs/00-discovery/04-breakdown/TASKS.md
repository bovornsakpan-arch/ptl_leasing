---
doc_id: "PTL-TASKS-001"
title: "Task Breakdown — PT Leasing"
project: ptl_leasing
type: requirements
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "04-breakdown"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Task Breakdown / การแบ่ง Tasks

> **Version**: 0.1.0 | **Status**: Draft

---

## Overview / ภาพรวม

เอกสารนี้แบ่ง User Stories ออกเป็น technical tasks สำหรับ Dev team
แต่ละ task มีขนาด < 1 day (8 hours) เพื่อให้ track ได้ง่าย

---

## Task Template

| Field | Description |
|-------|-------------|
| Task ID | T-XXX |
| Story | S-XXX |
| Description | อธิบาย technical work ที่ต้องทำ |
| Type | Backend / Frontend / DB / Infra / Testing |
| Estimate | X hours |
| Assigned To | *(Dev name)* |
| Sprint | Sprint X |
| Jira | PTL-XXX |

---

## Tasks by Story / Tasks ตาม Story

### S-001: Login Feature

*(กรอกหลัง stories ได้รับ approval)*

| Task ID | Description | Type | Est. (hrs) | Assigned | Status |
|---------|-------------|------|-----------|---------|--------|
| T-001 | Create POST /auth/login endpoint | Backend | 4 | TBD | Not Started |
| T-002 | Implement bcrypt password verification | Backend | 2 | TBD | Not Started |
| T-003 | Implement JWT generation | Backend | 2 | TBD | Not Started |
| T-004 | Create login page UI | Frontend | 4 | TBD | Not Started |
| T-005 | Implement form validation | Frontend | 2 | TBD | Not Started |
| T-006 | Write unit tests for auth service | Testing | 3 | TBD | Not Started |
| T-007 | Write E2E test for login flow | Testing | 2 | TBD | Not Started |

---

## Sprint Allocation / การจัดสรรใส่ Sprint

*(กรอกหลัง planning session)*

| Sprint | Story Points | Stories |
|--------|-------------|---------|
| Sprint 1 | TBD | TBD |
| Sprint 2 | TBD | TBD |

---

## Team Capacity / ความสามารถของทีม

| Member | Role | Capacity (pts/sprint) |
|--------|------|---------------------|
| TBD | Dev | TBD |
| TBD | Dev | TBD |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
