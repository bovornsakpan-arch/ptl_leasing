---
doc_id: "PTL-FXXX-SRS"
title: "SRS: [Feature Name]"
project: ptl_leasing
type: srs
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
phase: "02-design"
feature_id: "F-XXX"
jira_issue: "PTL-XXX"
created_at: "YYYY-MM-DD"
updated_at: "YYYY-MM-DD"
reviewed_by: ""
approved_by: ""
---

# SRS: [Feature Name]
# Software Requirements Specification — ข้อกำหนดความต้องการซอฟต์แวร์

> **Feature ID**: F-XXX | **Version**: 0.1.0 | **Based on BRD**: PTL-FXXX-BRD v0.1.0

---

## 1. Introduction / บทนำ

### 1.1 Purpose / วัตถุประสงค์

เอกสารนี้กำหนดความต้องการซอฟต์แวร์สำหรับ [Feature Name] ซึ่งเป็นส่วนหนึ่งของระบบ PT Leasing Backoffice

### 1.2 Scope / ขอบเขต

*(ระบุขอบเขตของ SRS นี้ — อ้างอิง BRD)*

### 1.3 Document Conventions / ข้อตกลงในเอกสาร

- **SHALL / MUST**: ข้อกำหนดที่บังคับ
- **SHOULD**: ข้อกำหนดที่แนะนำ
- **MAY / COULD**: ข้อกำหนดที่เป็นทางเลือก

---

## 2. Functional Requirements / ความต้องการด้านฟังก์ชัน

### 2.1 Functional Requirements Table / ตารางความต้องการด้านฟังก์ชัน

| Req ID | Description | Priority | Source | Status |
|--------|-------------|---------|--------|--------|
| FR-001 | ระบบ SHALL แสดงรายการสัญญาเช่าทั้งหมดที่ผู้ใช้มีสิทธิ์เข้าถึง | Must | BRD §3.2 | Draft |
| FR-002 | ระบบ SHALL รองรับการค้นหาสัญญาตาม: รหัสสัญญา, ชื่อลูกค้า, สถานะ | Must | BRD §3.2 | Draft |
| FR-003 | ระบบ SHALL แสดงรายละเอียดสัญญาในหน้า detail | Must | BRD §3.2 | Draft |
| FR-004 | ระบบ SHOULD ส่ง email notification เมื่อสัญญาใกล้หมดอายุ | Should | BRD §3.3 | Draft |
| FR-005 | ระบบ MAY สนับสนุน bulk export เป็น Excel | Could | BRD §3.4 | Draft |

**Priority Levels**:
- **Must**: บังคับ ขาดไม่ได้
- **Should**: ควรมี แต่ขาดได้ชั่วคราว
- **Could**: มีก็ดี แต่ไม่ใช่ priority สูง
- **Won't**: ไม่รวมใน version นี้

### 2.2 Detailed Requirements / ความต้องการละเอียด

#### FR-001: แสดงรายการสัญญา

**Description**: ระบบต้องแสดงรายการสัญญาเช่าทั้งหมดที่ user มีสิทธิ์เข้าถึง โดยแสดง pagination

**Inputs**:
- User authentication token
- Filter parameters (optional): status, date range, customer name

**Processing**:
- Query database สำหรับ contracts ที่ user มีสิทธิ์
- Apply filters ถ้ามี
- Sort by created_date DESC (default)
- Paginate: 20 records per page

**Outputs**:
- List of contracts with fields: contract_id, customer_name, amount, status, start_date, end_date
- Total count for pagination
- Current page info

**Business Rules**:
- User ที่มี role OFFICER เห็นได้เฉพาะสัญญาที่ตัวเองเป็น handler
- User ที่มี role MANAGER เห็นได้ทุกสัญญา
- System Admin เห็นได้ทุกสัญญารวม deleted

#### FR-002: ค้นหาสัญญา

*(ใช้รูปแบบเดียวกับ FR-001)*

---

## 3. Non-Functional Requirements / ความต้องการที่ไม่ใช่ฟังก์ชัน

### 3.1 Performance / ประสิทธิภาพ

