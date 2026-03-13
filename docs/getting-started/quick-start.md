# Quick Start

Follow this 5-minute guide to go from zero to your first AI-powered project insight.

---

## Prerequisites

Before you begin, make sure you have:

- [x] **AgentOS installed** — See the [Installation Guide](installation.md)
- [x] **An AI provider** — Either [Ollama](../guides/ollama-setup.md) (free, local) or an API key (OpenAI, Anthropic, Gemini)
- [x] **A GitHub repo** (optional) — For project tracking features

---

## Step 1: Run the Setup Wizard

If you haven't already run setup:

```bash
agentos setup
```

The wizard will walk you through each step interactively. You can also configure everything later through the web UI settings panel.

---

## Step 2: Start AgentOS

```bash
agentos serve
```

Your browser will automatically open to `http://localhost:18080`. You'll see the **Welcome Screen** with your agent ready to go.

---

## Step 3: Create Your First Project

1. Click **Projects** in the sidebar
2. Click **+ New Project**
3. Fill in:
    - **Project name** — e.g., "My Web App"
    - **GitHub repos** — e.g., `myorg/my-web-app`
    - **Color** — Pick a color for visual identification
4. Click **Create**

AgentOS will immediately start fetching data from your GitHub repos.

---

## Step 4: Talk to Your Agent

Open the chat panel (right sidebar) and try asking:

!!! example "Try these prompts"

    - *"Give me a standup report for My Web App"*
    - *"What are the open pull requests?"*
    - *"Show me the sprint status"*
    - *"Who has been most active this week?"*
    - *"What are the biggest risks in this project?"*

Your agent will use tools to fetch real-time data from your connected sources and generate structured, actionable reports.

---

## Step 5: Explore the Dashboard

Switch to the **Dashboard** view to see your project at a glance:

- **KPIs** — Open PRs, issues, commits, contributors
- **Risk Radar** — AI-scored risk assessment
- **Velocity Chart** — Commit activity over time
- **Gantt Chart** — AI-generated timeline from real data
- **Action Center** — Recommended next steps

<div class="screenshot">
<img src="../../screens/flavors/pm/classic-view-dashboard.png" alt="Dashboard View">
</div>

Every card is draggable and customizable. Click any card's **Ask JP** button to get AI analysis of that specific metric.

---

## Step 6: Use Quick Commands

Press ++cmd+k++ (macOS) or ++ctrl+k++ (Linux/Windows) to open the **Command Palette** — a spotlight-style search that lets you:

- Navigate to any view
- Run common PM workflows
- Ask your agent a quick question
- Trigger tool executions

---

## What's Next?

<div class="step-grid">

<div class="step-card">
<div class="step-num">🤖</div>
<h3>Set up Ollama</h3>
<p>Run AI 100% locally for free</p>
<a href="../guides/ollama-setup/">Guide →</a>
</div>

<div class="step-card">
<div class="step-num">🐙</div>
<h3>Connect GitHub</h3>
<p>Track repos, PRs, and contributor activity</p>
<a href="../guides/github-setup/">Guide →</a>
</div>

<div class="step-card">
<div class="step-num">📋</div>
<h3>Connect Jira</h3>
<p>Track sprints, issues, and epics</p>
<a href="../guides/jira-setup/">Guide →</a>
</div>

<div class="step-card">
<div class="step-num">⚙️</div>
<h3>Configure</h3>
<p>Deep-dive into all settings</p>
<a href="configuration/">Guide →</a>
</div>

</div>
