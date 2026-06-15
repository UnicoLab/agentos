<div align="center">

# ⬡ AgentOS

### Local-First AI Copilots for Work

**Run AI agents on your machine. Connect your tools. Ask questions. Get answers.**
**Your data never leaves your computer.**

[![Platforms](https://img.shields.io/badge/Platforms-macOS%20·%20Linux%20·%20Windows-blueviolet?style=for-the-badge)]()
[![License](https://img.shields.io/badge/License-Free%20Trial-brightgreen?style=for-the-badge)](mailto:info@unicolab.ai)
[![Docs](https://img.shields.io/badge/Docs-unicolab.github.io-blue?style=for-the-badge)](https://unicolab.github.io/agentos)

[📖 Documentation](https://unicolab.github.io/agentos) · [📧 Get a License](mailto:info@unicolab.ai) · [🐛 Report Bug](https://github.com/UnicoLab/agentos/issues)

</div>

---

## ⚡ Quick Install

### macOS / Linux (one line)

```bash
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh
```

### Windows

```powershell
curl -fsSL https://unicolab.github.io/agentos/install.bat -o install.bat && install.bat
```

> The installer auto-detects your OS and architecture, clears macOS Gatekeeper, and launches the web UI — no extra steps needed.

---

## 🎩 Meet the Copilots

AgentOS ships with **three specialized AI copilots**, each designed for a different role. All share the same engine — they differ in tools, persona, and dashboard.

### 🎩 Jean-Pierre — Project Management

> *Your AI PM co-pilot — track projects, manage sprints, run standups, and ship on time.*

```bash
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh
```

- Sprint forge with delivery pulse and retro intelligence
- GitHub, Jira, and Slack integration
- Standup scribe and meeting notes
- Roadmap visualization and dependency radar
- AIFlow central sync for fleet management

---

### 🔬 Michelle — Analytics Intelligence

> *Connect your databases, ask questions in plain English, get insights that improve over time.*

```bash
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour michelle
```

- Multi-database connection (PostgreSQL, MySQL, SQLite, BigQuery, and more)
- Natural language SQL generation with self-improving accuracy
- KPI dashboards, report builder, and training pipeline
- Schema browser and context explorer
- Business rules engine for domain-specific analytics

---

### 🥐 Brigitte — Management Intelligence

> *People-centric copilot for team leads, managers, and executives who care about their teams.*

```bash
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour brigitte
```

- Team pulse tracking and 1:1 preparation
- Promise tracker and commitment follow-through
- Weak signal detection for team health
- People knowledge base with interaction history
- Celebration engine for recognizing wins

---

## 🔑 Activation

When you first start AgentOS, the **web UI** opens automatically in your browser with three activation options:

| Method | How |
|--------|-----|
| **🎟️ Free Trial** | Enter your name and email — instant 7-day trial, no credit card |
| **🔑 License Key** | Paste your license key (email [info@unicolab.ai](mailto:info@unicolab.ai) to get one) |
| **📦 Import Config** | Upload a `.agentoscfg` file shared by your team |

> 💡 **No terminal setup required** — everything happens in the browser.

---

## ⚙️ Configuration

After activation, go to **Settings** in the web UI:

1. **AI Provider** — Choose Ollama (free, local), OpenAI, Anthropic, or Google Gemini
2. **Integrations** — Connect GitHub, Jira, Slack, or databases
3. **License** — Manage your license or switch copilots

### Supported AI Providers

| Provider | Type | Cost |
|----------|------|------|
| [Ollama](https://ollama.ai) | Local (runs on your machine) | Free |
| OpenAI | Cloud API | Per-token |
| Anthropic | Cloud API | Per-token |
| Google Gemini | Cloud API | Per-token |

> 💡 **Recommended:** Use [Ollama](https://ollama.ai) for fully local operation — your data never leaves your machine. Install it, pull a model (`ollama pull qwen3`), and you're ready.

---

## 🍎 macOS Troubleshooting

If you used the `curl | sh` installer, everything is handled automatically. If you downloaded the binary manually and macOS blocks it:

### Quick Fix (one line)

```bash
curl -fsSL https://unicolab.github.io/agentos/fix-macos.sh | sh
```

### Manual Fix

```bash
# Clear quarantine
xattr -rd com.apple.quarantine ./agentos

# Make executable
chmod +x ./agentos

# Ad-hoc code sign
codesign --force --sign - ./agentos

# Run
./agentos serve
```

> Each download also includes a **`Start AgentOS.command`** file — double-click it in Finder and it handles quarantine, signing, and launching automatically.

---

## 📥 Manual Install

<details>
<summary><strong>Download & install without the script</strong></summary>

1. Go to [Releases](https://github.com/UnicoLab/agentos/releases)
2. Download the archive for your platform:
   - `agentos-pm_darwin_arm64.tar.gz` — macOS Apple Silicon
   - `agentos-pm_darwin_amd64.tar.gz` — macOS Intel
   - `agentos-pm_linux_arm64.tar.gz` — Linux ARM
   - `agentos-pm_linux_amd64.tar.gz` — Linux x86_64
3. Extract and run:

```bash
tar xzf agentos-pm_*.tar.gz
cd agentos-pm_*/

# macOS: run the fix script first
curl -fsSL https://unicolab.github.io/agentos/fix-macos.sh | sh

# Start
./agentos serve
```

Or just **double-click** the included launcher:

| Platform | Launcher File |
|----------|---------------|
| macOS | `Start AgentOS.command` |
| Linux | `start-agentos.sh` |
| Windows | `Start AgentOS.bat` |

</details>

---

## 🔒 Privacy

All data stays on your machine — conversations, memory, API keys, project data. **Nothing is transmitted to UnicoLab.** Using Ollama means zero cloud communication.

→ [Security & Privacy Details](https://unicolab.github.io/agentos/security/)

---

## 📚 Documentation

- [Installation Guide](https://unicolab.github.io/agentos/getting-started/installation/)
- [Quick Start](https://unicolab.github.io/agentos/getting-started/quick-start/)
- [Configuration](https://unicolab.github.io/agentos/getting-started/configuration/)
- [Ollama Setup](https://unicolab.github.io/agentos/guides/ollama-setup/)
- [GitHub Integration](https://unicolab.github.io/agentos/guides/github-setup/)
- [Jira Integration](https://unicolab.github.io/agentos/guides/jira-setup/)
- [Slack Integration](https://unicolab.github.io/agentos/guides/slack-setup/)
- [CLI Reference](https://unicolab.github.io/agentos/reference/cli/)
- [API Reference](https://unicolab.github.io/agentos/reference/api/)

---

## 🏗️ Tech Stack

- **Go** — Single binary, zero dependencies
- **React 19 + TypeScript** — Embedded web UI (Vite build)
- **SQLite** — Local persistence with full-text search
- **SSE** — Real-time streaming for chat and events

---

<div align="center">

**Built with ❤️ by [UnicoLab](https://unicolab.ai)**

*Part of the [AIFlow](https://ai-flow.ai) ecosystem.*

</div>
