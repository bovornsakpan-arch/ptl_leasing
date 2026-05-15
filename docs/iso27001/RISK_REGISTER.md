---
doc_id: "PTL-ISO-RISK-001"
title: "Risk Register — PT Leasing ISO27001"
project: ptl_leasing
type: security_design
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
phase: "02-design"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Risk Register / ทะเบียนความเสี่ยง

> **Version**: 0.1.0 | **Framework**: ISO27001:2022 Clause 6.1.2
> **Review Frequency**: Quarterly

---

## Risk Scoring Methodology / วิธีคำนวณคะแนนความเสี่ยง

- **Likelihood**: 1 (Very Low) – 5 (Very High)
- **Impact**: 1 (Negligible) – 5 (Catastrophic)
- **Risk Score** = Likelihood × Impact
  - 1-4: Low
  - 5-9: Medium
  - 10-15: High
  - 16-25: Critical

---

## Risk Register / ทะเบียน

| Risk ID | Category | Description | Likelihood | Impact | Score | Level | Mitigation | Owner | Status |
|---------|---------|-------------|-----------|--------|-------|-------|-----------|-------|--------|
| R-001 | Data Security | SQL injection attack ที่ทำให้ข้อมูลลูกค้ารั่ว | 3 | 5 | 15 | High | Parameterized queries, WAF, regular security testing | SA | Active |
| R-002 | Data Security | Unauthorized access to financial data | 3 | 5 | 15 | High | RBAC, MFA, access log monitoring | SA + Infra | Active |
| R-003 | Data Security | ข้อมูลลูกค้า (PII) รั่วไหลจากพนักงาน | 2 | 5 | 10 | High | DLP, audit logs, NDA, training | PM + HR | Active |
| R-004 | Availability | DDoS attack ทำให้ระบบไม่พร้อมใช้งาน | 2 | 4 | 8 | Medium | WAF, rate limiting, CDN | Infra | Active |
| R-005 | Availability | Database failure / data loss | 2 | 5 | 10 | High | Daily backups, replication, RTO/RPO plan | Infra | Active |
| R-006 | Compliance | ไม่สอดคล้อง PDPA — เก็บข้อมูลเกินความจำเป็น | 2 | 4 | 8 | Medium | Data minimization, retention policy, DPIA | SA + Legal | Active |
| R-007 | Compliance | AML/KYC ไม่ครบถ้วน — ผิด BOT regulations | 2 | 5 | 10 | High | Automated KYC checks, regular compliance review | BA + Legal | Active |
| R-008 | Operational | System downtime during month-end processing | 3 | 4 | 12 | High | Load testing, capacity planning, maintenance window | Infra + Dev | Active |
| R-009 | Security | Weak passwords / credential compromise | 3 | 4 | 12 | High | Password policy, MFA, account lockout | Infra + Dev | Active |
| R-010 | Security | Phishing attack targeting employees | 3 | 3 | 9 | Medium | Security awareness training, email filtering | HR + IT | Active |
| R-011 | Third-party | Credit bureau API downtime | 3 | 3 | 9 | Medium | Fallback procedure, cache credit scores | Dev + BA | Active |
| R-012 | Operational | Key person dependency — SA/Dev leaves | 2 | 4 | 8 | Medium | Documentation, knowledge transfer | PM | Active |
| R-013 | Data Security | Backup not tested — recovery fails | 2 | 5 | 10 | High | Monthly backup restoration tests | Infra | Active |
| R-014 | Physical | Unauthorized physical access to servers | 1 | 4 | 4 | Low | Cloud hosting with physical security | Infra | Accepted |
| R-015 | Security | Vulnerable third-party dependencies | 3 | 3 | 9 | Medium | Automated dependency scanning (Snyk), update policy | Dev | Active |

---

## Risk Treatment Options / แนวทางการจัดการความเสี่ยง

| Treatment | คำอธิบาย |
|-----------|---------|
| **Mitigate** | ลดความเสี่ยงด้วย controls |
| **Accept** | ยอมรับความเสี่ยง (low risk) |
| **Transfer** | โอนความเสี่ยง (เช่น insurance) |
| **Avoid** | หลีกเลี่ยงกิจกรรมที่ก่อความเสี่ยง |

---

## Risk Review History / ประวัติการ Review

| Date | Reviewer | Changes |
|------|---------|---------|
| 2026-05-15 | Siriporn San | Initial assessment |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
