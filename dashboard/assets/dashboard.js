/**
 * PT Leasing PM Dashboard — JavaScript
 * Fetches status.json and renders all widgets
 */

'use strict';

// ============================================================
// Configuration
// ============================================================
const CONFIG = {
  statusUrl: 'data/status.json',
  refreshInterval: 5 * 60 * 1000, // 5 minutes
  phaseNames: {
    '01-requirements': 'Phase 1: Requirements',
    '02-design': 'Phase 2: Design',
    '03-validation': 'Phase 3: Validation',
    '04-breakdown': 'Phase 4: Breakdown',
    '05-ready': 'Phase 5: Ready for Dev'
  }
};

// ============================================================
// State
// ============================================================
let statusData = null;
let charts = {};
let currentFilter = { phase: 'all', role: 'all' };
let refreshTimer = null;

// ============================================================
// Data Fetching
// ============================================================
async function fetchStatus() {
  try {
    const resp = await fetch(CONFIG.statusUrl + '?t=' + Date.now());
    if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
    statusData = await resp.json();
    renderAll();
    updateLastUpdated();
    showToast('Dashboard refreshed', 'success');
  } catch (err) {
    console.error('Failed to fetch status.json:', err);
    showToast('Failed to refresh data: ' + err.message, 'error');
    // Try to show stale data if available
    if (statusData) renderAll();
    else showLoadError();
  }
}

// ============================================================
// Render All Widgets
// ============================================================
function renderAll() {
  if (!statusData) return;
  renderStatCards();
  renderPhaseProgress();
  renderDocumentStatusChart();
  renderCRvsFeatureChart();
  renderSLATable();
  renderISOCompliance();
  renderRecentActivity();
  renderStaleDocuments();
  renderRiskHeatMap();
  renderResourceWorkload();
  renderBurndownChart();
  renderSignoffVelocity();
  renderBottleneck();
}

// ============================================================
// 1. Stat Cards
// ============================================================
function renderStatCards() {
  const d = statusData;
  const counts = d.document_counts || {};
  const totalDocs = Object.values(counts).reduce((a, b) => a + b, 0);
  const approvedDocs = (counts.approved || 0) + (counts.final || 0);

  setEl('stat-phase', `Phase ${getCurrentPhaseNumber()}/5`);
  setEl('stat-phase-name', getCurrentPhaseName());
  setEl('stat-total-docs', totalDocs);
  setEl('stat-approved-docs', approvedDocs);
  setEl('stat-overall-progress', Math.round((d.project?.overall_progress || 0) * 100) + '%');
  setEl('stat-iso-score', Math.round((d.compliance?.iso27001_score || 0) * 100) + '%');
}

function getCurrentPhaseNumber() {
  if (!statusData) return 1;
  const phaseId = statusData.project?.current_phase || '01-requirements';
  const map = { '01-requirements': 1, '02-design': 2, '03-validation': 3, '04-breakdown': 4, '05-ready': 5 };
  return map[phaseId] || 1;
}

function getCurrentPhaseName() {
  if (!statusData) return '';
  const phaseId = statusData.project?.current_phase || '01-requirements';
  const phase = statusData.phases?.find(p => p.id === phaseId);
  return phase?.name || phaseId;
}

// ============================================================
// 2. Phase Progress
// ============================================================
function renderPhaseProgress() {
  const container = document.getElementById('phase-progress-list');
  if (!container || !statusData?.phases) return;

  container.innerHTML = statusData.phases.map(phase => {
    const pct = Math.round((phase.progress || 0) * 100);
    const statusClass = phase.status === 'in_progress' ? 'in-progress' : phase.status === 'done' ? 'done' : 'not-started';
    const badgeClass = phase.status === 'in_progress' ? 'badge-in-progress' : phase.status === 'done' ? 'badge-done' : 'badge-not-started';
    const badgeText = phase.status === 'in_progress' ? '● In Progress' : phase.status === 'done' ? '✓ Done' : '○ Not Started';
    const slaText = phase.sla_days ? `SLA: ${phase.sla_days}d` : '';

    return `
      <div class="phase-item">
        <div class="phase-header">
          <span class="phase-name">${phase.name}</span>
          <div class="phase-meta">
            <span>${slaText}</span>
            <span>${pct}%</span>
            <span class="badge ${badgeClass}">${badgeText}</span>
          </div>
        </div>
        <div class="progress-bar-wrap">
          <div class="progress-bar ${statusClass}" style="width: ${Math.max(pct, 2)}%"></div>
        </div>
      </div>
    `;
  }).join('');
}

