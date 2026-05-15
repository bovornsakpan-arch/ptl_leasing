#!/bin/bash
# ============================================================
# update-status.sh — Scan all .md files, aggregate status, update dashboard/data/status.json
# Usage: ./scripts/update-status.sh
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
STATUS_FILE="$PROJECT_ROOT/dashboard/data/status.json"

echo "Scanning docs for frontmatter..."

python3 << PYTHON_SCRIPT
import os, re, json, yaml
from datetime import datetime, timezone

def extract_frontmatter(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        if not content.startswith('---'):
            return None
        parts = content.split('---', 2)
        if len(parts) < 3:
            return None
        fm = yaml.safe_load(parts[1])
        if fm:
            fm['_filepath'] = filepath
        return fm
    except Exception:
        return None

project_root = '$PROJECT_ROOT'

# Load existing status
status_file = '$STATUS_FILE'
existing = {}
if os.path.exists(status_file):
    with open(status_file, 'r', encoding='utf-8') as f:
        existing = json.load(f)

# Load project config
project_config = {}
cfg_file = os.path.join(project_root, 'config/project.yaml')
if os.path.exists(cfg_file):
    with open(cfg_file, 'r', encoding='utf-8') as f:
        project_config = yaml.safe_load(f)

# Load phases config
phases_config = {'phases': []}
phases_file = os.path.join(project_root, 'config/phases.yaml')
if os.path.exists(phases_file):
    with open(phases_file, 'r', encoding='utf-8') as f:
        phases_config = yaml.safe_load(f)

VALID_STATUSES = ['draft', 'in_review', 'approved', 'final', 'superseded', 'rejected']

documents = []
for root, dirs, files in os.walk(os.path.join(project_root, 'docs')):
    if 'user-manual' in root:
        continue
    for filename in files:
        if not filename.endswith('.md'):
            continue
        filepath = os.path.join(root, filename)
        fm = extract_frontmatter(filepath)
        if fm and 'doc_id' in fm and 'status' in fm:
            rel_path = os.path.relpath(filepath, project_root)
            documents.append({
                'doc_id': str(fm.get('doc_id', '')),
                'title': str(fm.get('title', filename)),
                'type': str(fm.get('type', 'unknown')),
                'status': str(fm.get('status', 'draft')),
                'version': str(fm.get('version', '0.1.0')),
                'owner': str(fm.get('owner', '')),
                'path': rel_path,
                'phase': str(fm.get('phase', '')),
                'updated_at': str(fm.get('updated_at', '')),
            })

status_counts = {s: 0 for s in VALID_STATUSES}
for doc in documents:
    s = doc.get('status', 'draft')
    if s in status_counts:
        status_counts[s] += 1

# Build phases
phase_data = []
for phase in phases_config.get('phases', []):
    phase_id = phase['id']
    phase_docs = [d for d in documents if phase_id in d.get('path', '')]
    total = len(phase_docs)
    approved = sum(1 for d in phase_docs if d['status'] in ['approved', 'final'])
    progress = round(approved / total, 2) if total > 0 else 0.0
    entry = {
        'id': phase_id,
        'name': phase['name'],
        'progress': progress,
        'status': phase.get('status', 'not_started'),
        'sla_days': phase.get('sla_days', 0),
    }
    if phase.get('started_date'):
        entry['started_date'] = str(phase['started_date'])
    phase_data.append(entry)

# Overall progress
total_docs = len(documents)
done_docs = sum(1 for d in documents if d['status'] in ['approved', 'final'])
overall_progress = round(done_docs / total_docs, 2) if total_docs > 0 else 0.0

# ISO27001
iso_required = ['RISK_REGISTER.md', 'SECURITY_CONTROLS.md', 'ASSET_INVENTORY.md',
                'ACCESS_CONTROL_POLICY.md', 'INCIDENT_RESPONSE.md', 'BUSINESS_CONTINUITY.md']
iso_approved = sum(1 for d in documents
                   if any(r in d['path'] for r in iso_required)
                   and d['status'] in ['approved', 'final'])
iso_score = round(iso_approved / len(iso_required), 2)

# CR vs Feature
cr_count = sum(1 for d in documents if d.get('type') == 'change_request')
feature_count = sum(1 for d in documents if d.get('type') == 'new_feature')

# Current phase
current_phase = '01-requirements'
for phase in phases_config.get('phases', []):
    if phase.get('status') == 'in_progress':
        current_phase = phase['id']
        break

status = {
    'generated_at': datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ'),
    'project': {
        'name': project_config.get('project', {}).get('name', 'PT Leasing'),
        'code': project_config.get('project', {}).get('code', 'PTL'),
        'current_phase': current_phase,
        'current_substep': '1.1 Requirement Gathering',
        'overall_progress': overall_progress,
    },
    'phases': phase_data,
    'documents': documents,
    'document_counts': status_counts,
    'tasks': existing.get('tasks', []),
    'approvals': existing.get('approvals', []),
    'risks': existing.get('risks', []),
    'compliance': {
        'iso27001_score': iso_score,
        'required_docs': len(iso_required),
        'approved_docs': iso_approved,
    },
    'velocity': existing.get('velocity', {'avg_approve_days': None}),
    'cr_vs_feature': {'cr_count': cr_count, 'feature_count': feature_count},
}

os.makedirs(os.path.dirname(status_file), exist_ok=True)
with open(status_file, 'w', encoding='utf-8') as f:
    json.dump(status, f, indent=2, ensure_ascii=False)

total = len(documents)
print(f"Documents found: {total}")
print(f"Status counts: {status_counts}")
print(f"Overall progress: {overall_progress*100:.1f}%")
print(f"ISO27001 score: {iso_score*100:.1f}%")
print(f"Updated: {status_file}")
PYTHON_SCRIPT

echo ""
echo "✓ dashboard/data/status.json updated"
