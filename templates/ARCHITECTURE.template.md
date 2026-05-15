---
doc_id: "PTL-ARCH-001"
title: "Architecture: [System/Feature Name]"
project: ptl_leasing
type: architecture
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

# Architecture: [System/Feature Name]
# เอกสารสถาปัตยกรรมระบบ

> **Version**: 0.1.0 | **Status**: Draft

---

## 1. System Context / บริบทของระบบ

### 1.1 Overview / ภาพรวม

*(อธิบาย context ของระบบ — อยู่ที่ไหนใน landscape ของ PT Leasing)*

### 1.2 System Context Diagram / ผังบริบทระบบ

```mermaid
C4Context
    title System Context — PT Leasing Backoffice

    Person(officer, "Leasing Officer", "ประมวลสัญญาเช่า")
    Person(manager, "Manager", "อนุมัติและดูภาพรวม")
    Person(admin, "System Admin", "จัดการผู้ใช้และระบบ")

    System(ptl, "PT Leasing Backoffice", "ระบบ backoffice สำหรับธุรกิจลีสซิ่ง")

    System_Ext(credit, "Credit Bureau", "ตรวจสอบเครดิตลูกค้า")
    System_Ext(payment, "Payment Gateway", "ประมวลการชำระเงิน")
    System_Ext(email, "Email Service", "ส่ง notification")
    System_Ext(storage, "Document Storage", "เก็บเอกสารสัญญา")

    Rel(officer, ptl, "ใช้งาน", "HTTPS")
    Rel(manager, ptl, "ใช้งาน", "HTTPS")
    Rel(admin, ptl, "จัดการ", "HTTPS")
    Rel(ptl, credit, "ตรวจสอบเครดิต", "API")
    Rel(ptl, payment, "ประมวลชำระเงิน", "API")
    Rel(ptl, email, "ส่ง email", "SMTP/API")
    Rel(ptl, storage, "เก็บ/ดึงเอกสาร", "S3 API")
```

---

## 2. Component Diagram / ผังส่วนประกอบ

```mermaid
C4Component
    title Component Diagram — PT Leasing Backoffice

    Container_Boundary(frontend, "Frontend (React)") {
        Component(spa, "SPA Application", "React/TypeScript", "Web application")
    }

    Container_Boundary(backend, "Backend (API)") {
        Component(api_gw, "API Gateway", "Nginx/Kong", "Routing, auth, rate limit")
        Component(auth_svc, "Auth Service", "Node.js", "Authentication & authorization")
        Component(contract_svc, "Contract Service", "Node.js", "Contract management")
        Component(payment_svc, "Payment Service", "Node.js", "Payment processing")
        Component(report_svc, "Report Service", "Node.js", "Reports & exports")
    }

    Container_Boundary(data, "Data Layer") {
        ComponentDb(db_main, "Main Database", "PostgreSQL", "Primary data store")
        ComponentDb(db_cache, "Cache", "Redis", "Session, cache")
        ComponentDb(db_queue, "Message Queue", "RabbitMQ", "Async jobs")
    }

    Rel(spa, api_gw, "API calls", "HTTPS/REST")
    Rel(api_gw, auth_svc, "Validates token")
    Rel(api_gw, contract_svc, "Routes request")
    Rel(api_gw, payment_svc, "Routes request")
    Rel(api_gw, report_svc, "Routes request")
    Rel(contract_svc, db_main, "CRUD", "SQL")
    Rel(payment_svc, db_main, "CRUD", "SQL")
    Rel(auth_svc, db_cache, "Session", "Redis")
    Rel(contract_svc, db_queue, "Async events", "AMQP")
```

---

## 3. Technology Choices / การเลือก Technology

| Layer | Technology | Version | Rationale |
|-------|-----------|---------|-----------|
| Frontend | React | 18.x | ทีมมีความชำนาญ, ecosystem ดี |
| Backend | Node.js (Express) | 20.x LTS | Fast development, JavaScript throughout |
| Database | PostgreSQL | 15.x | ACID compliant, JSON support |
| Cache | Redis | 7.x | Fast session/cache |
| Container | Docker + Kubernetes | - | Scalability, consistency |
| CI/CD | GitHub Actions | - | Repository อยู่ใน GitHub |
| API Documentation | OpenAPI 3.0 | - | Industry standard |
| Auth | JWT + OAuth2 | - | Stateless, scalable |

*(อ่าน rationale ละเอียดได้ที่ ADR documents)*

---

## 4. Infrastructure / โครงสร้างพื้นฐาน

### 4.1 Environment Overview

| Environment | Purpose | URL |
|-------------|---------|-----|
| Development | Local development | localhost |
| Staging | QA testing, UAT | https://staging.ptleasing.internal |
| Production | Live system | https://ptleasing.snocko-tech.com |

### 4.2 Infrastructure Diagram

```mermaid
graph TB
    subgraph Internet
        Users[Users]
    end

    subgraph "Cloud Provider"
        subgraph "DMZ"
            WAF[WAF / DDoS Protection]
            LB[Load Balancer]
        end

        subgraph "Application Tier"
            APP1[App Server 1]
            APP2[App Server 2]
        end

        subgraph "Data Tier"
            DB_PRIMARY[(DB Primary)]
            DB_REPLICA[(DB Replica)]
            REDIS[(Redis Cluster)]
        end

        subgraph "Storage"
            S3[(Object Storage)]
        end
    end

    Users --> WAF --> LB
    LB --> APP1 & APP2
    APP1 & APP2 --> DB_PRIMARY
    APP1 & APP2 --> REDIS
    DB_PRIMARY --> DB_REPLICA
    APP1 & APP2 --> S3
```

### 4.3 Server Specifications

| Component | Spec | Count | Notes |
|-----------|------|-------|-------|
| App Server | 4 vCPU, 8GB RAM | 2 | Auto-scaling capable |
| DB Primary | 8 vCPU, 32GB RAM, 500GB SSD | 1 | |
| DB Replica | 8 vCPU, 32GB RAM, 500GB SSD | 1 | Read replica |
| Redis | 2 vCPU, 4GB RAM | 1 | |

---

## 5. Scalability Considerations / ข้อพิจารณาด้าน Scalability

### 5.1 Current Capacity

- Expected users: 50-100 concurrent
- Data volume: ~10,000 contracts/year
- Peak load: Month-end reporting

### 5.2 Scaling Strategy

| Trigger | Action |
|---------|--------|
| CPU > 70% for 5 min | Scale out app servers (add 1 instance) |
| Memory > 80% | Scale up app server size |
| DB connections > 80% | Add read replicas |
| Response time > 2s | Performance investigation |

### 5.3 Bottlenecks to Watch

- Database: slow queries during batch reports
- Cache miss rate: monitor Redis hit rate
- External API: credit bureau response time

---

## 6. Security Architecture / สถาปัตยกรรมด้านความปลอดภัย

*(ดูรายละเอียดใน docs/00-discovery/02-design/security/SECURITY_DESIGN.md)*

- **Authentication**: JWT + Refresh tokens
- **Authorization**: RBAC with least privilege
- **Data encryption**: TLS 1.2+ in transit, AES-256 at rest
- **Network**: WAF, private subnets for data tier
- **Audit**: All actions logged to centralized log system

---

*เอกสารนี้สร้างโดย PT Leasing SDLC Framework — templates/ARCHITECTURE.template.md*
