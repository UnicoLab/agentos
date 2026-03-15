# AgentOS Flavours

AgentOS is built on a **flavour system** — each flavour is a specialized AI agent persona with its own personality, tools, dashboard configuration, and use case. Each flavour is a **separate binary** that you download and run.

---

<div class="hero" markdown>

## One Engine, Many Agents

A flavour is a tailored experience that transforms the base AgentOS engine into a specialized assistant. All flavours share the same commands (`agentos serve`, `agentos chat`, etc.) and the same powerful engine.

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### 🤖 Agent Persona
Name, personality, communication style, and specialized system prompt.
</div>

<div class="feature-card" markdown>
### 🧰 Available Tools
Which integrations and capabilities are enabled for the agent.
</div>

<div class="feature-card" markdown>
### 📊 Dashboard Layout
A custom bento-grid layout tailored to the flavour's specific data sources.
</div>

<div class="feature-card" markdown>
### ⚡ Quick Actions
One-click workflows and prompts tailored to the industry or role.
</div>

</div>

</div>

---

## Available Flavours

<div class="flavor-grid" markdown>

<div class="flavor-card" markdown>
<div class="flavor-icon">🎩</div>
### Jean-Pierre — The PM
AI Project Management copilot. GitHub + Jira + Slack intelligence.
<br>
**Binary:** `agentos-pm` · **Status: ✅ Available**
<br>
[Learn more →](jean-pierre.md)
</div>

<div class="flavor-card" markdown>
<div class="flavor-icon">🛒</div>
### Retail Ops
Inventory, orders, shift management, and retail analytics assistant.
<br>
**Binary:** `agentos-retail` · **Status: ✅ Available**
</div>

<div class="flavor-card" markdown>
<div class="flavor-icon">🏢</div>
### Office Assistant
Document management, scheduling, and workflow automation.
<br>
**Binary:** `agentos-office` · **Status: ✅ Available**
</div>

</div>

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

## 🎨 Custom Flavours

The AgentOS flavour system is designed to be fully extensible. We can create specialized agents for any role, industry, or complex workflow.

!!! tip "Enterprise Customization"
    Need a custom flavour for your organization? We can build tailored agents that connect to your proprietary tools and data sources. [Contact us](mailto:info@unicolab.ai) to discuss your needs.