---
doc_id: "PTL-ISO-BCP-001"
title: "Business Continuity Plan — PT Leasing"
project: ptl_leasing
type: security_design
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Business Continuity Plan / แผนความต่อเนื่องทางธุรกิจ

> **Version**: 0.1.0 | **ISO27001:2022**: A.5.29, A.5.30

---

## Overview / ภาพรวม

เอกสารนี้กำหนดแผนความต่อเนื่องทางธุรกิจสำหรับระบบ PT Leasing Backoffice เพื่อให้ธุรกิจสามารถดำเนินต่อได้แม้เกิดเหตุการณ์ไม่คาดฝัน

---

## Recovery Objectives / วัตถุประสงค์การกู้คืน

| Metric | Target | Description |
|--------|--------|-------------|
| **RTO** (Recovery Time Objective) | 4 ชั่วโมง | ระยะเวลาสูงสุดที่ระบบจะหยุดทำงานได้ |
| **RPO** (Recovery Point Objective) | 1 ชั่วโมง | ข้อมูลสูงสุดที่ยอมรับการสูญเสียได้ |
| **MTTR** (Mean Time To Recovery) | 2 ชั่วโมง | เวลาเฉลี่ยในการกู้คืน |

---

## Critical Business Functions / ฟังก์ชันธุรกิจที่สำคัญ

| Function | Priority | RTO | RPO |
|---------|---------|-----|-----|
| Login / Authentication | Critical | 1 hr | 0 |
| Contract management | Critical | 4 hr | 1 hr |
| Payment processing | Critical | 4 hr | 1 hr |
| Customer data access | High | 4 hr | 1 hr |
| Reports | Medium | 8 hr | 4 hr |
| Notifications | Low | 24 hr | 4 hr |

---

## Backup Strategy / กลยุทธ์การสำรองข้อมูล

| Data | Backup Type | Frequency | Retention | Location |
|------|------------|---------|----------|---------|
| PostgreSQL (full) | Full backup | Daily at 2:00 AM | 30 วัน | Cloud storage (encrypted) |
| PostgreSQL (incremental) | WAL archiving | Continuous | 7 วัน | Cloud storage |
| File/Documents (S3) | Cross-region replication | Real-time | 90 วัน | Secondary region |
| Redis (cache) | No backup | — | — | Rebuild on restart |
| Application config | Git | On change | Indefinite | GitHub |
| Secrets | Vault backup | Daily | 90 วัน | Encrypted backup |

### Backup Verification
- ทดสอบ restore จาก backup ทุก**เดือน**
- บันทึกผลการทดสอบใน [docs/iso27001/backup-test-log.md]

---

## Disaster Recovery Scenarios / สถานการณ์ Disaster Recovery

### Scenario 1: Database Failure

1. ตรวจจับ: database health check ล้มเหลว
2. Failover ไปยัง read replica ภายใน 5 นาที (automatic)
3. Promote replica เป็น primary
4. Point application ไปยัง new primary
5. Restore จาก backup ถ้าจำเป็น
6. แจ้ง team และ monitor

**RTO**: 30-60 นาที | **RPO**: < 5 นาที

---

### Scenario 2: Application Server Failure

1. Load balancer detect: server not responding
2. Traffic route ไปยัง healthy server อัตโนมัติ
3. Auto-scaling launch new instance
4. Monitor new instance healthy
5. Investigate and fix failed server

**RTO**: 5-10 นาที | **RPO**: N/A

---

### Scenario 3: Cloud Region Outage

1. ตรวจจับ: complete region unavailability
2. DNS failover ไปยัง secondary region (ต้อง manual)
3. Restore latest backup ใน secondary region
4. Update DNS records
5. Verify functionality

**RTO**: 2-4 ชั่วโมง | **RPO**: < 1 ชั่วโมง

---

## BCP Testing Schedule / ตารางทดสอบ BCP

| Test Type | Frequency | Last Test | Next Test |
|-----------|-----------|-----------|---------|
| Backup restoration test | Monthly | 2026-05-15 | 2026-06-15 |
| Failover drill | Quarterly | — | 2026-08-15 |
| Full DR simulation | Annually | — | 2027-05-15 |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
