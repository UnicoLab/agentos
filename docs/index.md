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
<h3>Download</h3>
<p>Grab the binary for your platform from the <a href="https://github.com/UnicoLab/agentos/releases/latest">releases page</a></p>
</div>

<div class="step-card">
<div class="step-num">2</div>
<h3>Configure</h3>
<p>Run <code>agentos setup</code> — the wizard walks you through provider, integrations, and project setup</p>
</div>

<div class="step-card">
<div class="step-num">3</div>
<h3>Launch</h3>
<p>Run <code>agentos serve</code> and open <code>http://localhost:18080</code> — your AI agent is ready</p>
</div>

</div>

---

## Key Features

<div class="feature-grid">

<div class="feature-card">
<h3>🤖 AI Copilot</h3>
<p>Streaming chat with Ollama (local), OpenAI, Anthropic, or Google Gemini. Persistent memory that learns your preferences across conversations.</p>
</div>

<div class="feature-card">
<h3>📊 Smart Dashboard</h3>
<p>24-card bento-grid dashboard: KPIs, Risk Radar, Velocity Charts, Gantt, Heatmaps, Sprint Status, Team Leaderboard, and more — all drag-and-drop.</p>
</div>

<div class="feature-card">
<h3>🐙 GitHub Integration</h3>
<p>Multi-repo support: PRs, commits, issues, contributor activity, webhooks. Aggregate data across all your repositories in one view.</p>
</div>

<div class="feature-card">
<h3>📋 Jira Integration</h3>
<p>Multi-board support: sprint status, issue tracking, epic grouping, and WIP breakdown. Cross-referenced with GitHub data.</p>
</div>

<div class="feature-card">
<h3>🔒 Local-First Privacy</h3>
<p>Runs on YOUR machine. Data sovereignty by design. SQLite storage, no cloud sync unless you explicitly enable AIFlow Sync.</p>
</div>

<div class="feature-card">
<h3>⚡ Action Chain</h3>
<p>Watch your AI agent work in real-time — tool calls visualized as an expanding chain with per-step timing, arguments, and outputs.</p>
</div>

<div class="feature-card">
<h3>🧠 Agent Memory</h3>
<p>JP Memory auto-extracts facts, preferences, and corrections from every conversation and injects them as context in future replies.</p>
</div>

<div class="feature-card">
<h3>🛸 Fleet View</h3>
<p>Multi-project health overview — all projects ranked by risk score at a glance. Perfect for managers overseeing multiple teams.</p>
</div>

</div>

---

## Flavors — One Engine, Many Agents

AgentOS is built on a **flavor system** — each flavor is a specialized AI agent persona with its own personality, tools, and dashboard configuration.

<div class="flavor-grid">

<div class="flavor-card">
<div class="flavor-icon">🎩</div>
<h3>Jean-Pierre — The PM</h3>
<p>AI Project Management copilot. Tracks GitHub repos, Jira boards, generates standups, identifies risks, and manages your sprint.</p>
<a href="flavors/jean-pierre/">Learn more →</a>
</div>

<div class="flavor-card">
<div class="flavor-icon">🏢</div>
<h3>Office Assistant</h3>
<p>Document management, scheduling, and workflow automation for office productivity.</p>
<em>Coming soon</em>
</div>

<div class="flavor-card">
<div class="flavor-icon">🛒</div>
<h3>Retail Ops</h3>
<p>Inventory tracking, order management, and retail analytics AI assistant.</p>
<em>Coming soon</em>
</div>

</div>

---

## 🔓 No Vendor Lock-In — Full Control

AgentOS puts **you** in charge:

- 🤖 **Choose your AI model** — Ollama (free, local), OpenAI, Anthropic, or Gemini. Switch anytime.
- 📝 **Customize prompts** — Full control over the system prompt and agent behavior
- 🧰 **Pick your tools** — GitHub, Jira, Slack, AIFlow — enable only what you need
- 📂 **Own your data** — Standard SQLite. Export anytime. We never touch it.

---

## 🔒 Privacy & Data Security

<div class="privacy-badge">🔒 Your data stays on your machine</div>

AgentOS was designed with a **privacy-first architecture**:

| What stays local | What is communicated externally |
|---|---|
| ✅ All project data (commits, PRs, issues) | 🔑 License validation (Watchtower) |
| ✅ All chat conversations & history | 📊 Anonymized usage statistics |
| ✅ Agent memory & preferences | 🐛 Bug reports (user-initiated only) |
| ✅ Configuration & API keys | 💬 Feedback (user-initiated only) |
| ✅ Meeting notes & documents | |

All API keys (GitHub, Jira, etc.) are stored **securely on your local machine** in `~/.agentos/config.yaml` and are never transmitted to UnicoLab.

[Learn more about our security model →](security.md)

---

## 🧪 R&D Testing Program — Try It Free

!!! warning "License Required"
    AgentOS requires a valid license key to operate. To get a **free testing license**, email **[info@unicolab.ai](mailto:info@unicolab.ai)**.

AgentOS is an **experimental R&D project** — an autonomous compute node for project management. We're currently offering **free limited access to the PM flavor** (Jean-Pierre) in exchange for your feedback.

This is a **base engine** that can be extended to any profile, tools, or business needs. The PM flavor is our first deployment — more flavors are coming.

!!! note "Early Stage Software"
    There may be bugs as the project is in active R&D. Your feedback helps us improve!

### What you get:
- 🎁 **Free license key** — no cost, no commitment
- 🏷️ **Priority support** from the core team
- 🗳️ **Direct influence** on the roadmap

### How to get started:
1. **Download** from the [releases page](https://github.com/UnicoLab/agentos/releases/latest)
2. **Email** [info@unicolab.ai](mailto:info@unicolab.ai) to request your license
3. **Install, configure, and start using** — see the [Quick Start Guide](getting-started/quick-start.md)

<div class="hero-cta" markdown>

[Download Now :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button .md-button--primary }
[Request License :material-email:](mailto:info@unicolab.ai){ .md-button }

</div>

---

<p style="text-align: center; color: var(--md-default-fg-color--light); font-size: 0.9rem;">
<strong>Built with ❤️ by <a href="https://unicolab.ai">UnicoLab</a></strong><br>
<em>An autonomous compute node for the <a href="https://ai-flow.ai">AIFlow</a> project management platform.</em><br>
© 2024–2026 UnicoLab. All rights reserved.
</p>
