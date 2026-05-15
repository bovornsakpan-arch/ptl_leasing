# Versions / ภาพรวมโฟลเดอร์ versions

โฟลเดอร์นี้ใช้เก็บ **ISO27001 audit snapshots** เมื่อเอกสารถูก sign-off อย่างเป็นทางการ

---

## Purpose / วัตถุประสงค์

- เก็บสำเนาเอกสารที่ approved ณ เวลาที่ทำ audit
- สามารถอ้างอิงย้อนหลังได้เมื่อมีการตรวจสอบ
- ป้องกันการสูญเสียเอกสารเมื่อมีการ update

---

## Structure / โครงสร้าง

```
versions/
├── README.md              # ไฟล์นี้
├── v0.1.0-2026-05-15/     # Snapshot เมื่อ v0.1.0
│   ├── MANIFEST.json      # รายการเอกสารที่ include
│   └── docs/              # สำเนาเอกสาร
└── v1.0.0-YYYY-MM-DD/     # Snapshot ของ production release
```

---

## How to Create a Snapshot / วิธีสร้าง Snapshot

เมื่อถึงเวลา audit หรือ milestone สำคัญ:

```bash
# 1. กำหนด version และวันที่
VERSION="v1.0.0"
DATE=$(date +%Y-%m-%d)
SNAPSHOT_DIR="versions/${VERSION}-${DATE}"

# 2. สร้าง snapshot
mkdir -p "$SNAPSHOT_DIR"
cp -r docs/iso27001/ "$SNAPSHOT_DIR/"
cp -r docs/00-discovery/ "$SNAPSHOT_DIR/"

# 3. สร้าง MANIFEST.json
./scripts/update-status.sh
cp dashboard/data/status.json "$SNAPSHOT_DIR/MANIFEST.json"

# 4. Commit
git add versions/
git commit -m "snapshot: ISO27001 audit snapshot ${VERSION} - ${DATE}"
```

---

## Retention Policy / นโยบายการเก็บข้อมูล

- เก็บ snapshots ทุกเวอร์ชัน Major (v1.0, v2.0, ...)
- เก็บ snapshot ล่าสุดของทุก Minor version
- ลบ snapshots เก่า > 3 ปีออก (แต่เก็บ Major versions ไว้เสมอ)

---

*อัปเดตล่าสุด: 2026-05-15*
