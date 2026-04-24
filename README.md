<div align="center">

# AgentOS

### 🤖 Composable AI Copilots — Local-First

**Two flagship copilots. One modular platform. 100% private.**

[![Platforms](https://img.shields.io/badge/Platforms-macOS%20·%20Linux%20·%20Windows-blueviolet?style=for-the-badge)](https://github.com/UnicoLab/agentos/releases/latest)
[![License](https://img.shields.io/badge/License-Free%20Testing-brightgreen?style=for-the-badge)](mailto:info@unicolab.ai)
[![Docs](https://img.shields.io/badge/Docs-unicolab.github.io-blue?style=for-the-badge)](https://unicolab.github.io/agentos)

[📥 Download](https://github.com/UnicoLab/agentos/releases/latest) · [📖 Documentation](https://unicolab.github.io/agentos) · [📧 Request License](mailto:info@unicolab.ai) · [🐛 Report Bug](https://github.com/UnicoLab/agentos/issues)

---

<img src="docs/assets/images/jp-orbital.png" width="400" alt="Jean-Pierre — AI PM Copilot">
<img src="docs/assets/images/michelle-avatar.png" width="120" alt="Michelle — AI Analytics Copilot" style="border-radius: 50%;">

</div>

---

## What is AgentOS?

**AgentOS** is a composable AI agent platform that runs **entirely on your machine**. It builds specialized copilots — **Jean-Pierre** for Project Management and **Michelle** for Analytics Intelligence — each with its own tools, dashboards, and domain expertise. Connect your GitHub, Jira, Slack, or databases and get instant intelligence through natural language.

> ⚠️ **License Required** — AgentOS requires a valid license key. Email **[info@unicolab.ai](mailto:info@unicolab.ai)** for a **free testing license**.

> 🧪 **R&D Project** — This is an experimental autonomous compute node for project management. Currently offering **free access to the PM flavor** in exchange for feedback. There may be bugs — your reports help us improve!

### 🔒 Your data stays on YOUR machine

All project data, conversations, memories, and configurations are stored locally. API keys (GitHub, Jira, etc.) are stored securely in `~/.agentos/config.yaml` and **never transmitted to UnicoLab**. The only external communication is for license validation and optional anonymized usage statistics.

### 🔓 No Vendor Lock-In

You have **full control** over which AI model to use, which prompts to configure, and which tools to enable. Switch between Ollama (free, local), OpenAI, Anthropic, or Gemini at any time. Customize everything to your needs.

> See our full [Security & Privacy](https://unicolab.github.io/agentos/security/) page for details.

---

## ⚡ Quick Start

### One-Line Install (macOS / Linux)

```bash
# Jean-Pierre PM (default)
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh

# Michelle Analytics
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour michelle

# Other flavours:
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour freelancer
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour edith
```

This auto-detects your OS and architecture, downloads the correct flavour binary, handles macOS Gatekeeper security, installs to PATH, and launches AgentOS — all in one command. Works with or without admin access.

### Windows Install

```powershell
# Download and run the installer (default: PM flavour)
curl -fsSL https://unicolab.github.io/agentos/install.bat -o install.bat && install.bat

# Choose a different flavour:
install.bat --flavour michelle
install.bat --flavour freelancer
install.bat --flavour retail
install.bat --flavour office
```

This downloads the correct binary, renames it to `agentos.exe`, installs to `%LOCALAPPDATA%\AgentOS`, adds to PATH, and launches — all automatically.

### Manual Install

<details>
<summary><strong>📥 Download manually</strong></summary>

Each flavour is a separate binary. Choose the one you need:

| Flavour | Platform | Architecture | Binary |
|---------|----------|-------------|--------|
| 🎩 **PM** | macOS Apple Silicon | arm64 | `agentos-pm_*_darwin_arm64.tar.gz` |
| 🎩 **PM** | macOS Intel | amd64 | `agentos-pm_*_darwin_amd64.tar.gz` |
| 🎩 **PM** | Linux x86 | amd64 | `agentos-pm_*_linux_amd64.tar.gz` |
| 📊 **Michelle** | macOS Apple Silicon | arm64 | `agentos-michelle_*_darwin_arm64.tar.gz` |
| 📊 **Michelle** | macOS Intel | amd64 | `agentos-michelle_*_darwin_amd64.tar.gz` |
| 📊 **Michelle** | Linux x86 | amd64 | `agentos-michelle_*_linux_amd64.tar.gz` |
| 💼 **Freelancer** | macOS Apple Silicon | arm64 | `agentos-freelancer_*_darwin_arm64.tar.gz` |
| 💼 **Freelancer** | macOS Intel | amd64 | `agentos-freelancer_*_darwin_amd64.tar.gz` |
| 💼 **Freelancer** | Linux x86 | amd64 | `agentos-freelancer_*_linux_amd64.tar.gz` |
| 🥐 **Edith** | macOS Apple Silicon | arm64 | `agentos-edith_*_darwin_arm64.tar.gz` |
| 🥐 **Edith** | macOS Intel | amd64 | `agentos-edith_*_darwin_amd64.tar.gz` |
| 🥐 **Edith** | Linux x86 | amd64 | `agentos-edith_*_linux_amd64.tar.gz` |
| 🛒 **Retail** | macOS Apple Silicon | arm64 | `agentos-retail_*_darwin_arm64.tar.gz` |
| 🛒 **Retail** | macOS Intel | amd64 | `agentos-retail_*_darwin_amd64.tar.gz` |
| 🛒 **Retail** | Linux x86 | amd64 | `agentos-retail_*_linux_amd64.tar.gz` |
| 🏢 **Office** | macOS Apple Silicon | arm64 | `agentos-office_*_darwin_arm64.tar.gz` |
| 🏢 **Office** | macOS Intel | amd64 | `agentos-office_*_darwin_amd64.tar.gz` |
| 🏢 **Office** | Linux x86 | amd64 | `agentos-office_*_linux_amd64.tar.gz` |

Full list on the [Releases Page](https://github.com/UnicoLab/agentos/releases/latest).

```bash
# Extract (example: PM flavour on Apple Silicon)
tar xzf agentos-pm_*.tar.gz

# The archive contains the binary — rename to 'agentos' for consistency
mv agentos-pm agentos

# macOS: clear Gatekeeper
xattr -rd com.apple.quarantine ./agentos
codesign --force --sign - ./agentos

# Run (no install needed)
./agentos serve

# Or install to PATH
sudo mv agentos /usr/local/bin/
agentos serve
```

> 💡 No admin? No problem — just run `./agentos serve` from any folder. The install script does the rename automatically.

</details>

That's it! 🎉 Open `http://localhost:18080` and configure everything in the **Web UI Settings**.

### 🖱️ No Terminal Needed

Every download includes **double-click launcher scripts** — no command line required:

| Platform | File | Action |
|----------|------|--------|
| **macOS** | `Start AgentOS.command` | Double-click in Finder — clears Gatekeeper, opens browser |
| **Windows** | `Start AgentOS.bat` | Double-click in Explorer — opens browser |
| **Linux** | `start-agentos.sh` | Make executable, double-click in file manager |

> 📖 **Detailed guides:** [Installation](https://unicolab.github.io/agentos/getting-started/installation/) · [Ollama Setup](https://unicolab.github.io/agentos/guides/ollama-setup/) · [GitHub Setup](https://unicolab.github.io/agentos/guides/github-setup/)

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎩 Jean-Pierre — PM Copilot
- **17 specialized features** — sprint planning, delivery tracking, team health
- **24-card living dashboard** — KPIs, Risk Radar, Gantt, Velocity, Heatmaps
- **Proactive risk detection** — catches problems before stakeholders notice
- **GitHub + Jira + Slack** — multi-repo, multi-board intelligence

</td>
<td width="50%">

### 📊 Michelle — Analytics Copilot
- **Business answers in plain English** — ask questions, get verified SQL answers in seconds
- **Anti-hallucination engine** — every answer verified against real DB execution, auto-corrected if wrong
- **Full auditability** — see exact SQL, source tables, confidence scores, and provenance trail
- **DB auto-discovery** — connects to your databases, detects schemas, tables, columns, and relations automatically
- **Business context** — define KPIs, glossary, rules, and templates used as context for every answer
- **Shared Brain** — federated learning across agents, knowledge survives team turnover
- **Dynamic dashboards** — 9 chart types, KPI monitoring, alerting, and pinnacle insights
- **Background scheduling** — schedule reports and monitoring tasks, set and forget
- **Extensible connectors** — connect to any data source, use any LLM or local SLM
- **Report builder** — SQL playground, visualizer, and one-click executive reports

</td>
</tr>
</table>

### Platform Capabilities (shared by all copilots)

🧠 **Adaptive Memory** · 🧬 **Self-Reflection & Dreaming Cycles** · 📊 **Dynamic Dashboards** · ⚡ **Action Chain Transparency** · 🔒 **100% Local Privacy** · 🤖 **Multi-Provider AI** (Ollama, OpenAI, Anthropic, Gemini) · 🔄 **Federated Learning** · 📋 **Background Scheduling** · 🔌 **Extensible Connectors**

---

## 🖼️ Screenshots

<details>
<summary><strong>📊 Dashboard — Classic View</strong></summary>

<img src="docs/assets/screens/flavors/pm/classic-view-dashboard.png" width="100%" alt="Dashboard">

</details>

<details>
<summary><strong>💬 AI Chat — Planning Session</strong></summary>

<img src="docs/assets/screens/flavors/pm/JP-chat-planning.png" width="100%" alt="Chat">

</details>

<details>
<summary><strong>📁 Projects Page</strong></summary>

<img src="docs/assets/screens/flavors/pm/projects-page.png" width="100%" alt="Projects">

</details>

<details>
<summary><strong>⚙️ Settings — Model Configuration</strong></summary>

<img src="docs/assets/screens/flavors/pm/model-config.png" width="100%" alt="Model Config">

</details>

---

## 🎩 Copilots & Flavours

AgentOS uses a **composable flavour system** — each flavour is a specialized copilot with its own AI persona, tools, and dashboard:

### Flagships

| Copilot | Binary | Description | Status |
|---------|--------|-------------|--------|
| 🎩 **Jean-Pierre — PM** | `agentos-pm` | Project management copilot (GitHub + Jira + Slack) | ✅ Free testing access |
| 📊 **Michelle — Analytics** | `agentos-michelle` | Analytics intelligence (databases, SQL, KPIs) | ✅ Free testing access |

### More Copilots

| Copilot | Binary | Description | Status |
|---------|--------|-------------|--------|
| 💼 **Yvette — Freelancer PM** | `agentos-freelancer` | Time tracking, invoicing, multi-client management | ✅ Free testing access |
| 🥐 **Édith — Sales Intelligence** | `agentos-edith` | CRM analytics, pipeline scoring, prospect research | ✅ Free testing access |
| 🛒 **Retail Ops** | `agentos-retail` | Inventory & retail analytics | ✅ Free testing access |
| 🏢 **Office Assistant** | `agentos-office` | Document management & workflow automation | ✅ Free testing access |

All flavours share the same powerful engine — they differ in their AI persona, tools, and dashboard.

```bash
# Install the PM copilot (default)
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh

# Install Michelle Analytics
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour michelle
```

AgentOS is a **composable engine** that can be extended to any role. [Contact us](mailto:info@unicolab.ai) for custom copilots.

---

## 🛡️ Privacy & Security

<img src="docs/assets/images/privacy-shield.png" width="250" align="center" alt="Privacy Shield">

| ✅ Stays on your machine | ↗️ External communication |
|---|---|
| All project data | 🔑 License validation only |
| Chat conversations | 📊 Anonymized usage stats |
| Agent memory | 🐛 Bug reports (user-initiated) |
| API keys & config | 💬 Feedback (user-initiated) |
| Meeting notes | |

**Using Ollama?** Then even your AI conversations never leave your machine. Zero cloud, zero tracking, zero data exfiltration.

> 📖 Full details: [Security & Privacy](https://unicolab.github.io/agentos/security/)

---

## 🧪 Free Testing Program

We're looking for **testers** to try AgentOS and share feedback! In exchange, you'll receive:

- ✅ **Free license key** — no cost, no commitment
- ✅ **Priority support** from the core team
- ✅ **Direct influence** on the roadmap

**→ Email [info@unicolab.ai](mailto:info@unicolab.ai)** to request your free license

---

## 📖 Documentation

Visit our full documentation at **[unicolab.github.io/agentos](https://unicolab.github.io/agentos)**:

- [Installation Guide](https://unicolab.github.io/agentos/getting-started/installation/)
- [Quick Start (5 minutes)](https://unicolab.github.io/agentos/getting-started/quick-start/)
- [Ollama Setup (Free Local AI)](https://unicolab.github.io/agentos/guides/ollama-setup/)
- [GitHub Integration](https://unicolab.github.io/agentos/guides/github-setup/)
- [Jira Integration](https://unicolab.github.io/agentos/guides/jira-setup/)
- [CLI Reference](https://unicolab.github.io/agentos/reference/cli/)
- [API Reference](https://unicolab.github.io/agentos/reference/api/)
- [Security & Privacy](https://unicolab.github.io/agentos/security/)

---

## ⌨️ Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `⌘K` | Command Palette |
| `⌘M` | JP Memory |
| `⌘N` | New chat |
| `⌘,` | Settings |
| `⌘R` | Refresh data |
| `/` | Focus chat |
| `?` | Shortcuts help |

--- 

<div align="center">

---

**Built with ❤️ by [UnicoLab](https://unicolab.ai)**

*Composable AI copilots for the [AIFlow](https://ai-flow.ai) ecosystem.*

*"AgentOS copilots don't just show you data — they understand your world."*

[![UnicoLab](https://img.shields.io/badge/Made%20by-UnicoLab-6c63ff?style=flat-square&logo=data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48Y2lyY2xlIGN4PSIxMiIgY3k9IjEyIiByPSIxMCIgZmlsbD0id2hpdGUiLz48L3N2Zz4=)](https://unicolab.ai)
[![AIFlow](https://img.shields.io/badge/Part%20of-AIFlow%20Ecosystem-06b6d4?style=flat-square)](https://ai-flow.ai)

</div>