// ============================================================
// 3. Document Status Chart (Pie)
// ============================================================
function renderDocumentStatusChart() {
  const canvas = document.getElementById('doc-status-chart');
  if (!canvas) return;

  const counts = statusData?.document_counts || {};
  const labels = ['Draft', 'In Review', 'Approved', 'Final', 'Rejected'];
  const data = [
    counts.draft || 0,
    counts.in_review || 0,
    counts.approved || 0,
    counts.final || 0,
    counts.rejected || 0
  ];
  const colors = ['#94A3B8', '#7C3AED', '#16A34A', '#1E40AF', '#DC2626'];

  if (charts.docStatus) charts.docStatus.destroy();
  charts.docStatus = new Chart(canvas, {
    type: 'doughnut',
    data: {
      labels,
      datasets: [{ data, backgroundColor: colors, borderWidth: 2, borderColor: '#fff' }]
    },
    options: {
      responsive: true,
      plugins: {
        legend: { position: 'bottom', labels: { font: { size: 11 }, padding: 12 } },
        tooltip: { callbacks: { label: ctx => ` ${ctx.label}: ${ctx.raw}` } }
      },
      cutout: '65%'
    }
  });
}

// ============================================================
// 4. CR vs Feature Chart (Doughnut)
// ============================================================
function renderCRvsFeatureChart() {
  const canvas = document.getElementById('cr-feature-chart');
  if (!canvas) return;

  const d = statusData?.cr_vs_feature || { cr_count: 0, feature_count: 0 };
  const total = d.cr_count + d.feature_count;

  if (charts.crFeature) charts.crFeature.destroy();
  charts.crFeature = new Chart(canvas, {
    type: 'doughnut',
    data: {
      labels: ['New Features', 'Change Requests'],
      datasets: [{
        data: [d.feature_count, d.cr_count],
        backgroundColor: ['#3B82F6', '#F59E0B'],
        borderWidth: 2, borderColor: '#fff'
      }]
    },
    options: {
      responsive: true,
      plugins: {
        legend: { position: 'bottom', labels: { font: { size: 11 }, padding: 12 } },
        tooltip: { callbacks: { label: ctx => ` ${ctx.label}: ${ctx.raw} (${total > 0 ? Math.round(ctx.raw/total*100) : 0}%)` } }
      },
      cutout: '60%'
    }
  });

  setEl('cr-feature-total', `${total} total`);
}

// ============================================================
// 5. SLA Tracking Table
// ============================================================
function renderSLATable() {
  const tbody = document.getElementById('sla-table-body');
  if (!tbody || !statusData?.phases) return;

  const today = new Date('2026-05-15');

  tbody.innerHTML = statusData.phases.map(phase => {
    let elapsed = '—';
    let remaining = '—';
    let slaStatus = '';
    let statusClass = '';

    if (phase.started_date) {
      const start = new Date(phase.started_date);
      const elapsedDays = Math.floor((today - start) / (1000 * 60 * 60 * 24));
      const remainingDays = phase.sla_days - elapsedDays;
      elapsed = `${elapsedDays}d`;
      remaining = `${remainingDays}d`;
      if (remainingDays < 0) { slaStatus = '⚠ Overdue'; statusClass = 'sla-over'; }
      else if (remainingDays <= 3) { slaStatus = '⚡ At Risk'; statusClass = 'sla-warn'; }
      else { slaStatus = '✅ On Track'; statusClass = 'sla-ok'; }
    } else {
      slaStatus = '—';
    }

    return `
      <tr>
        <td>${phase.name}</td>
        <td>${phase.sla_days}d</td>
        <td>${elapsed}</td>
        <td>${remaining}</td>
        <td class="${statusClass}">${slaStatus}</td>
      </tr>
    `;
  }).join('');
}

// ============================================================
// 6. ISO27001 Compliance
// ============================================================
function renderISOCompliance() {
  const d = statusData?.compliance || {};
  const score = Math.round((d.iso27001_score || 0) * 100);
  setEl('iso-score-number', score + '%');
  setEl('iso-approved', d.approved_docs || 0);
  setEl('iso-required', d.required_docs || 6);

  const color = score >= 80 ? '#16A34A' : score >= 50 ? '#D97706' : '#DC2626';
  const el = document.getElementById('iso-score-number');
  if (el) el.style.color = color;
}

