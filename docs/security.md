<div class="hero" markdown>

# Security & Privacy

<div class="privacy-badge">🔒 Your data stays on your machine</div>

Local-first AI agents for your workflow — private, powerful, and fully customizable.
Your data never leaves your machine. You choose the model, the prompt, the tools.

</div>

---

## Our Privacy Promise

**Your data stays on YOUR machine.** AgentOS runs entirely locally — all project data, conversations, memories, and configurations are stored in an encrypted SQLite database on your computer. There is no cloud backend, no shared server, and no telemetry on your project data.

---

## What Stays Local (100%)

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### 📂 Project Data
Commits, PRs, issues, and sprint data are stored locally. Fetched via encrypted API calls directly to GitHub/Jira — the same calls your browser makes.
</div>

<div class="feature-card" markdown>
### 💬 Chat History
All your conversations with Jean-Pierre are stored in your local SQLite database. 100% private. No cloud logging.
</div>

<div class="feature-card" markdown>
### 🧠 Agent Memory
Your preferences, learned facts, team structures, and corrections stay local. Memory is persisted in the same encrypted store.
</div>

<div class="feature-card" markdown>
### 📝 Meeting Notes
All AI-generated meeting minutes, action items, and follow-ups are stored locally. Your meeting intelligence is yours alone.
</div>

</div>

---

## 🔐 Encryption & Password Security

AgentOS takes data protection seriously at every layer:

<div class="step-grid" markdown>

<div class="step-card" markdown>
<div class="step-num">🗄️</div>
### Encrypted Storage
All data is stored in an **encrypted SQLite database** on your local file system. Project metrics, conversations, memories, and meeting notes are protected at rest.
</div>

<div class="step-card" markdown>
<div class="step-num">🔑</div>
### API Key Security
All API keys and tokens are stored in your local `~/.agentos/config.yaml`. They are **masked in the UI**, transmitted only to their respective services over TLS-encrypted channels, and **never logged or sent to UnicoLab**.
</div>

<div class="step-card" markdown>
<div class="step-num">🔒</div>
### Zero Cloud Storage
There is **no UnicoLab server** that stores your data. No cloud database, no S3 buckets, no analytics pipelines processing your project metrics. Everything computes and persists locally.
</div>

<div class="step-card" markdown>
<div class="step-num">🛡️</div>
### Secure Connections
All external API calls (GitHub, Jira, Slack, AI providers) use **TLS-encrypted HTTPS channels**. No data is transmitted in plain text. Connections are direct — no proxy or middleman.
</div>

</div>

---

## External Communication

Only specific, limited communications leave your machine:

<div class="step-grid" markdown>

<div class="step-card" markdown>
<div class="step-num">🔑</div>
### License Validation
Periodic check with UnicoLab Watchtower to verify your subscription. **No project data is transmitted** — only your license key.
</div>

<div class="step-card" markdown>
<div class="step-num">🤖</div>
### AI Provider
Only if using cloud APIs (OpenAI/Anthropic/Gemini). **Ollama is 100% local** — your prompts never leave your machine.
</div>

<div class="step-card" markdown>
<div class="step-num">🐙</div>
### Tool Sync
Direct encrypted calls to GitHub/Jira APIs — the same connections your browser makes. No data is routed through UnicoLab.
</div>

<div class="step-card" markdown>
<div class="step-num">📊</div>
### Metrics
Anonymized feature usage statistics to help us improve the engine. **Never your project data, conversations, or code.**
</div>

</div>

---

## 📐 Architecture Design

<div class="screenshot" markdown>
![Architecture](assets/images/architecture.png)
</div>

AgentOS is built as a **self-contained autonomous compute node**. The single binary embeds the entire web UI, AI engine, tool system, and database — requiring no external server, no Docker, and no complex infrastructure to operate.

---

## 🚀 Scalability — Zero Bottlenecks

!!! tip "Built for Any Team Size"
    Since AgentOS runs **fully locally on each user's machine**, there are no scalability bottlenecks — whether you have 1 user or 1,000 users in your organization.

Traditional project management platforms hit scaling walls: database overload, API rate limits, server capacity, and infrastructure costs that grow with every new seat. **AgentOS eliminates all of these problems by design.**

| Concern | Traditional SaaS | AgentOS |
|---------|------------------|---------|
| **Server Load** | Shared server — degrades with users | ❌ No server — each instance is independent |
| **Database Bottleneck** | Central DB — queries slow down at scale | ❌ Local SQLite — each user has their own |
| **API Rate Limits** | Team shares one API allocation | ❌ Each user authenticates independently |
| **Infrastructure Cost** | Grows linearly with team size | ❌ Zero server cost — runs on existing hardware |
| **Downtime Risk** | One server down = everyone blocked | ❌ Fully independent — no single point of failure |
| **Data Migration** | Complex multi-tenant migrations | ❌ Self-contained — nothing to migrate |

Each AgentOS instance is a **fully autonomous compute node**. Adding a new team member means downloading a binary — not provisioning infrastructure. Your 500th user gets the exact same performance as your first user.

!!! note "Enterprise Coordination"
    Need centralized intelligence across all instances? Connect AgentOS to **[AIFlow](../guides/aiflow-sync.md)** as a sync hub. Each agent stays fast and independent, while AIFlow aggregates insights at the organization level.

---

## Questions?

If you have any security concerns or questions about our data handling, please reach out to our security team.

<div class="hero-cta" markdown>
[Email Security :material-email:](mailto:security@unicolab.ai){ .md-button .md-button--primary }
[Open GitHub Issue :material-github:](https://github.com/UnicoLab/agentos/issues){ .md-button }
</div>
