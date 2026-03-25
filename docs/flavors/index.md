---
title: "AgentOS Flavours — One Platform, Infinite Possibilities"
description: "AgentOS is a modular AI agent platform built like LEGO: a battle-tested backend engine, plug-and-play tool packs, and role-tailored frontends. Jean-Pierre is just the beginning."
---

<div class="hero" markdown>

# :material-puzzle: One Platform, Infinite Roles

AgentOS isn't just an AI project management tool. It's a **modular agent platform** — a production-grade engine with plug-and-play packs that can be configured for **any company role, any industry, any workflow**. Jean-Pierre is the first flavour. He won't be the last.

<div class="hero-cta" markdown>
[Meet Jean-Pierre →](jean-pierre.md){ .md-button .md-button--primary }
[Download AgentOS :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button }
</div>

</div>

---

## 🧱 Built Like LEGO

This is the real power of AgentOS: **every layer is modular**. The backend engine, the tool integrations, the dashboard widgets, the AI persona — they're all independent, composable blocks. Swap a pack, change a persona, plug in different tools — and you have an entirely new AI copilot for a completely different role.

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### :material-engine: Core Engine
A battle-tested Go backend with streaming AI orchestration, tool execution, memory, sessions, and a REST API. **Shared across all flavours** — proven, scalable, rock-solid.
</div>

<div class="feature-card" markdown>
### :material-puzzle-edit: Tool Packs
Modular integrations (GitHub, Jira, Slack, CRMs, ERPs, custom APIs) that plug into the engine. **Add or remove tools** without touching the core — like swapping LEGO bricks.
</div>

<div class="feature-card" markdown>
### :material-view-dashboard: Frontend Components
A library of premium UI widgets — Kanban boards, Gantt charts, KPI cards, heatmaps, risk radars — that **assemble into role-specific dashboards** automatically.
</div>

<div class="feature-card" markdown>
### :material-robot: Agent Persona
The AI personality, system prompt, communication style, and domain expertise. **This is what makes each flavour feel like a specialized expert** — not a generic chatbot.
</div>

</div>

---

## 🔮 How Flavours Work

A flavour is the **combination** of these LEGO blocks into a tailored experience for a specific role. Each flavour defines:

| Layer | What It Configures | Example (Jean-Pierre PM) |
|-------|-------------------|-------------------------|
| **Agent Persona** | Name, personality, domain expertise | French PM expert with formal style |
| **Tool Pack** | Which integrations are enabled | GitHub, Jira, Slack, Meeting Notes |
| **Dashboard Layout** | Which widgets appear and how | 24-card bento grid with Risk Radar, Velocity, Gantt |
| **Quick Actions** | One-click workflows | Standup Report, Sprint Plan, Risk Analysis |
| **Recipes** | Pre-built automation templates | 18 templates across reporting, monitoring, agile |

**Same engine. Same UI framework. Different configuration.** That's why we can launch a new flavour for a completely different industry in days, not months.

---

## 🚀 Available Flavours

<div class="flavor-grid" markdown>

<div class="flavor-card" markdown>
<div class="flavor-icon">🎩</div>
### Jean-Pierre — The PM
AI Project Management copilot. GitHub + Jira + Slack intelligence. 17 specialized features for sprint planning, delivery tracking, and team health.
<br>
**Binary:** `agentos-pm` · **Status: ✅ Available**
<br>
[Explore Jean-Pierre →](jean-pierre.md)
</div>

<div class="flavor-card" markdown>
<div class="flavor-icon">🛒</div>
### Retail Ops
Inventory, orders, shift management, and retail analytics assistant. Different tools, different dashboard, same powerful engine.
<br>
**Binary:** `agentos-retail` · **Status: ✅ Available**
</div>

<div class="flavor-card" markdown>
<div class="flavor-icon">🏢</div>
### Office Assistant
Document management, scheduling, and workflow automation for office productivity. Built with the same LEGO blocks, tailored for a different world.
<br>
**Binary:** `agentos-office` · **Status: ✅ Available**
</div>

</div>

---

## 🌍 The Possibilities Are Endless

Because AgentOS is modular, new flavours can be created for **any role that involves data, tools, and decisions**:

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### :material-headset: Customer Success
Connect CRM, support tickets, and NPS data. AI-powered churn prediction, account health scoring, and automated QBR prep.
</div>

<div class="feature-card" markdown>
### :material-currency-usd: Sales Operations
Pipeline analytics, deal risk scoring, forecasting, and automated rep coaching — all from your CRM and email data.
</div>

<div class="feature-card" markdown>
### :material-shield-check: Compliance & Audit
Regulation tracking, policy gap analysis, audit preparation, and real-time compliance monitoring across systems.
</div>

<div class="feature-card" markdown>
### :material-stethoscope: Healthcare Admin
Patient flow optimization, resource allocation, scheduling intelligence, and operational KPIs for hospital management.
</div>

<div class="feature-card" markdown>
### :material-truck-delivery: Logistics & Supply Chain
Route optimization, inventory forecasting, supplier risk analysis, and cross-dock scheduling intelligence.
</div>

<div class="feature-card" markdown>
### :material-school: Education & Training
Curriculum planning, student performance tracking, learning analytics, and automated progress reporting.
</div>

</div>

!!! tip "Enterprise Customization"
    Need a custom flavour for your organization? We build tailored AI copilots that connect to your proprietary tools and data sources — using the same proven engine that powers Jean-Pierre. **[Contact us](mailto:info@unicolab.ai)** to discuss your needs.

---

## ⚡ Installing a Flavour

Each flavour is installed with the same one-line command — just specify which one:

=== "macOS / Linux"

    ```bash
    # Jean-Pierre PM (default)
    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh

    # Retail Ops
    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour retail

    # Office Assistant
    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour office
    ```

=== "Windows"

    ```powershell
    # Download the installer
    curl -fsSL https://unicolab.github.io/agentos/install.bat -o install.bat

    # Jean-Pierre PM (default)
    .\install.bat

    # Retail Ops
    .\install.bat --flavour retail
    ```

!!! note "Binary is always called `agentos`"
    The installer automatically renames the per-flavour binary to `agentos` (or `agentos.exe`). All commands work the same regardless of flavour: `agentos serve`, `agentos chat`, `agentos setup`.

---

## 🖱️ Double-Click Launchers

Every download includes launcher scripts so you can start AgentOS **without opening a terminal**:

| Platform | File | Action |
|----------|------|--------|
| **macOS** | `Start AgentOS.command` | Double-click in Finder — clears Gatekeeper, opens browser |
| **Windows** | `Start AgentOS.bat` | Double-click in Explorer — opens browser |
| **Linux** | `start-agentos.sh` | Make executable, double-click in file manager |

---

<div class="hero-cta" markdown>
[Meet Jean-Pierre →](jean-pierre.md){ .md-button .md-button--primary }
[Download AgentOS :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button }
</div>