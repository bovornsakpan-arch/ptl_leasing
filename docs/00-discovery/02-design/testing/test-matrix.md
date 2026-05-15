---
doc_id: "PTL-TM-001"
title: "Test Matrix — PT Leasing"
project: ptl_leasing
type: test_case
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "02-design"
created_at: "2026-05-15"
updated_at: "2026-05-15"
---

# Test Matrix / เมทริกซ์การทดสอบ

---

## Browser Compatibility Matrix / เมทริกซ์ Browser

| Browser | Version | Desktop | Mobile | Status |
|---------|---------|---------|--------|--------|
| Chrome | 90+ | Required | N/A (Backoffice) | TBD |
| Firefox | 90+ | Required | N/A | TBD |
| Edge (Chromium) | 90+ | Required | N/A | TBD |
| Safari | 14+ | Optional | N/A | TBD |
| IE 11 | — | Not supported | — | — |

---

## Feature vs Test Type Matrix / Feature vs Test Type

| Feature | Unit | Integration | E2E | Performance | Security | UAT |
|---------|------|------------|-----|-------------|---------|-----|
| Authentication | TBD | TBD | TBD | TBD | TBD | TBD |
| Contract Create | TBD | TBD | TBD | TBD | — | TBD |
| Contract Approve | TBD | TBD | TBD | — | — | TBD |
| Payment Record | TBD | TBD | TBD | TBD | — | TBD |
| Customer KYC | TBD | TBD | TBD | — | TBD | TBD |
| Report Export | TBD | TBD | TBD | TBD | — | TBD |

**Legend**: TBD = To Be Defined | ✅ Pass | ❌ Fail | ⏭️ Skipped | — = Not Applicable

---

## Role vs Feature Access Matrix / Role vs Feature

| Feature | ADMIN | MANAGER | OFFICER | VIEWER |
|---------|-------|---------|---------|--------|
| View contracts | ✅ | ✅ | ✅ (own) | ✅ |
| Create contract | ✅ | ✅ | ✅ | ❌ |
| Approve contract | ✅ | ✅ | ❌ | ❌ |
| Delete contract | ✅ | ❌ | ❌ | ❌ |
| View customers | ✅ | ✅ | ✅ | ✅ |
| Create customer | ✅ | ✅ | ✅ | ❌ |
| View reports | ✅ | ✅ | ❌ | ❌ |
| Manage users | ✅ | ❌ | ❌ | ❌ |
| System config | ✅ | ❌ | ❌ | ❌ |

*(กรอกรายละเอียดหลังได้รับ requirements ด้าน permissions)*

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
