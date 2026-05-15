---
doc_id: "PTL-ISO-IR-001"
title: "Incident Response — PT Leasing"
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

# Incident Response / การตอบสนองต่อเหตุการณ์ด้านความปลอดภัย

> **Version**: 0.1.0 | **ISO27001:2022**: A.5.24, A.5.25, A.5.26, A.5.27

---

## Incident Severity Levels / ระดับความรุนแรง

| Level | คำอธิบาย | ตัวอย่าง | Response Time |
|-------|---------|---------|--------------|
| P1 Critical | ระบบหยุดทำงาน / data breach | Production down, ข้อมูลรั่ว | 15 นาที |
| P2 High | Feature หลักไม่ทำงาน / security breach | Login ล้มเหลว, unauthorized access | 1 ชั่วโมง |
| P3 Medium | Feature รองไม่ทำงาน | Report ไม่ถูกต้อง, slow response | 4 ชั่วโมง |
| P4 Low | Minor issues | UI bug, typo | 1 วันทำการ |

---

## Incident Response Team / ทีมตอบสนอง

| Role | Name | Contact | Responsibility |
|------|------|---------|---------------|
| Incident Commander | PM: Bovornsak Pan | bovornsak.pan@snocko-tech.com | Coordinate response |
| Technical Lead | SA: Siriporn San | siriporn.san@snocko-tech.com | Technical investigation |
| Infrastructure | Infra (TBD) | TBD | System recovery |
| Communication | PM | bovornsak.pan@snocko-tech.com | Stakeholder communication |
| Legal/Compliance | Legal (TBD) | TBD | Regulatory requirements |

---

## Incident Response Process / กระบวนการตอบสนอง

### Phase 1: Detection & Classification (0-15 min)

1. ตรวจพบ incident จาก: monitoring alert, user report, 3rd party notification
2. ประเมินระดับความรุนแรง (P1-P4)
3. เปิด incident ticket ใน Jira
4. แจ้ง Incident Commander

### Phase 2: Containment (15 min - 2 hr)

1. Isolate affected systems ถ้าจำเป็น
2. ป้องกัน incident ลุกลาม
3. Preserve evidence (logs, screenshots)
4. อัปเดต status page (ถ้ามี)

**สำหรับ Data Breach**:
- Block access ทันที
- ประเมินขอบเขตของข้อมูลที่รั่ว
- แจ้ง PDPO ภายใน 72 ชั่วโมง (ถ้าจำเป็นตาม PDPA)

### Phase 3: Investigation (2-24 hr)

1. วิเคราะห์ root cause
2. ตรวจสอบ audit logs
3. ระบุ scope และผลกระทบ
4. Document findings

### Phase 4: Recovery

1. Apply fix หรือ rollback
2. Verify system restored
3. Monitor closely หลัง recovery
4. ทดสอบ fix ใน staging ก่อน production

### Phase 5: Post-Incident Review

1. จัด post-mortem ภายใน 5 วันทำการ
2. เขียน incident report
3. ระบุ lessons learned
4. Update ขั้นตอนป้องกัน

---

## Notification Requirements / ข้อกำหนดการแจ้ง

| Scenario | Who to Notify | Timeline |
|----------|--------------|---------|
| Production outage | All team + stakeholders | ทันที |
| Data breach | Legal, Management, PDPO | 72 ชั่วโมง (PDPA) |
| Security incident | Management, Legal | 24 ชั่วโมง |
| Affected customers | Customers | ตามคำแนะนำ Legal |

---

## Incident Log / บันทึก Incident

| Date | ID | Type | Severity | Status | Resolution |
|------|-----|------|---------|--------|-----------|
| *(ยังไม่มี)* | | | | | |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
