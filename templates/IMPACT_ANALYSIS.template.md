---
doc_id: "PTL-CRXXX-IMPACT"
title: "Impact Analysis: [Change Name]"
project: ptl_leasing
type: impact_analysis
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
phase: "01-requirements"
cr_id: "CR-XXX"
feature_id: "F-XXX"
jira_issue: "PTL-XXX"
created_at: "YYYY-MM-DD"
updated_at: "YYYY-MM-DD"
reviewed_by: ""
approved_by: ""
---

# Impact Analysis: [Change Name]
# การวิเคราะห์ผลกระทบของการเปลี่ยนแปลง

> **CR ID**: CR-XXX | **Feature**: F-XXX | **Version**: 0.1.0

---

## 1. Change Summary / สรุปการเปลี่ยนแปลง

*(สรุป CR ที่วิเคราะห์ — อ่านรายละเอียดได้จาก BRD.md และ GAP_ANALYSIS.md)*

---

## 2. Affected Systems / ระบบที่ได้รับผลกระทบ

### 2.1 Application Components / ส่วนประกอบของแอปพลิเคชัน

| Component | Impact Type | Severity | Description |
|-----------|------------|---------|-------------|
| Module/Service A | Modify | High | ต้องแก้ไข logic X |
| Module/Service B | Add | Medium | ต้องเพิ่ม feature Y |
| Module/Service C | None | N/A | ไม่ได้รับผลกระทบ |

### 2.2 APIs Affected / API ที่ได้รับผลกระทบ

| API Endpoint | Method | Impact | Backward Compatible? | Changes Required |
|-------------|--------|--------|---------------------|-----------------|
| `/api/v1/contracts` | GET | Modify | Yes (add optional fields) | Add fields: x, y, z |
| `/api/v1/contracts/{id}` | PUT | Modify | No — breaking change | Change field type |
| `/api/v1/payments` | POST | None | — | No change |
| `/api/v2/leases` | GET | Add | — | New endpoint |

**Breaking Changes**: *(รายการ API ที่ไม่ backward compatible)*
- `PUT /api/v1/contracts/{id}` — field `status` type changed from string to enum

**Migration Path**: *(แผนการรองรับ client เก่า)*
- เพิ่ม API version v2 สำหรับ breaking changes
- Deprecate v1 หลังจาก X เดือน

### 2.3 Database / ฐานข้อมูล

| Table / Collection | Impact | Migration Required | Changes |
|-------------------|--------|-------------------|---------|
| `contracts` | Modify | Yes | ADD COLUMN `renewal_date DATE` |
| `customers` | Modify | Yes | ADD COLUMN `risk_score DECIMAL(5,2)` |
| `payments` | None | No | ไม่มีการเปลี่ยนแปลง |

**Database Migration Script Outline**:
```sql
-- Migration: CR-XXX changes
-- Author: [SA name]
-- Date: YYYY-MM-DD

-- Step 1: Add new columns
ALTER TABLE contracts ADD COLUMN renewal_date DATE;
ALTER TABLE customers ADD COLUMN risk_score DECIMAL(5,2);

-- Step 2: Backfill existing data
UPDATE contracts SET renewal_date = end_date + INTERVAL '1 year'
WHERE renewal_date IS NULL;

-- Step 3: Add constraints
ALTER TABLE contracts ALTER COLUMN renewal_date SET NOT NULL;
```

### 2.4 UI/UX Screens / หน้าจอที่ได้รับผลกระทบ

| Screen | Impact | Changes Required |
|--------|--------|-----------------|
| Contract List | Modify | Add column: Renewal Date |
| Contract Detail | Modify | Add section: Renewal Info |
| Customer Profile | Add | Add Risk Score widget |
| Dashboard | Modify | Update chart to include new data |

### 2.5 Third-Party Integrations / การเชื่อมต่อกับระบบภายนอก

| System | Impact | Type | Action Required |
|--------|--------|------|----------------|
| Credit Bureau API | None | External | No change |
| Payment Gateway | Modify | External | Update webhook config |
| Email Service | None | External | No change |

---

