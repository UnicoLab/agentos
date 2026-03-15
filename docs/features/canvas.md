---
title: Strategic Canvas
description: Visual portfolio command center with live project health, typed connections, and AI-powered strategic insights.
---

# Strategic Canvas :material-drawing:

> Map your projects, track live KPIs, and get AI-powered strategic insights — all on a visual drag-and-drop board.

---

## Overview

The Strategic Canvas transforms project portfolio management from spreadsheet-juggling into a **visual command center**. Drop project cards that auto-populate with live GitHub and Jira metrics, connect them with typed relationships, and let JP analyze the entire board.

!!! info "Live Data"
    Every project card on the canvas fetches **real-time metrics** from your configured GitHub repos and Jira boards when the canvas opens.

---

## Project Cards

Each project card shows:

- **Health Badge** — :material-check-circle:{ style="color: #22c55e" } Healthy (70-100) · :material-alert:{ style="color: #f59e0b" } At Risk (40-69) · :material-close-circle:{ style="color: #ef4444" } Critical (0-39)
- **Sparkline** — 7-day commit trend as an inline chart
- **Live Metrics** — Open PRs, open issues, sprint progress %, recent commits

### Health Score Algorithm

The health score (0-100) is computed from:

| Factor | Impact |
|--------|--------|
| PR backlog | >20 PRs: -25, >10: -15, >5: -5 |
| Issue backlog | >30 issues: -20, >15: -10, >8: -5 |
| Sprint progress | ≥75%: +10, <60%: -5, <40%: -15 |
| Commit activity | >20 commits: +10, <5 commits: -10 |

---

## Typed Connections

Connect projects to show relationships. Each type has a distinct color and line style:

| Type | Color | Style | Meaning |
|------|-------|-------|---------|
| **depends on** | :material-circle:{ style="color: #8b5cf6" } Purple | Solid | Target is a dependency |
| **blocks** | :material-circle:{ style="color: #ef4444" } Red | Dashed | Source is blocking target |
| **shares team** | :material-circle:{ style="color: #22c55e" } Green | Dotted | Same team works on both |
| **data flow** | :material-circle:{ style="color: #3b82f6" } Blue | Dashed | Data flows between projects |
| **integrates** | :material-circle:{ style="color: #f59e0b" } Amber | Dotted | Integration relationship |

---

## Canvas Elements

| Element | Description |
|---------|-------------|
| :material-folder-star: **Project Card** | Live metrics from GitHub + Jira |
| :material-chart-donut: **Health Chart** | Portfolio health donut (healthy/at-risk/critical) |
| :material-note-text: **Sticky Note** | Free-text notes for strategies and decisions |
| :material-brain: **AI Insight** | Auto-generated or on-demand AI analysis |
| :material-trending-up: **KPI Metric** | Aggregated portfolio metrics |
| :material-format-header-1: **Heading** | Section labels for organization |

---

## AI Analysis

Click **🧠 Analyze with JP** in the toolbar to send the full canvas context to Jean-Pierre:

- All project names, descriptions, and health scores
- All connections with their types
- Portfolio KPIs and aggregated metrics
- Notes content

JP returns **strategic analysis** including risk assessment, dependency insights, and actionable recommendations.

---

## Templates

Start with a pre-built layout:

=== "Portfolio Overview"
    All projects + health donut + KPI row + AI summary. Best for weekly check-ins.

=== "Risk Matrix"
    Projects arranged for risk assessment with AI risk analysis. Best for steering committees.

=== "Sprint Dashboard"
    Sprint-focused view with velocity insights. Best for sprint planning/review.

---

## Controls

| Action | How |
|--------|-----|
| Pan | ++alt++ + drag, or middle-click + drag |
| Zoom | Scroll wheel |
| Reset view | Click ⊡ button |
| Move node | Drag the node header |
| Connect | Click 🔗, select source, select target, choose type |
| Delete node | Hover → click :material-delete: |
| Delete edge | Hover the edge → click × |
| Refresh data | Click :material-refresh: |
| Save | Click Save (auto-reminds if unsaved) |
