---
doc_id: "PTL-TS-001"
title: "Test Strategy — PT Leasing"
project: ptl_leasing
type: test_strategy
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "02-design"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Test Strategy / กลยุทธ์การทดสอบ

> **Version**: 0.1.0 | **Status**: Draft

---

## Overview / ภาพรวม

เอกสารนี้กำหนดกลยุทธ์การทดสอบสำหรับระบบ PT Leasing Backoffice ครอบคลุมทุก test level และ test type

---

## Testing Pyramid / พีระมิดการทดสอบ

```
          /\
         /E2E\          (10%) — Playwright/Cypress
        /------\
       /Integration\    (20%) — API + DB integration tests
      /------------\
     /  Unit Tests  \   (70%) — Vitest/Jest
    /________________\
```

**Target Coverage**: ≥ 80% overall, ≥ 90% critical paths (contract create, payment, auth)

---

## Test Types / ประเภทการทดสอบ

### 1. Unit Testing
- **Tool**: Vitest (Frontend) + Jest (Backend)
- **Scope**: Individual functions, components, services
- **Coverage Target**: ≥ 80%
- **Runs**: On every commit (CI)
- **Owner**: Dev

### 2. Integration Testing
- **Tool**: Supertest (API) + Testing Library
- **Scope**: API endpoints + DB operations
- **Coverage Target**: All endpoints
- **Runs**: On PR (CI)
- **Owner**: Dev + QA

### 3. End-to-End Testing
- **Tool**: Playwright
- **Scope**: Critical user journeys
- **Key scenarios**:
  - Login / Logout
  - Create and approve contract
  - Record payment
  - Generate report
- **Runs**: Before deployment
- **Owner**: QA

### 4. Performance Testing
- **Tool**: k6
- **Scenarios**:
  - Load test: 100 concurrent users
  - Stress test: Gradually increase to 500 users
  - Spike test: Sudden surge
- **Thresholds**:
  - p95 response time < 2 seconds
  - Error rate < 1%
- **Runs**: Pre-release
- **Owner**: QA + Infra

### 5. Security Testing
- **Tool**: OWASP ZAP, npm audit, Snyk
- **Scope**: OWASP Top 10, dependency vulnerabilities
- **Runs**: Monthly + before major releases
- **Owner**: SA + Infra

### 6. UAT (User Acceptance Testing)
- **Tool**: Manual
- **Scope**: Business scenarios per feature
- **Tester**: Business Owner + End Users
- **Environment**: Staging
- **Runs**: Before go-live per feature

---

## Test Environments / สภาพแวดล้อมการทดสอบ

| Environment | Purpose | Data | Access |
|-------------|---------|------|--------|
| Development | Unit/Integration | Seeded test data | Dev only |
| Staging | QA, UAT | Anonymized production-like | Dev, QA, PM |
| Production | Smoke test post-deploy | Real data | Ops only |

---

## Quality Gates / เกณฑ์คุณภาพ

ต้องผ่านทั้งหมดก่อน deploy:

| Gate | Criteria |
|------|---------|
| Unit tests | Pass, coverage ≥ 80% |
| Integration tests | Pass (100%) |
| E2E critical paths | Pass (100%) |
| Security scan | No Critical/High vulnerabilities |
| Performance test | p95 < 2s, error < 1% |
| UAT sign-off | Business Owner approved |

---

## Bug Severity Levels / ระดับความรุนแรงของ Bug

| Level | Definition | SLA to Fix |
|-------|-----------|-----------|
| Critical | ระบบใช้งานไม่ได้ / data loss | ทันที |
| High | Feature หลักใช้ไม่ได้ | 24 ชั่วโมง |
| Medium | Feature รอง/workaround มี | 1 sprint |
| Low | Cosmetic / minor inconvenience | Backlog |

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: orawan.nus@snocko-tech.com*