| Requirement | Target | Measurement |
|-------------|--------|------------|
| Page load time | < 2 seconds (p95) | Lighthouse / APM |
| API response time | < 500ms (p95) | APM |
| Database query time | < 100ms (p95) | DB monitoring |
| Concurrent users | Support 100 concurrent users | Load test |
| Throughput | 1000 requests/minute | Load test |

### 3.2 Security / ความปลอดภัย

| Requirement | Description |
|-------------|-------------|
| Authentication | ต้อง login ก่อนเข้าถึงทุก endpoint |
| Authorization | RBAC ตาม role ที่กำหนด |
| Data Encryption | HTTPS/TLS 1.2+ สำหรับ data in transit |
| Data at Rest | Encrypt sensitive fields (เช่น IC, bank account) |
| Audit Log | บันทึกทุก CRUD operation พร้อม timestamp, user, IP |
| Session | Session timeout หลัง 30 นาที inactive |
| PDPA | สอดคล้อง PDPA — มี consent mechanism |

### 3.3 Availability & Reliability / ความพร้อมใช้งาน

| Requirement | Target |
|-------------|--------|
| Uptime | 99.5% (ไม่รวม planned maintenance) |
| Recovery Time Objective (RTO) | < 4 hours |
| Recovery Point Objective (RPO) | < 1 hour |
| Backup frequency | Daily automated backup |

### 3.4 Usability / ความสะดวกในการใช้งาน

- รองรับ browser: Chrome 90+, Firefox 90+, Edge 90+
- Responsive สำหรับ desktop (1280px+) และ tablet (768px+)
- รองรับภาษาไทยและ English
- สอดคล้อง WCAG 2.1 Level AA (ถ้าเป็นไปได้)

### 3.5 Scalability / ความสามารถในการขยาย

- ระบบต้องรองรับการขยาย concurrent users ได้ถึง 500 users โดยไม่ต้องแก้ไข architecture หลัก
- Database ต้องรองรับ data growth 3 ปี ที่ประมาณ X records/month

### 3.6 Maintainability / ความสามารถในการดูแลรักษา

- Code coverage: unit test ≥ 80%
- API documentation ด้วย OpenAPI/Swagger
- Infrastructure as Code (IaC)
- Centralized logging

---

## 4. Constraints / ข้อจำกัด

| # | Constraint | Type | Impact |
|---|-----------|------|--------|
| C-001 | ต้องใช้ technology stack ที่กำหนดใน TECH_STACK.md | Technical | สูง |
| C-002 | ต้องสอดคล้อง PDPA พ.ร.บ. ปี 2562 | Regulatory | สูง |
| C-003 | ต้องผ่าน security review ก่อน deploy | Process | กลาง |
| C-004 | Budget ไม่เกิน [amount] | Budget | สูง |
| C-005 | ต้อง go-live ภายใน [date] | Timeline | สูง |

---

## 5. Glossary / คำศัพท์

*(คำศัพท์เฉพาะที่ใช้ใน SRS นี้ — ดูคำศัพท์ทั่วไปได้ที่ GLOSSARY.md)*

| Term | Definition |
|------|-----------|
| Contract | สัญญาเช่าระหว่างบริษัทและลูกค้า |
| Lessee | ลูกค้าที่เป็นผู้เช่า |
| Installment | งวดการชำระเงิน |

---

## 6. Appendix / ภาคผนวก

### 6.1 Data Dictionary / พจนานุกรมข้อมูล

| Field | Table | Type | Nullable | Description |
|-------|-------|------|---------|-------------|
| contract_id | contracts | VARCHAR(20) | NOT NULL | รหัสสัญญา (format: CTR-YYYYXXXXXX) |
| customer_id | contracts | UUID | NOT NULL | FK → customers.id |
| amount | contracts | DECIMAL(15,2) | NOT NULL | มูลค่าสัญญา |
| status | contracts | ENUM | NOT NULL | active, expired, terminated, suspended |
| start_date | contracts | DATE | NOT NULL | วันเริ่มต้นสัญญา |
| end_date | contracts | DATE | NOT NULL | วันสิ้นสุดสัญญา |

---

*เอกสารนี้สร้างโดย PT Leasing SDLC Framework — templates/SRS.template.md*
