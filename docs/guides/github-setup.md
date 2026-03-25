---
title: GitHub Integration
description: "Connect AgentOS to your GitHub repositories to track PRs, commits, issues, and contributor velocity in real-time."
---

<div class="hero" markdown>

# 🐙 GitHub Integration

Connect AgentOS to your GitHub repositories to track PRs, commits, issues, and contributor velocity in real-time.

<div class="hero-cta" markdown>
[Set Up Connectors :material-cog:](../getting-started/configuration.md){ .md-button .md-button--primary }
</div>

</div>

---

## 🔑 Security & Authentication

AgentOS uses **Personal Access Tokens (classic)** to communicate directly with GitHub's REST API. Your token is never shared with UnicoLab — it stays encrypted on your local machine.

<div class="step-grid" markdown>

<div class="step-card" markdown>
<div class="step-num">1</div>
### Generate Token
Visit [github.com/settings/tokens](https://github.com/settings/tokens) and create a new **Classic** token.
</div>

<div class="step-card" markdown>
<div class="step-num">2</div>
### Select Scopes
Enable the `repo` scope (covers private repositories, PRs, and issues).
</div>

<div class="step-card" markdown>
<div class="step-num">3</div>
### Connect
Copy the token and paste it into the **Settings > Integrations > GitHub** panel in the AgentOS Web UI.
</div>

</div>

---

## 📊 Mapping Your Workspace

Once the connector is active, you can link repositories to your projects.


### Multi-Repo Aggregation
Jean-Pierre can track multiple repositories under a single project. This is perfect for microservices or mono-repo workflows where a single "product" spans several codebases.

!!! example "Project Definition"
    - **Project**: Core Engine
    - **Repos**: `myorg/api`, `myorg/frontend`, `myorg/docs`
    - **Index Depth**: 30 Days (Recommended)

---

## 🏗️ What Jean-Pierre Indexes

- **Pull Requests**: Status, review blockers, and long-running "stale" PRs.
- **Commits**: Author velocity, heatmap activity, and codebase churn.
- **Issues**: Label-based tracking and milestone progress.
- **Contributors**: Active developers and contribution streaks.

---

## ⚡ Real-Time Webhooks (Advanced)

By default, AgentOS polls GitHub every few minutes. If you want instant updates, you can expose your local server (e.g., via ngrok) and set up a repository webhook pointing to:

`http://your-domain.com:18080/v1/webhook/github`

---

## 🚀 What GitHub Unlocks

Once connected, these features come alive with your real GitHub data:

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### :material-heart-pulse: Delivery Pulse
Real-time velocity tracking and AI burndown predictions from your commit and PR history.
[Learn more →](../features/delivery-pulse.md)
</div>

<div class="feature-card" markdown>
### :material-hammer-wrench: Sprint Forge
AI sprint planning calibrated to your team's real velocity from GitHub activity.
[Learn more →](../features/sprint-forge.md)
</div>

<div class="feature-card" markdown>
### :material-account-group: Team Pulse
Workload analysis and burnout detection from contributor commit and review patterns.
[Learn more →](../features/team-pulse.md)
</div>

<div class="feature-card" markdown>
### :material-lightbulb-on: Retro Intelligence
Data-driven retrospectives using PR cycle times, commit patterns, and blocker durations.
[Learn more →](../features/retro-intelligence.md)
</div>

</div>

---

<div class="hero-cta" markdown>
[Next: Connect Jira →](jira-setup.md){ .md-button }
</div>
