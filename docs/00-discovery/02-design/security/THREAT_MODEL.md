---
doc_id: "PTL-TH-001"
title: "Threat Model — PT Leasing"
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

# Threat Model / แบบจำลองภัยคุกคาม

> **Version**: 0.1.0 | **Framework**: STRIDE

---

## STRIDE Threat Categories

| Category | ย่อ | คำอธิบาย |
|---------|-----|---------|
| Spoofing | S | การปลอมตัวเป็นผู้ใช้/ระบบอื่น |
| Tampering | T | การแก้ไขข้อมูลโดยไม่ได้รับอนุญาต |
| Repudiation | R | การปฏิเสธว่าไม่ได้ทำ action |
| Information Disclosure | I | การเปิดเผยข้อมูลที่ไม่ควรเปิดเผย |
| Denial of Service | D | การทำให้ระบบไม่พร้อมใช้งาน |
| Elevation of Privilege | E | การยกระดับสิทธิ์โดยไม่ได้รับอนุญาต |

---

## Threat Scenarios / สถานการณ์ภัยคุกคาม

| ID | Category | Threat | Attack Vector | Likelihood | Impact | Risk | Mitigation |
|----|---------|--------|--------------|-----------|--------|------|-----------|
| T-001 | S | ขโมย session token | XSS | Medium | High | High | HTTPOnly cookies, CSP headers |
| T-002 | S | Credential brute force | Login endpoint | Medium | High | High | Rate limit, account lockout |
| T-003 | T | SQL Injection | User input | Medium | Critical | Critical | Parameterized queries (ORM) |
| T-004 | T | แก้ไขข้อมูลสัญญา | API call | Low | High | Medium | RBAC, audit log |
| T-005 | R | ปฏิเสธการทำ transaction | No audit log | Low | Medium | Low | Immutable audit log |
| T-006 | I | Data breach จาก DB | SQL Injection | Low | Critical | High | Encryption, input validation |
| T-007 | I | Sensitive data ใน logs | Logging error | Medium | High | High | Log masking, PII filter |
| T-008 | D | DDoS attack | Network | Medium | High | High | WAF, rate limiting, CDN |
| T-009 | D | Resource exhaustion | Large queries | Medium | Medium | Medium | Query timeout, pagination |
| T-010 | E | Privilege escalation | Role bypass | Low | Critical | High | Server-side authorization |
| T-011 | I | API key exposure | Accidental commit | Low | High | Medium | Git secrets scanning, env vars |
| T-012 | T | CSRF attack | Forged request | Medium | High | High | CSRF tokens, SameSite cookies |

---

## Security Controls Mapping / การ Map Controls

| Threat ID | Control |
|-----------|---------|
| T-001 | Content Security Policy, HTTPOnly cookies |
| T-002 | Rate limiting (express-rate-limit), account lockout |
| T-003 | Prisma ORM (parameterized), Joi validation |
| T-004 | RBAC middleware, audit logging |
| T-005 | Append-only audit log, immutable records |
| T-006 | AES-256 encryption, access control |
| T-007 | Winston log filter for PII fields |
| T-008 | Nginx rate limit, WAF, Cloud DDoS protection |
| T-009 | Query timeout config, pagination limits |
| T-010 | Server-side role check (never trust client) |
| T-011 | GitHub secret scanning, .env in .gitignore |
| T-012 | CSRF token middleware (csurf) |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
