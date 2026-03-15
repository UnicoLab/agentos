---
title: Product Tour
description: See Jean-Pierre in action — a complete walkthrough of the AI-powered PM copilot.
---

# Product Tour :material-rocket-launch:

> **See what Jean-Pierre can do for your team — a guided walkthrough of every major capability.**

---

## :material-view-dashboard: The Command Center

When you open Jean-Pierre, you land on a **premium intelligence dashboard** with 20+ drag-and-drop cards. Every card feeds from your live GitHub and Jira data.

!!! tip "Everything is customizable"
    Drag cards to reorder them. Resize between small, wide, tall, large, or full. Hide cards you don't need. Your layout persists automatically.

### Key Dashboard Cards

=== "Health Pulse"
    A **real-time health score (0-100)** computed from 5 risk factors: stale PRs, sprint lag, contributor velocity, issue backlog, and commit trends. Includes sparkline trend and team indicator pills.

=== "KPIs"
    Four key metrics at a glance — open PRs, open issues, commits, and GitHub stars. Labels auto-adjust to your data fetch range.

=== "Actionable Alerts"  
    Auto-detected warnings from live data: stale PRs (>3 days), drafts without reviewers, sprint risk, and low velocity. **Click any alert to ask JP what to do about it.**

=== "Sprint Ring"
    Live Jira sprint progress — WIP, Done, and To Do — rendered as an interactive ring chart.

=== "Velocity Chart"
    Eight-week stacked velocity chart broken down by contributor. Spot trends, capacity risks, and team dynamics.

---

## :material-robot: AI Copilot — Talk to Jean-Pierre

Jean-Pierre isn't just a dashboard — it's an **AI agent** that understands your projects.

### Natural Language Queries

Type anything:

- *"Which PRs have been open for more than 3 days?"*
- *"Generate a standup report for all projects"*
- *"What's blocking the INFRA sprint?"*
- *"Who should review PR #42?"*

JP will **call your connected tools** (GitHub, Jira), fetch live data, and synthesize a structured answer.

### Action Chain — See JP Think

When JP works, you see the **Action Chain pipeline** in real time:

1. :material-magnify: `projects.list` — discovers your repos
2. :material-source-pull: `github.open_prs` — fetches PR data
3. :material-run-fast: `jira.sprint_status` — sprint metrics
4. :material-brain: **Synthesis** — JP formats a structured report

Each step is expandable — see exact tool args, raw output, and timing.

### Quick Commands

One-click PM workflows:

| Command | What It Does |
|---------|-------------|
| 📊 List projects | Show all tracked projects with repos and Jira keys |
| 📋 Standup report | Auto-generated standup with metrics, risks, and action items |
| 🔍 Sprint status | Current sprint progress across all projects |
| 📈 Project progress | Full progress report with milestones and risks |
| 📝 Meeting notes | Structured meeting minutes with decisions and action items |
| ✅ Create tasks | AI-suggested prioritized task list |

---

## :material-strategy: Strategic Canvas

The **Strategic Canvas** is a visual portfolio board where every card shows **live project data**.

### What You See

- **Project Cards** with health badges (Healthy ✅ / At Risk ⚠️ / Critical ❌), inline sparkline charts, and live metrics (PRs, issues, sprint %, commits)
- **Portfolio Donut** showing health distribution across all projects
- **KPI Metrics** auto-populated from aggregated data
- **AI Insights** generated automatically when you open the canvas

### Typed Connections

Connect projects to show relationships — each with a distinct color and meaning:

| Connection | Color | Meaning |
|-----------|-------|---------|
| **depends on** | :material-circle:{ style="color: #8b5cf6" } Purple | B is a dependency of A |
| **blocks** | :material-circle:{ style="color: #ef4444" } Red | A is blocking B |
| **shares team** | :material-circle:{ style="color: #22c55e" } Green | Same team works on both |
| **data flow** | :material-circle:{ style="color: #3b82f6" } Blue | Data flows from A to B |
| **integrates** | :material-circle:{ style="color: #f59e0b" } Amber | A integrates with B |

### AI-Powered Analysis

Click **🧠 Analyze with JP** to send the **entire canvas context** — projects, health scores, connections, and notes — to Jean-Pierre for strategic recommendations.

### Canvas Templates

| Template | Use Case |
|----------|----------|
| **Portfolio Overview** | Full portfolio with health chart + KPIs + AI summary |
| **Risk Matrix** | Projects grouped by risk level |
| **Sprint Dashboard** | Sprint-focused view with velocity insights |

