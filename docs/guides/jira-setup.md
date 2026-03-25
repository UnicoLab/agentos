---
title: Jira Integration
description: "Connect AgentOS to your Jira boards to track sprints, issues, epics, and team workload with AI-powered analytics."
---

<div class="hero" markdown>

# 📋 Jira Integration

Connect AgentOS to your Jira boards to track sprints, issues, epics, and team workload.

<div class="hero-cta" markdown>
[Set Up Connectors :material-cog:](../getting-started/configuration.md){ .md-button .md-button--primary }
</div>

</div>

---

## 🏗️ Setup Workflow

<div class="step-grid" markdown>

<div class="step-card" markdown>
<div class="step-num">1</div>
### Create Token
Visit [id.atlassian.com](https://id.atlassian.com/manage-profile/security/api-tokens) and generate a new API token labeled "AgentOS".
</div>

<div class="step-card" markdown>
<div class="step-num">2</div>
### Authenticate
Enter your **Site URL** (`yourcompany.atlassian.net`), your **email**, and the **token** in the Settings panel.
</div>

<div class="step-card" markdown>
<div class="step-num">3</div>
### Link Boards
Add your Board IDs to your project configuration. Jean-Pierre will begin hydration immediately.
</div>

</div>

---

## 📊 Mapping Your Jira Boards


!!! info "Finding your Board ID"
    Open your Jira board in a browser. The numerical value at the end of the URL (e.g., `.../boards/42`) is your **Board ID**.

---

## 🎨 Intelligence Delivered

Once connected, your dashboard is enriched with professional project metrics:

- **Sprint Status**: Interactive WIP vs. Done progress rings.
- **Epic Tracker**: Grouped issue views with roll-up progress bars.
- **Issue Mind Map**: A visual dependency graph of your backlog.
- **Sprint Planner**: AI-suggested milestones based on velocity.

---

## 🚀 What Jira Unlocks

Connect Jira to power these features with your sprint and backlog data:

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### :material-hammer-wrench: Sprint Forge
AI sprint planning that pulls live backlog data, analyzes velocity, and generates scoped sprint plans.
[Learn more →](../features/sprint-forge.md)
</div>

<div class="feature-card" markdown>
### :material-map-marker-path: Roadmap
Auto-generated timelines from your Jira epics and release targets — always current.
[Learn more →](../features/roadmap.md)
</div>

<div class="feature-card" markdown>
### :material-checkbox-marked: Tasks
AI-generated task lists from sprint risks, open blockers, and backlog priorities.
[Learn more →](../features/tasks.md)
</div>

<div class="feature-card" markdown>
### :material-radar: Dependency Radar
Cross-project dependency visualization from Jira issue links and epic relationships.
[Learn more →](../features/dependency-radar.md)
</div>

</div>

---

<div class="hero-cta" markdown>
[Next: Connect Slack →](slack-setup.md){ .md-button }
</div>
