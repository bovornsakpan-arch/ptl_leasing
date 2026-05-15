# Changelog / บันทึกการเปลี่ยนแปลง

All notable changes to PT Leasing SDLC Framework will be documented in this file.
การเปลี่ยนแปลงที่สำคัญของ PT Leasing SDLC Framework จะถูกบันทึกในไฟล์นี้

Format: [Semantic Versioning](https://semver.org/) — `MAJOR.MINOR.PATCH`

---

## [Unreleased]

*(ยังไม่มีการเปลี่ยนแปลงที่ pending)*

---

## [0.1.0] — 2026-05-15

### Added / เพิ่มใหม่

- **SDLC Framework Setup**: สร้างโครงสร้างโปรเจกต์เริ่มต้น
  - Root documentation files (README.md, PROJECT_STATUS.md, DECISION_LOG.md, GLOSSARY.md)
  - Project configuration files (config/project.yaml, roles.yaml, users.yaml, phases.yaml, tracking.yaml)
  - GitHub Actions workflows for frontmatter validation, role validation, status update, Jira sync, and deployment
  - Document templates (BRD, SRS, GAP Analysis, Impact Analysis, Architecture, ADR, Test Cases, etc.)
  - Discovery phase folder structure (phases 1–5)
  - ISO27001 compliance documentation stubs
  - PM Dashboard (dashboard/index.html) with Chart.js visualizations
  - Utility scripts (new-feature.sh, new-cr.sh, validate.sh, update-status.sh, sync-tracking.sh)
  - MkDocs user manual structure
  - CODEOWNERS for role-based access control

### Configuration / การตั้งค่า

- Project Code: PTL
- Jira Integration: snocko-main.atlassian.net
- Figma Workspace: https://www.figma.com/files/project/587761135
- Team: PM (bovornsakpan-arch), BA (orawan-nus), SA (siriporn-san, thamonwan-san)

---

## Changelog Format Guide

```
## [VERSION] — YYYY-MM-DD

### Added — ฟีเจอร์/เอกสารใหม่
### Changed — เปลี่ยนแปลงที่มีอยู่แล้ว
### Deprecated — จะเลิกใช้ในอนาคต
### Removed — ลบออก
### Fixed — แก้ไขบัค
### Security — แก้ไขช่องโหว่ด้านความปลอดภัย
```

[Unreleased]: https://github.com/bovornsakpan-arch/ptl_leasing/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/bovornsakpan-arch/ptl_leasing/releases/tag/v0.1.0
