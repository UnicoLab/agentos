<div align="center">

# AgentOS

### Local-First AI Copilots

**Composable AI agents that run on your machine. Connect your tools. Ask questions. Get answers.**

[![Platforms](https://img.shields.io/badge/Platforms-macOS%20·%20Linux%20·%20Windows-blueviolet?style=for-the-badge)]()
[![License](https://img.shields.io/badge/License-Free%20Testing-brightgreen?style=for-the-badge)](mailto:info@unicolab.ai)
[![Docs](https://img.shields.io/badge/Docs-unicolab.github.io-blue?style=for-the-badge)](https://unicolab.github.io/agentos)

[📖 Documentation](https://unicolab.github.io/agentos) · [📧 Request License](mailto:info@unicolab.ai) · [🐛 Report Bug](https://github.com/UnicoLab/agentos/issues)

</div>

---

## Quick Start

### One-Line Install (macOS / Linux)

```bash
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh
```

### Windows

```powershell
curl -fsSL https://unicolab.github.io/agentos/install.bat -o install.bat && install.bat
```

### Choose a Copilot

```bash
# Default: Jean-Pierre (PM)
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh

# Michelle (Analytics)
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour michelle

# Other copilots: freelancer, edith, retail, office
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour <name>
```

Open **http://localhost:18080** after install. All configuration is done in the Web UI.

> ⚠️ **License Required** — Email **[info@unicolab.ai](mailto:info@unicolab.ai)** for a free testing license.

---

## Available Copilots

| Copilot | Install Flag | What It Does |
|---------|-------------|--------------|
| 🎩 **Jean-Pierre** | `--flavour pm` (default) | PM copilot — GitHub, Jira, Slack integration |
| 📊 **Michelle** | `--flavour michelle` | Analytics — connect databases, ask questions in plain English |
| 💼 **Yvette** | `--flavour freelancer` | Freelancer PM — time tracking, invoicing, multi-client |
| 🥐 **Édith** | `--flavour edith` | Sales intelligence — CRM, pipeline scoring |
| 🛒 **Retail Ops** | `--flavour retail` | Inventory & retail analytics |
| 🏢 **Office** | `--flavour office` | Document management & workflow automation |

All copilots share the same engine — they differ in tools, persona, and dashboard.

---

## Configuration

After install, open the Web UI at `http://localhost:18080` and go to **Settings**:

1. **AI Provider** — Choose Ollama (free, local), OpenAI, Anthropic, or Gemini
2. **Integrations** — Connect GitHub, Jira, Slack, or databases
3. **License** — Enter your license key

Config is stored locally in `~/.agentos/config.yaml`.

### Supported AI Providers

| Provider | Type | Cost |
|----------|------|------|
| [Ollama](https://ollama.ai) | Local (on your machine) | Free |
| OpenAI | Cloud API | Per-token |
| Anthropic | Cloud API | Per-token |
| Google Gemini | Cloud API | Per-token |

> 💡 **Use Ollama** for fully local operation — your data never leaves your machine.

---

## Manual Install

<details>
<summary><strong>📥 Download & install manually</strong></summary>

```bash
# Download the binary for your platform from the docs
# Example: PM copilot on Apple Silicon
tar xzf agentos-pm_*.tar.gz
mv agentos-pm agentos

# macOS: clear Gatekeeper
xattr -rd com.apple.quarantine ./agentos
codesign --force --sign - ./agentos

# Run
./agentos serve

# Or install to PATH
sudo mv agentos /usr/local/bin/
agentos serve
```

Each download also includes **double-click launchers** — no terminal required:

| Platform | File |
|----------|------|
| macOS | `Start AgentOS.command` |
| Windows | `Start AgentOS.bat` |
| Linux | `start-agentos.sh` |

</details>

---

## Privacy

All data stays on your machine — conversations, memory, API keys, project data. Nothing is transmitted to UnicoLab. Using Ollama means zero cloud communication.

→ [Security & Privacy Details](https://unicolab.github.io/agentos/security/)

---

## Documentation

- [Installation Guide](https://unicolab.github.io/agentos/getting-started/installation/)
- [Quick Start](https://unicolab.github.io/agentos/getting-started/quick-start/)
- [Ollama Setup](https://unicolab.github.io/agentos/guides/ollama-setup/)
- [GitHub Integration](https://unicolab.github.io/agentos/guides/github-setup/)
- [Jira Integration](https://unicolab.github.io/agentos/guides/jira-setup/)
- [CLI Reference](https://unicolab.github.io/agentos/reference/cli/)
- [API Reference](https://unicolab.github.io/agentos/reference/api/)

---

## Tech Stack

- **Go** — Single binary, no dependencies
- **Vite + React + TypeScript** — Embedded web UI
- **SQLite** — Local persistence
- **SSE** — Real-time streaming

---

<div align="center">

**Built with ❤️ by [UnicoLab](https://unicolab.ai)**

*Part of the [AIFlow](https://ai-flow.ai) ecosystem.*

</div>
