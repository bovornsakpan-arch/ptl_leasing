---
doc_id: "PTL-FXXX-TC"
title: "Test Cases: [Feature Name]"
project: ptl_leasing
type: test_case
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "02-design"
feature_id: "F-XXX"
jira_issue: "PTL-XXX"
created_at: "YYYY-MM-DD"
updated_at: "YYYY-MM-DD"
reviewed_by: ""
approved_by: ""
---

# Test Cases: [Feature Name]
# กรณีทดสอบ

> **Feature ID**: F-XXX | **Version**: 0.1.0 | **Based on AC**: PTL-FXXX-AC

---

## Test Summary / สรุปการทดสอบ

| Item | Value |
|------|-------|
| Feature | [Feature Name] |
| Test Environment | Staging |
| Browser/Platform | Chrome 90+, Firefox 90+ |
| Prerequisites | User account with role [X], test data loaded |
| Total Test Cases | X |
| Estimated Duration | X hours |

---

## Preconditions / เงื่อนไขก่อนทดสอบ

1. ระบบ staging พร้อมใช้งาน
2. Test data: [ระบุ test data ที่ต้องการ]
3. Test user accounts: [ระบุ accounts]
4. External services: [ระบุ mock/stub ที่ต้องการ]

---

## Test Cases / กรณีทดสอบ

### TC-F-XXX-001: [Test Case Title — Happy Path]

| Field | Value |
|-------|-------|
| **Test ID** | TC-F-XXX-001 |
| **Feature** | [Feature Name] |
| **Related AC** | AC-F-XXX-001 |
| **Priority** | High / Medium / Low |
| **Type** | Functional |
| **Preconditions** | ผู้ใช้ login แล้ว มีสิทธิ์ [role] |

**Test Steps**:

| Step | Action | Expected Result | Actual Result | Pass/Fail |
|------|--------|----------------|--------------|-----------|
| 1 | เปิดหน้า [page name] | หน้าโหลดสำเร็จ แสดง [elements] | | |
| 2 | กรอกข้อมูล field A = "test value" | field A รับค่าได้ | | |
| 3 | กดปุ่ม Submit | - Loading indicator แสดงขึ้น<br>- API POST /api/... ถูกเรียก<br>- Success message แสดง | | |
| 4 | ตรวจสอบข้อมูลในระบบ | ข้อมูลถูกบันทึกถูกต้อง | | |

**Expected Final Result**: [ผลลัพธ์สุดท้ายที่คาดหวัง]

**Test Data**:
```json
{
  "field_a": "test value",
  "field_b": 12345
}
```

---

### TC-F-XXX-002: [Test Case Title — Validation]

| Field | Value |
|-------|-------|
| **Test ID** | TC-F-XXX-002 |
| **Feature** | [Feature Name] |
| **Related AC** | AC-F-XXX-002 |
| **Priority** | High |
| **Type** | Functional — Negative |
| **Preconditions** | ผู้ใช้ login แล้ว |

**Test Steps**:

| Step | Action | Expected Result | Actual Result | Pass/Fail |
|------|--------|----------------|--------------|-----------|
| 1 | เปิดหน้า [page name] | หน้าโหลดสำเร็จ | | |
| 2 | ปล่อย required field ว่าง | | | |
| 3 | กดปุ่ม Submit | Error message: "กรุณากรอก [field name]" แสดงที่ field | | |
| 4 | ตรวจสอบ API call | ไม่มี API call ถูกส่ง | | |

---

### TC-F-XXX-003: [Test Case Title — Authorization]

| Field | Value |
|-------|-------|
| **Test ID** | TC-F-XXX-003 |
| **Related AC** | AC-F-XXX-004 |
| **Priority** | High |
| **Type** | Security |
| **Preconditions** | มี user 2 accounts: role OFFICER, role MANAGER |

**Test Steps**:

| Step | Action | Expected Result | Actual Result | Pass/Fail |
|------|--------|----------------|--------------|-----------|
| 1 | Login ด้วย user role OFFICER | Login สำเร็จ | | |
| 2 | เข้าหน้า [restricted page] | Redirect ไปหน้า 403 หรือปุ่มไม่แสดง | | |
| 3 | Logout, Login ด้วย user role MANAGER | Login สำเร็จ | | |
| 4 | เข้าหน้า [restricted page] | เข้าถึงได้ปกติ | | |

---

## Test Results Summary / สรุปผลการทดสอบ

| Test ID | Test Case | Priority | Status | Tester | Date | Defect ID |
|---------|-----------|---------|--------|--------|------|-----------|
| TC-F-XXX-001 | [Happy path] | High | Not Run | | | |
| TC-F-XXX-002 | [Validation] | High | Not Run | | | |
| TC-F-XXX-003 | [Authorization] | High | Not Run | | | |

**Status Legend**: Not Run / Pass / Fail / Blocked / Skipped

---

## Defects Found / Defect ที่พบ

| Defect ID | Test Case | Severity | Description | Status |
|-----------|-----------|---------|-------------|--------|
| *(ยังไม่มี)* | | | | |

**Severity Levels**: Critical / High / Medium / Low

---

## Sign-off / การอนุมัติ

| Role | Name | Status | Date |
|------|------|--------|------|
| QA Lead | | Pending | |
| BA | Orawan Nus | Pending | |
| PM | Bovornsak Pan | Pending | |

---

*เอกสารนี้สร้างโดย PT Leasing SDLC Framework — templates/TEST_CASE.template.md*
