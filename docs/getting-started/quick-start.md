---
title: Quick Start Guide
description: "Go from zero to your first AI-powered project insight in 5 minutes. Follow this step-by-step guide to set up AgentOS."
---

<div class="hero" markdown>

# ⚡ Quick Start Guide

Follow this 5-minute guide to go from zero to your first AI-powered project insight.

<div class="hero-cta" markdown>
[Installation Guide :material-download:](installation.md){ .md-button .md-button--primary }
[Set up Ollama :material-robot:](../guides/ollama-setup.md){ .md-button }
</div>

</div>

---

## Prerequisites

Before you begin, ensure you have the core engine ready:

- [x] **AgentOS binary** — [Download your flavour](https://github.com/UnicoLab/agentos/releases/latest) (PM, Retail, or Office)
- [x] **AI Provider** — [Ollama](../guides/ollama-setup.md) (Local) or API Key (OpenAI/Anthropic/Gemini)
- [x] **Source Access** — GitHub personal access token (optional, but recommended)

!!! tip "One-Line Install"
    ```bash
    # Default (PM flavour)
    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh
    # Or choose: --flavour retail / --flavour office
    ```

---

## Getting Started

You can set up AgentOS in two ways: via the CLI or directly in the Web UI.

<div class="step-grid" markdown>

<div class="step-card" markdown>
<div class="step-num">1</div>
### Launch
Double-click `Start AgentOS.command` (macOS) or `Start AgentOS.bat` (Windows), or run `agentos serve` in your terminal. Your dashboard opens at `http://localhost:18080`.
</div>

<div class="step-card" markdown>
<div class="step-num">2</div>
### Configure
Either run `agentos setup` for an interactive CLI wizard, or skip it and go straight to the **Settings** panel in the Web UI to connect your agents.
</div>

<div class="step-card" markdown>
<div class="step-num">3</div>
### Track
Create your first project in the Web UI. Link your GitHub repositories to let Jean-Pierre start indexing your workspace.
</div>

<div class="step-card" markdown>
<div class="step-num">4</div>
### Chat
Open the chat sidebar and start talking. Ask for a standup, a risk assessment, or a summary of recent PRs.
</div>

</div>

---

## First Interaction

Once Jean-Pierre is connected, try these powerful prompts:

!!! example "PM Workflows"
    - *"Give me a standup report for my active project"*
    - *"Analyze the biggest risks in the current sprint"*
    - *"Show me all open pull requests with no reviews"*
    - *"Summarize the last 24 hours of activity"*

---

## Exploration

<div class="screenshot" markdown>
![Dashboard View](../assets/screens/flavors/pm/classic-view-dashboard.png)
</div>

Every card on the dashboard is interactive. Click **"Ask JP"** on any metric to get deep AI analysis of the underlying data.

---

## Next Steps

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### 🤖 Local AI
Set up Ollama to run high-fidelity LLMs 100% locally.
[Ollama Guide →](../guides/ollama-setup.md)
</div>

<div class="feature-card" markdown>
### 🐙 GitHub Sync
Deep-dive into multi-repo tracking and contributor metrics.
[GitHub Guide →](../guides/github-setup.md)
</div>

<div class="feature-card" markdown>
### 📋 Jira Integration
Track sprints, epics, and WIP across your organization.
[Jira Guide →](../guides/jira-setup.md)
</div>

<div class="feature-card" markdown>
### ⚙️ Full Reference
Explore every CLI command and configuration option.
[CLI Reference →](../reference/cli.md)
</div>

</div>