// ============================================================
// 7. Recent Activity
// ============================================================
function renderRecentActivity() {
  const container = document.getElementById('activity-list');
  if (!container) return;

  // Build activity from document status changes (simplified)
  const activities = [
    { text: 'SDLC framework initialized', time: '2026-05-15 00:00', dot: 'primary' },
    { text: 'Project repository setup complete', time: '2026-05-15 00:00', dot: 'primary' }
  ];

  // Add any docs with recent updates
  if (statusData?.documents?.length > 0) {
    statusData.documents
      .filter(d => d.status === 'approved' || d.status === 'final')
      .slice(0, 5)
      .forEach(d => {
        activities.unshift({
          text: `"${d.title}" marked as ${d.status}`,
          time: d.updated_at || '',
          dot: d.status === 'final' ? 'success' : 'primary'
        });
      });
  }

  if (activities.length === 0) {
    container.innerHTML = '<div class="empty-state"><div class="empty-icon">📋</div><p>No recent activity</p></div>';
    return;
  }

  container.innerHTML = activities.slice(0, 8).map(a => `
    <div class="activity-item">
      <div class="activity-dot"></div>
      <div>
        <div class="activity-text">${escHtml(a.text)}</div>
        <div class="activity-time">${escHtml(a.time)}</div>
      </div>
    </div>
  `).join('');
}

// ============================================================
// 8. Stale Documents
// ============================================================
function renderStaleDocuments() {
  const container = document.getElementById('stale-docs-list');
  if (!container) return;

  const today = new Date('2026-05-15');
  const docs = (statusData?.documents || []).filter(d => {
    if (d.status === 'final' || d.status === 'approved') return false;
    if (!d.updated_at) return false;
    const updated = new Date(d.updated_at);
    const days = Math.floor((today - updated) / (1000 * 60 * 60 * 24));
    return days > 7 && d.status === 'draft';
  });

  if (docs.length === 0) {
    container.innerHTML = '<div class="empty-state"><div class="empty-icon">✅</div><p>No stale documents</p></div>';
    return;
  }

  container.innerHTML = docs.slice(0, 6).map(d => {
    const days = Math.floor((today - new Date(d.updated_at)) / (1000 * 60 * 60 * 24));
    return `
      <div class="stale-doc-item">
        <div>
          <div style="font-size:13px">${escHtml(d.title)}</div>
          <div style="font-size:11px;color:var(--color-text-muted)">${escHtml(d.owner || '')}</div>
        </div>
        <span class="stale-days">${days}d</span>
      </div>
    `;
  }).join('');
}

// ============================================================
// 9. Risk Heat Map
// ============================================================
function renderRiskHeatMap() {
  const tbody = document.getElementById('risk-table-body');
  if (!tbody) return;

  const risks = statusData?.risks || [];

  if (risks.length === 0) {
    tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;color:var(--color-text-muted);padding:16px">No risks logged — see docs/iso27001/RISK_REGISTER.md</td></tr>';
    return;
  }

  tbody.innerHTML = risks.slice(0, 8).map(r => {
    const score = (r.likelihood || 1) * (r.impact || 1);
    const levelClass = score >= 16 ? 'risk-critical' : score >= 10 ? 'risk-high' : score >= 5 ? 'risk-medium' : 'risk-low';
    const levelText = score >= 16 ? 'Critical' : score >= 10 ? 'High' : score >= 5 ? 'Medium' : 'Low';
    return `
      <tr class="risk-table">
        <td>${escHtml(r.id || '')}</td>
        <td>${escHtml(r.category || '')}</td>
        <td>${escHtml(r.description?.substring(0, 50) || '')}...</td>
        <td>${score}</td>
        <td class="${levelClass}">${levelText}</td>
      </tr>
    `;
  }).join('');
}

