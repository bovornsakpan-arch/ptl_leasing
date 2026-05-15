#!/bin/bash
# ============================================================
# sync-tracking.sh — Sync approved documents to Jira
# Usage: ./scripts/sync-tracking.sh [--dry-run]
# Requires: JIRA_API_TOKEN and JIRA_USER_EMAIL env vars
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

DRY_RUN="${1:-}"

# ── Check env vars ────────────────────────────────────────────
if [[ -z "$JIRA_API_TOKEN" || -z "$JIRA_USER_EMAIL" ]]; then
  echo "ERROR: Missing required environment variables:"
  echo "  JIRA_API_TOKEN  — Jira API token"
  echo "  JIRA_USER_EMAIL — Jira user email"
  echo ""
  echo "Set them before running:"
  echo "  export JIRA_API_TOKEN=your_token"
  echo "  export JIRA_USER_EMAIL=your@email.com"
  echo "  ./scripts/sync-tracking.sh"
  exit 1
fi

JIRA_BASE_URL="https://snocko-main.atlassian.net"
JIRA_PROJECT="PTL"

echo "Syncing approved documents to Jira..."
[[ "$DRY_RUN" == "--dry-run" ]] && echo "(DRY RUN — no changes will be made)"
echo ""

python3 << PYTHON_SCRIPT
import os, sys, yaml, requests
from base64 import b64encode

jira_token = os.environ['JIRA_API_TOKEN']
jira_email = os.environ['JIRA_USER_EMAIL']
jira_base = '$JIRA_BASE_URL'
project_root = '$PROJECT_ROOT'
dry_run = '$DRY_RUN' == '--dry-run'

credentials = b64encode(f"{jira_email}:{jira_token}".encode()).decode()
headers = {
    'Authorization': f'Basic {credentials}',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
}

SYNC_STATUSES = {'approved', 'final', 'rejected'}

def extract_frontmatter(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        if not content.startswith('---'):
            return None
        parts = content.split('---', 2)
        if len(parts) < 3:
            return None
        return yaml.safe_load(parts[1])
    except Exception:
        return None

def post_comment(issue_key, message):
    url = f"{jira_base}/rest/api/3/issue/{issue_key}/comment"
    payload = {
        "body": {
            "type": "doc",
            "version": 1,
            "content": [{"type": "paragraph", "content": [{"type": "text", "text": message}]}]
        }
    }
    if dry_run:
        print(f"    [DRY RUN] Would post comment to {issue_key}")
        return True
    resp = requests.post(url, headers=headers, json=payload, timeout=10)
    return resp.status_code == 201

synced = 0
skipped = 0
errors = 0

for root, dirs, files in os.walk(os.path.join(project_root, 'docs')):
    if 'user-manual' in root:
        continue
    for filename in files:
        if not filename.endswith('.md'):
            continue
        filepath = os.path.join(root, filename)
        fm = extract_frontmatter(filepath)
        if not fm:
            continue
        status = str(fm.get('status', ''))
        if status not in SYNC_STATUSES:
            skipped += 1
            continue
        jira_issue = fm.get('jira_issue') or fm.get('related_jira')
        if not jira_issue or jira_issue == 'PTL-TBD':
            skipped += 1
            continue
        doc_title = fm.get('title', filename)
        version = fm.get('version', 'N/A')
        rel_path = os.path.relpath(filepath, project_root)
        print(f"  Syncing: {rel_path}")
        print(f"    Issue: {jira_issue} | Status: {status}")
        comment = (
            f"Document '{doc_title}' has been marked as '{status}'.\n"
            f"Version: {version}\n"
            f"Path: {rel_path}\n"
            f"Auto-synced by PT Leasing SDLC Framework."
        )
        if post_comment(jira_issue, comment):
            synced += 1
            print(f"    Comment posted to {jira_issue}")
        else:
            errors += 1
            print(f"    Failed to post comment")

print(f"\nSync complete: {synced} synced, {skipped} skipped, {errors} errors")
PYTHON_SCRIPT

echo ""
echo "✓ Jira sync complete"
