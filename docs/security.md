<div class="hero" markdown>

# Security & Privacy

<div class="privacy-badge">🔒 Your data stays on your machine</div>

Local-first AI agents for your workflow — private, powerful, and fully customizable.
Your data never leaves your machine. You choose the model, the prompt, the tools.

</div>

---

## Our Privacy Promise

**Your data stays on YOUR machine.** AgentOS runs entirely locally — all project data, conversations, memories, and configurations are stored in an encrypted SQLite database on your computer.

---

## What Stays Local (100%)

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### 📂 Project Data
Commits, PRs, and issues are stored locally.
</div>

<div class="feature-card" markdown>
### 💬 Chat History
All your conversations are 100% private.
</div>

<div class="feature-card" markdown>
### 🧠 Agent Memory
Your preferences and learned facts stay local.
</div>

<div class="feature-card" markdown>
### 🔑 API Keys
Stored securely in your local config, never shared.
</div>

</div>

---

## External Communication

Only specific, limited communications leave your machine to ensure system integrity:

<div class="step-grid" markdown>

<div class="step-card" markdown>
<div class="step-num">🔑</div>
### License Validation
Periodic check with UnicoLab Watchtower to verify your subscription.
</div>

<div class="step-card" markdown>
<div class="step-num">🤖</div>
### AI Provider
Only if using cloud APIs (OpenAI/Anthropic). **Ollama is 100% local.**
</div>

<div class="step-card" markdown>
<div class="step-num">🐙</div>
### Tool Sync
Direct encrypted calls to GitHub/Jira APIs, same as your browser.
</div>

<div class="step-card" markdown>
<div class="step-num">📊</div>
### Metrics
Anonymized feature usage statistics to help us improve the engine.
</div>

</div>

---

## Architecture Design

<div class="screenshot" markdown>
![Architecture](assets/images/architecture.png)
</div>

AgentOS is built as a self-contained autonomous compute node. The binary embeds the entire web UI and logic, requiring no external server to operate.

---

## API Key Security

All API keys are stored locally in `~/.agentos/config.yaml`. They are masked in the UI and transmitted only to their respective services over encrypted channels. No API keys are ever logged or transmitted to UnicoLab.

---



---

## Questions?

If you have any security concerns or questions about our data handling, please reach out to our security team.

<div class="hero-cta" markdown>
[Email Security :material-email:](mailto:security@unicolab.ai){ .md-button .md-button--primary }
[Open GitHub Issue :material-github:](https://github.com/UnicoLab/agentos/issues){ .md-button }
</div>