// ============================================================
// 10. Resource / Role Workload Chart
// ============================================================
function renderResourceWorkload() {
  const canvas = document.getElementById('workload-chart');
  if (!canvas) return;

  // Derive workload from document ownership
  const roleCounts = { PM: 0, BA: 0, SA: 0, Dev: 0, QA: 0 };
  (statusData?.documents || []).forEach(d => {
    if (d.owner?.includes('bovornsak')) roleCounts.PM++;
    else if (d.owner?.includes('orawan')) roleCounts.BA++;
    else if (d.owner?.includes('siriporn') || d.owner?.includes('thamonwan')) roleCounts.SA++;
  });

  if (charts.workload) charts.workload.destroy();
  charts.workload = new Chart(canvas, {
    type: 'bar',
    data: {
      labels: Object.keys(roleCounts),
      datasets: [{
        label: 'Documents Owned',
        data: Object.values(roleCounts),
        backgroundColor: '#3B82F6',
        borderRadius: 4,
      }]
    },
    options: {
      responsive: true,
      plugins: { legend: { display: false } },
      scales: {
        y: { beginAtZero: true, grid: { color: '#F1F5F9' }, ticks: { font: { size: 11 } } },
        x: { grid: { display: false }, ticks: { font: { size: 11 } } }
      }
    }
  });
}

// ============================================================
// 11. Burndown Chart
// ============================================================
function renderBurndownChart() {
  const canvas = document.getElementById('burndown-chart');
  if (!canvas) return;

  // Simplified burndown — docs remaining over time
  const totalDocs = Object.values(statusData?.document_counts || {}).reduce((a,b) => a+b, 0) || 10;
  const labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5', 'Week 6', 'Week 7'];
  const ideal = labels.map((_, i) => Math.max(0, totalDocs - (totalDocs / (labels.length - 1)) * i));
  const actual = [totalDocs, ...Array(labels.length - 1).fill(null)]; // Only have current point

  if (charts.burndown) charts.burndown.destroy();
  charts.burndown = new Chart(canvas, {
    type: 'line',
    data: {
      labels,
      datasets: [
        {
          label: 'Ideal',
          data: ideal,
          borderColor: '#94A3B8',
          borderDash: [5, 5],
          tension: 0.1, pointRadius: 3, fill: false
        },
        {
          label: 'Actual',
          data: actual,
          borderColor: '#1E40AF',
          backgroundColor: 'rgba(30, 64, 175, 0.1)',
          tension: 0.1, pointRadius: 4, fill: true
        }
      ]
    },
    options: {
      responsive: true,
      plugins: { legend: { position: 'bottom', labels: { font: { size: 11 } } } },
      scales: {
        y: { beginAtZero: true, title: { display: true, text: 'Docs Remaining', font: { size: 11 } }, grid: { color: '#F1F5F9' } },
        x: { grid: { display: false }, ticks: { font: { size: 11 } } }
      }
    }
  });
}

// ============================================================
// 12. Sign-off Velocity
// ============================================================
function renderSignoffVelocity() {
  const d = statusData?.velocity || {};
  const avg = d.avg_approve_days;
  setEl('velocity-avg', avg ? `${avg} วัน` : 'N/A');
  setEl('velocity-pending', (statusData?.document_counts?.in_review || 0) + ' docs');

  const canvas = document.getElementById('velocity-chart');
  if (!canvas) return;

  // Simplified velocity chart
  const labels = ['W1', 'W2', 'W3', 'W4', 'W5'];
  const data = [0, 0, 0, 0, 0]; // No approvals yet

  if (charts.velocity) charts.velocity.destroy();
  charts.velocity = new Chart(canvas, {
    type: 'bar',
    data: {
      labels,
      datasets: [{
        label: 'Documents Approved',
        data,
        backgroundColor: '#16A34A',
        borderRadius: 4,
      }]
    },
    options: {
      responsive: true,
      plugins: { legend: { display: false } },
      scales: {
        y: { beginAtZero: true, grid: { color: '#F1F5F9' }, ticks: { font: { size: 11 } } },
        x: { grid: { display: false }, ticks: { font: { size: 11 } } }
      }
    }
  });
}

