# Security & Privacy

AgentOS is built with a **privacy-first, local-first architecture**. Your project data never leaves your machine.

---

![Privacy Shield](assets/images/privacy-shield.png)

## Our Privacy Promise

**Your data stays on YOUR machine.** AgentOS runs entirely locally — all project data, conversations, memories, and configurations are stored in a SQLite database on your computer.

---

## What Stays Local (100%)

| Data Type | Storage | Leaves Your Machine? |
|-----------|---------|---------------------|
| Project data (commits, PRs, issues) | SQLite on your computer | ❌ **Never** |
| Chat conversations & history | SQLite on your computer | ❌ **Never** |
| Agent memory & preferences | SQLite on your computer | ❌ **Never** |
| API keys & tokens | `~/.agentos/config.yaml` | ❌ **Never** |
| Meeting notes & documents | Local storage | ❌ **Never** |
| Dashboard configurations | Local storage | ❌ **Never** |

---

## What Is Communicated Externally

Only these specific, limited communications leave your machine:

### 1. 🔑 License Validation (Watchtower)
- **What**: License key check to verify your subscription
- **When**: On startup and periodically during use
- **Data sent**: License key, app version, seat count
- **Data NOT sent**: Any project data, conversations, or personal information

### 2. 🤖 AI Provider (Only if using cloud providers)
- **What**: Chat messages sent to your chosen AI provider
- **When**: Only when you chat with the agent
- **Providers**: OpenAI, Anthropic, or Google Gemini
- **Note**: If you use **Ollama**, this doesn't apply — everything stays local!

### 3. 🐙 GitHub / Jira APIs
- **What**: API requests to fetch your project data
- **When**: On dashboard refresh
- **Direction**: AgentOS → GitHub/Jira APIs (standard API calls)
- **Note**: This is the same as opening GitHub in your browser

### 4. 🐛 Bug Reports & Feedback (User-Initiated Only)
- **What**: Bug reports or feedback you explicitly choose to submit
- **When**: Only when YOU click "Submit Bug Report" or "Send Feedback"
- **Data sent**: Your description + optional system info
- **Data NOT sent**: Any project data or conversations

### 5. 📊 Anonymized Usage Statistics
- **What**: Basic usage counters (e.g., "user opened dashboard 5 times")
- **When**: Periodically, in the background
- **Data sent**: Anonymized counts and feature usage
- **Data NOT sent**: Any identifiable project data, code, or conversations

---

## Architecture

![Architecture](assets/images/architecture.png)

```
┌─────────────────────────────────────────────────┐
│               YOUR COMPUTER                      │
│                                                   │
│  ┌─────────────────────────────────────────────┐ │
│  │              AgentOS (Go binary)             │ │
│  │                                              │ │
│  │  SQLite DB ──── Chat History                 │ │
│  │  Config     ──── AI Memory                   │ │
│  │  Projects   ──── Meeting Notes               │ │
│  │                                              │ │
│  │  Web UI (React) ← Embedded in binary         │ │
│  └──────────────────────┬──────────────────────┘ │
│                         │                         │
└─────────────────────────┼─────────────────────────┘
                          │
              Encrypted API calls only ↓
                          │
     ┌────────────────────┼────────────────────┐
     │                    │                    │
  GitHub API          Jira API          AI Provider
  (your repos)     (your boards)     (Ollama = local!)
```

---

## API Key Security

- All API keys are stored locally in `~/.agentos/config.yaml`
- Keys are transmitted only to their respective services (GitHub token → GitHub API only)
- The AgentOS web UI masks API keys in the settings panel
- No API keys are ever logged or transmitted to UnicoLab

---

## Open Source Transparency

AgentOS is built on standard, auditable technologies:

- **Go** — Compiled binary, no hidden dependencies
- **SQLite** — Industry-standard local database
- **React** — Standard web UI framework
- **Standard APIs** — GitHub REST API, Jira REST API

---

## Questions?

If you have any security concerns or questions about our data handling, please:

- Open an issue on [GitHub](https://github.com/UnicoLab/agentos/issues)
- Contact us at [security@unicolab.ai](mailto:security@unicolab.ai)