## 3. Risk Level Matrix / เมทริกซ์ระดับความเสี่ยง

*(ประเมินความเสี่ยงของแต่ละ change)*

| Change Item | Likelihood (1-5) | Impact (1-5) | Risk Score | Level |
|-------------|-----------------|-------------|-----------|-------|
| DB migration failure | 2 | 5 | 10 | High |
| API breaking change | 3 | 4 | 12 | High |
| UI regression | 3 | 2 | 6 | Medium |
| Performance degradation | 2 | 3 | 6 | Medium |
| Security vulnerability | 1 | 5 | 5 | Medium |

**Risk Score = Likelihood × Impact**
- **Critical**: 16-25
- **High**: 10-15
- **Medium**: 5-9
- **Low**: 1-4

### Risk Mitigation Actions

| Risk | Mitigation Strategy | Owner | Due |
|------|-------------------|-------|-----|
| DB migration failure | Test migration script on staging ×3 times before prod | Dev/DBA | Before deploy |
| API breaking change | Create v2 API, keep v1 for 3 months | SA/Dev | Sprint 1 |
| Performance degradation | Load test after changes | QA | Sprint 2 |

---

## 4. Rollback Plan / แผนการย้อนกลับ

### 4.1 Rollback Conditions / เงื่อนไขการ Rollback

*(เมื่อไหร่ถึงต้อง rollback)*
- Error rate > X% ภายใน Y นาทีหลัง deploy
- Response time > X ms (p95) เป็นเวลานาน Y นาที
- Critical bug ที่ทำให้ใช้งานไม่ได้

### 4.2 Rollback Steps / ขั้นตอนการ Rollback

1. **Application**: Deploy previous Docker image version
   ```bash
   docker pull registry/app:previous-version
   docker service update --image registry/app:previous-version app-service
   ```

2. **Database**: Run rollback migration
   ```sql
   -- Rollback: CR-XXX changes
   ALTER TABLE contracts DROP COLUMN IF EXISTS renewal_date;
   ALTER TABLE customers DROP COLUMN IF EXISTS risk_score;
   ```

3. **API**: Revert API gateway routing to v1
4. **Verification**: Run smoke tests to confirm rollback successful

### 4.3 Rollback Time Estimate

- Application rollback: ~5 minutes
- Database rollback: ~15 minutes (ขึ้นอยู่กับขนาด data)
- Full rollback time: ~30 minutes

---

## 5. Migration Plan / แผนการ Migration

### 5.1 Pre-deployment / ก่อน deploy

| Step | Action | Owner | ETA |
|------|--------|-------|-----|
| 1 | Test migration script on staging | Dev/DBA | D-5 |
| 2 | Backup production database | Infra | D-1 |
| 3 | Notify affected teams of planned change | PM | D-1 |
| 4 | Prepare rollback scripts | Dev | D-1 |

### 5.2 Deployment Sequence / ลำดับการ deploy

1. Take database backup
2. Run database migration
3. Verify migration success
4. Deploy new application version
5. Smoke test
6. Monitor for 1 hour
7. Notify stakeholders of completion

### 5.3 Post-deployment / หลัง deploy

| Step | Action | Owner | ETA |
|------|--------|-------|-----|
| 1 | Monitor error rates for 24h | Infra/Dev | D+1 |
| 2 | Run full regression test | QA | D+1 |
| 3 | Update documentation | BA/SA | D+2 |
| 4 | Close CR in Jira | PM | D+2 |

---

## 6. Testing Requirements / ความต้องการด้านการทดสอบ

| Test Type | Scope | Who | When |
|-----------|-------|-----|------|
| Unit Tests | All changed functions | Dev | During development |
| Integration Tests | Changed APIs | Dev/QA | Before merge |
| Regression Tests | All affected screens | QA | Before UAT |
| UAT | Business scenarios | Business Owner | After QA |
| Performance Tests | High-traffic endpoints | QA/Infra | Before deploy |
| Security Tests | Auth changes (if any) | SA/Infra | Before deploy |

---

*เอกสารนี้สร้างโดย PT Leasing SDLC Framework — templates/IMPACT_ANALYSIS.template.md*