---

## :material-view-grid: Fleet View

Managing multiple projects? **Fleet View** gives you a single-screen overview:

- All projects **ranked by risk score** — highest risk at the top
- KPI summaries per project
- Quick access to any project's dashboard

!!! info "Morning Check-in"
    Open Fleet View every morning to see which projects need your attention first.

---

## :material-clock-check: Morning Briefs & Automations

### Daily Brief

Every morning, JP can auto-generate a brief:

- Yesterday's commits and merged PRs
- Today's urgent items (stale PRs, sprint deadlines)
- Sprint progress update
- Identified blockers

### Automations

Set up recurring workflows:

- *"Every Monday, generate a sprint review and send to Slack"*
- *"Every morning at 9am, post a standup summary"*
- *"After every sprint, generate a retrospective"*

---

## :material-brain: JP Memory

Jean-Pierre **remembers everything you tell it** — across conversations:

- **Preferences**: *"I prefer tables over bullet lists"*
- **Corrections**: *"The Jira key is INFRA, not BACKEND"*
- **Context**: *"We use 2-week sprints starting on Monday"*

Access memory anytime with `⌘M`. Memory persists in local SQLite.

---

## :material-puzzle: Pack System

Jean-Pierre adapts to your domain through **Packs** — modular configurations that define personality, tools, and UI:

### Available Packs

=== "PM Co-pilot"
    The default pack. GitHub + Jira + meeting notes + project tracking + AI analysis.

=== "Office Assistant"
    Schedule management, task tracking, document handling, and web research.

=== "Retail Operations"
    Inventory management, shift scheduling, and operational dashboards.

!!! tip "Custom Packs"
    Create your own pack with custom tools, prompts, and quick actions. Just add a `pack.yaml` to the `packs/` directory.

---

## :material-tools: Available Tools

JP has access to a comprehensive tool set:

### Base Tools (Always Available)

| Tool | What It Does |
|------|-------------|
| :material-file-document: **files** | Read, write, and list files on your machine |
| :material-console: **shell** | Execute shell commands |
| :material-information: **system** | System info (OS, memory, disk) |
| :material-web: **http** | Make HTTP requests |
| :material-magnify: **web_search** | Search the web for documentation and info |
| :material-note-text: **notes** | Persistent project notes |
| :material-notebook: **meeting_notes** | Structured meeting minutes |

### Domain Connectors

| Tool | Requires | What It Does |
|------|----------|-------------|
| :material-github: **github** | GitHub token | PRs, commits, issues, repos, reviewer suggestion |
| :material-jira: **jira** | Jira token | Sprint status, issues, boards, epic tracking |
| :material-cloud-sync: **aiflow_sync** | AIFlow token | Push reports to AIFlow platform |

---

## :material-shield-lock: Security & Privacy

!!! success "Your data never leaves your machine"
    Jean-Pierre runs **entirely locally**. No cloud. No telemetry on your code. No external databases.

| Aspect | How It Works |
|--------|-------------|
| **Data storage** | Everything in `~/.agentos/` on your machine |
| **AI provider** | Ollama (100% local) or your own OpenAI/Anthropic key |
| **Integrations** | Direct API calls — no proxy or intermediary |
| **Database** | Local SQLite — no external DB needed |
| **Air-gapped mode** | Works completely offline with Ollama |

---

## :material-keyboard: Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `⌘K` | Command Palette |
| `⌘M` | JP Memory |
| `⌘N` | New chat |
| `⌘T` | Tool Explorer |
| `⌘,` | Settings |
| `⌘R` | Refresh data |
| `/` | Focus chat |
| `Esc` | Close panel |

---

## :material-rocket-launch: Get Started

```bash
# 1. Clone
git clone https://github.com/unicolab/agentos && cd agentos

# 2. Build (Go 1.23+ and Node 20+)
make build

# 3. Setup (interactive wizard)
./build/agentos setup

# 4. Run
./build/agentos serve

# 5. Open
open http://localhost:18080
```

!!! tip "First run?"
    Jean-Pierre shows an **Onboarding Wizard** that guides you through AI provider setup, GitHub connection, and your first project.

---

<div style="text-align: center; padding: 40px 0 20px; opacity: 0.7;">
  <em>"Jean-Pierre doesn't just show you data — he understands your projects."</em><br>
  <strong>Built with ❤️ by <a href="https://unicolab.ai">UnicoLab</a></strong>
</div>
