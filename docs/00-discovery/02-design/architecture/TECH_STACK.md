---
doc_id: "PTL-TECH-001"
title: "Technology Stack — PT Leasing"
project: ptl_leasing
type: architecture
version: "0.1.0"
status: draft
owner: siriporn.san@snocko-tech.com
phase: "02-design"
created_at: "2026-05-15"
updated_at: "2026-05-15"
reviewed_by: ""
approved_by: ""
---

# Technology Stack / เทคโนโลยีที่ใช้

> **Version**: 0.1.0 | **Status**: Draft (รอ finalise หลัง architecture review)

---

## Frontend

| Technology | Version | Purpose | Decision |
|-----------|---------|---------|---------|
| React | 18.x | UI framework | *(ดู ADR)* |
| TypeScript | 5.x | Type safety | Required |
| Vite | 5.x | Build tool | Fast development |
| TailwindCSS | 3.x | Styling | Utility-first CSS |
| React Query | 5.x | Data fetching/caching | Server state management |
| React Hook Form | 7.x | Form management | Lightweight forms |
| React Router | 6.x | Routing | SPA routing |
| Recharts / Chart.js | Latest | Data visualization | Dashboard charts |
| Axios | 1.x | HTTP client | API communication |

---

## Backend

| Technology | Version | Purpose | Decision |
|-----------|---------|---------|---------|
| Node.js | 20 LTS | Runtime | — |
| Express.js | 4.x | Web framework | — |
| TypeScript | 5.x | Type safety | Required |
| Prisma | 5.x | ORM | Type-safe DB access |
| JWT (jsonwebtoken) | 9.x | Authentication tokens | — |
| bcrypt | 5.x | Password hashing | Security |
| Joi / Zod | Latest | Input validation | — |
| Winston | 3.x | Logging | Structured logs |
| Bull | 4.x | Job queue | Async jobs |
| Nodemailer | Latest | Email sending | — |

---

## Database & Storage

| Technology | Version | Purpose |
|-----------|---------|---------|
| PostgreSQL | 15.x | Primary database |
| Redis | 7.x | Session store, cache, job queue |
| MinIO / AWS S3 | — | Document/file storage |

---

## Infrastructure & DevOps

| Technology | Version | Purpose |
|-----------|---------|---------|
| Docker | 24.x | Containerization |
| Docker Compose | 2.x | Local development |
| Nginx | 1.25 | Reverse proxy, static files |
| GitHub Actions | — | CI/CD pipeline |
| GitHub Pages | — | Dashboard, user manual |
| SonarQube / CodeClimate | — | Code quality |

---

## Testing

| Technology | Purpose |
|-----------|---------|
| Vitest / Jest | Unit & integration testing |
| React Testing Library | Component testing |
| Playwright / Cypress | E2E testing |
| k6 | Performance/load testing |
| OWASP ZAP | Security testing |

---

## Version Constraints / ข้อจำกัดเวอร์ชัน

- Node.js: ต้องใช้ LTS เท่านั้น
- ไม่อนุญาตให้ใช้ library ที่ไม่ได้รับการ maintain > 1 ปี
- ทุก dependency ต้องผ่าน security audit ก่อน approved

---

*อัปเดตล่าสุด: 2026-05-15 | Owner: siriporn.san@snocko-tech.com*