// ============================================================
// Bottleneck Tracker
// ============================================================
function renderBottleneck() {
  const container = document.getElementById('bottleneck-list');
  if (!container) return;

  // Identify bottlenecks from in_review docs
  const inReview = (statusData?.documents || []).filter(d => d.status === 'in_review');
  const today = new Date('2026-05-15');

  if (inReview.length === 0) {
    container.innerHTML = '<div class="empty-state"><div class="empty-icon">✅</div><p>ไม่มี bottleneck ในขณะนี้</p></div>';
    return;
  }

  container.innerHTML = inReview.slice(0, 5).map(d => {
    const days = d.updated_at ? Math.floor((today - new Date(d.updated_at)) / (1000 * 60 * 60 * 24)) : 0;
    const urgencyClass = days > 5 ? 'sla-over' : days > 3 ? 'sla-warn' : 'sla-ok';
    return `
      <div class="bottleneck-item">
        <div>
          <div style="font-size:13px">${escHtml(d.title)}</div>
          <div style="font-size:11px;color:var(--color-text-muted)">Owner: ${escHtml(d.owner || '')}</div>
        </div>
        <span class="${urgencyClass}" style="font-size:12px">${days}d in review</span>
      </div>
    `;
  }).join('');
}

// ============================================================
// Utilities
// ============================================================
function setEl(id, value) {
  const el = document.getElementById(id);
  if (el) el.textContent = value;
}

function escHtml(str) {
  if (!str) return '';
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function updateLastUpdated() {
  const el = document.getElementById('last-updated');
  if (!el) return;
  const ts = statusData?.generated_at || new Date().toISOString();
  el.textContent = 'Updated: ' + new Date(ts).toLocaleString('th-TH');
}

function showLoadError() {
  const content = document.getElementById('dashboard-content');
  if (content) {
    content.innerHTML = `
      <div class="empty-state" style="margin-top:80px">
        <div class="empty-icon">⚠️</div>
        <p style="font-size:16px;font-weight:600;margin-bottom:8px">ไม่สามารถโหลดข้อมูลได้</p>
        <p>ไม่พบไฟล์ data/status.json — รัน <code>./scripts/update-status.sh</code> เพื่อสร้าง</p>
      </div>
    `;
  }
}

let toastTimer;
function showToast(message, type = 'info') {
  let toast = document.getElementById('toast');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'toast';
    toast.style.cssText = `
      position:fixed;bottom:24px;right:24px;padding:12px 20px;
      border-radius:8px;font-size:13px;font-weight:500;z-index:9999;
      transition:opacity 0.3s;box-shadow:0 4px 12px rgba(0,0,0,0.15);
    `;
    document.body.appendChild(toast);
  }
  const colors = { success: '#16A34A', error: '#DC2626', info: '#1E40AF' };
  toast.style.background = colors[type] || colors.info;
  toast.style.color = '#fff';
  toast.style.opacity = '1';
  toast.textContent = message;
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => { toast.style.opacity = '0'; }, 3000);
}

// ============================================================
// Filters
// ============================================================
function initFilters() {
  const phaseFilter = document.getElementById('filter-phase');
  if (phaseFilter) {
    phaseFilter.addEventListener('change', (e) => {
      currentFilter.phase = e.target.value;
      renderAll();
    });
  }
  const roleFilter = document.getElementById('filter-role');
  if (roleFilter) {
    roleFilter.addEventListener('change', (e) => {
      currentFilter.role = e.target.value;
      renderAll();
    });
  }
}

// ============================================================
// Auto-refresh
// ============================================================
function startAutoRefresh() {
  if (refreshTimer) clearInterval(refreshTimer);
  refreshTimer = setInterval(fetchStatus, CONFIG.refreshInterval);
}

// ============================================================
// Navigation
// ============================================================
function initNav() {
  document.querySelectorAll('.nav-item[data-section]').forEach(item => {
    item.addEventListener('click', () => {
      document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
      item.classList.add('active');
      const target = item.dataset.section;
      const el = document.getElementById('section-' + target);
      if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });
  });
}

// ============================================================
// Manual Refresh Button
// ============================================================
function initRefreshButton() {
  const btn = document.getElementById('refresh-btn');
  if (btn) {
    btn.addEventListener('click', () => {
      btn.textContent = '⟳ Refreshing...';
      btn.disabled = true;
      fetchStatus().finally(() => {
        btn.textContent = '⟳ Refresh';
        btn.disabled = false;
      });
    });
  }
}

// ============================================================
// Init
// ============================================================
document.addEventListener('DOMContentLoaded', () => {
  initNav();
  initFilters();
  initRefreshButton();
  fetchStatus();
  startAutoRefresh();
});
