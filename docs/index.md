---
hide:
  - navigation
  - toc
---

<div class="hero" markdown>

<img src="assets/images/jp-orbital.png" alt="Jean-Pierre — AI PM Copilot" style="max-width: 400px; margin: 0 auto 1rem; display: block;">

# AgentOS

<p class="subtitle">
Local-first AI agents for your workflow — private, powerful, and fully customizable.<br>
Your data never leaves your machine. You choose the model, the prompt, the tools. <strong>No vendor lock-in.</strong>
</p>

<div class="hero-badges" markdown>

[![Platforms](https://img.shields.io/badge/Platforms-macOS%20·%20Linux%20·%20Windows-blueviolet?style=flat-square)]()
[![License](https://img.shields.io/badge/License-Free%20Testing-brightgreen?style=flat-square)](mailto:info@unicolab.ai)
[![Privacy](https://img.shields.io/badge/Privacy-Local%20First-success?style=flat-square)](security.md)

</div>

<div class="hero-cta" markdown>

[Download Latest Release :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button .md-button--primary }
[Get Started :material-rocket-launch:](getting-started/installation.md){ .md-button }

</div>

</div>

---

## What is AgentOS?

**AgentOS** is an AI-powered agent platform that runs **entirely on your machine**. It connects to your development tools — GitHub, Jira, Slack, and more — synthesizes everything into a premium intelligence dashboard, and lets you interact with your projects through natural language.

!!! tip "100% Private & Secure"
    All your project data, chat conversations, and configurations stay on your local machine. The **only** external communication is for licensing validation, bug reports, feedback, and anonymized usage statistics — **never your project data**.




---

## How It Works

<div class="step-grid">

<div class="step-card">
<div class="step-num">1</div>
<h3>Launch</h3>
<p>Run <code>agentos serve</code>. No complex installation required — the binary starts everything.</p>
</div>

<div class="step-card">
<div class="step-num">2</div>
<h3>Configure</h3>
<p>Either run <code>agentos setup</code> wizard or directly use the <strong>Web UI Settings</strong> to connect your agents.</p>
</div>

<div class="step-card">
<div class="step-num">3</div>
<h3>Interact</h3>
<p>AgentOS is live at <code>localhost:18080</code>. Your project intelligence is ready for natural language chat.</p>
</div>

</div>

---

## Key Features

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### 🤖 AI Copilot
Streaming chat with Ollama (local), OpenAI, Anthropic, or Gemini. Persistent memory that learns your preferences.
[AI Copilot →](features/ai-copilot.md)
</div>

<div class="feature-card" markdown>
### 📊 Smart Dashboard
24-card bento-grid: KPIs, Risk Radar, Velocity, Gantt, Heatmaps, Sprint Status, and more — all drag-and-drop.
[Dashboard →](features/dashboard.md)
</div>

<div class="feature-card" markdown>
### 🐙 Multi-Source Sync
Aggregate GitHub repos and Jira boards in one view. Track PRs, commits, issues, and contributor velocity.
</div>

<div class="feature-card" markdown>
### 🔒 Local-First Privacy
Runs on YOUR machine. Data sovereignty by design. SQLite storage, no cloud sync mandatory.
[Security →](security.md)
</div>

<div class="feature-card" markdown>
### ⚡ Action Chain
Watch your AI agent work. Tool calls visualized as an expanding chain with per-step timing and outputs.
</div>

<div class="feature-card" markdown>
### 🛸 Fleet View
Multi-project health overview — all projects ranked by risk score. Perfect for engineering managers.
</div>

</div>

---

## Flavors — One Engine, Many Agents

AgentOS is built on a **flavor system** — each flavor is a specialized AI agent persona with its own personality, tools, and visual DNA.

<div class="flavor-grid" markdown>

<div class="flavor-card" markdown>
<div class="flavor-icon">🎩</div>
### Jean-Pierre — The PM
AI Project Management copilot. GitHub + Jira + Slack intelligence. Risk identifies and sprint management.
[Learn more →](flavors/jean-pierre.md)
</div>

<div class="flavor-card" markdown>
<div class="flavor-icon">🏢</div>
### Office Assistant
Document management, scheduling, and workflow automation for office productivity.
<em>Coming soon</em>
</div>

<div class="flavor-card" markdown>
<div class="flavor-icon">🛒</div>
### Retail Ops
Inventory tracking, order management, and retail analytics AI assistant.
<em>Coming soon</em>
</div>

</div>

---

## 🔓 No Vendor Lock-In — Full Control

AgentOS puts **you** in charge of your intelligence infrastructure:

- 🤖 **Choose your AI model** — Ollama (local), OpenAI, Anthropic, or Gemini. Switch anytime.
- 📝 **Customize prompts** — Full control over system prompts and agent behavior.
- 🧰 **Pick your tools** — Enable only what is necessary for your workflow.
- 📂 **Own your data** — Standard SQLite storage. Export anytime. We never touch it.

---

## 🔒 Privacy & Data Security

<div class="privacy-badge">🔒 Your data stays on your machine</div>

AgentOS was designed with a **privacy-first architecture**:

| Data Type | Storage | Leaves Your Machine? |
|---|---|---|
| Project Data (Commits, PRs, etc) | Local SQLite | ❌ **Never** |
| Chat Conversations | Local SQLite | ❌ **Never** |
| Agent Memory | Local SQLite | ❌ **Never** |
| API Keys & Tokens | Local Config | ❌ **Never** |

All communication with UnicoLab Watchtower is limited to **license validation** and anonymous feature metrics.

[Learn more about our security model →](security.md)

---

## 🧪 R&D Testing Program — Try It Free

!!! warning "License Required"
    AgentOS requires a valid license key to operate. To get a **free testing license**, contact our team at **[info@unicolab.ai](mailto:info@unicolab.ai)**.

AgentOS is an **experimental AI platform** — an autonomous compute node for advanced project management. We are offering free access to the PM flavor (Jean-Pierre) during the public beta.

### How to get started:
1. **Download** from the official [releases page](https://github.com/UnicoLab/agentos/releases/latest)
2. **Email** [info@unicolab.ai](mailto:info@unicolab.ai) to request your activation key.
3. **Launch and Configure** — See the [Quick Start Guide](getting-started/quick-start.md) to get running in minutes.

<div class="hero-cta" markdown>

[Download AgentOS :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button .md-button--primary }
[Email for Key :material-email:](mailto:info@unicolab.ai){ .md-button }

</div>

---

<p style="text-align: center; color: var(--md-default-fg-color--light); font-size: 0.9rem;">
<strong>Built with ❤️ by <a href="https://unicolab.ai">UnicoLab</a></strong><br>
<em>An autonomous compute node for the <a href="https://ai-flow.ai">AIFlow</a> project management platform.</em><br>
© 2024–2026 UnicoLab. All rights reserved.
</p>
