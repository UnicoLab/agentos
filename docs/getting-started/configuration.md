---
title: Configuration
description: "Configure AgentOS AI providers, project tracking, and integrations. Manage everything through the Web UI or by editing config files directly."
---

<div class="hero" markdown>

# ⚙️ Configuration

AgentOS is built to be flexible. All your settings are stored locally on your machine, and you can manage them either through the **Web UI** or by editing config files directly.

<div class="hero-cta" markdown>
[Installation Guide :material-download:](installation.md){ .md-button .md-button--primary }
[Security & Privacy :material-shield:](../security.md){ .md-button }
</div>

</div>

---

## Configuration Channels

<div class="step-grid" markdown>

<div class="step-card" markdown>
<div class="step-num">1</div>
### Web UI Dashboard
The premium way to configure your agents. Press ++cmd+comma++ anywhere in the app to open the **Settings** panel.
</div>

<div class="step-card" markdown>
<div class="step-num">2</div>
### Setup Wizard
Run `agentos setup` in your terminal for a guided CLI walkthrough (optional).
</div>

<div class="step-card" markdown>
<div class="step-num">3</div>
### Raw Config
Edit `~/.agentos/config.yaml` or `projects.yaml` for advanced automation and scriptability.
</div>

</div>

---

## AI Provider Settings

Configure your primary LLM source. You can switch providers instantly without data loss.

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### 🤖 Ollama (Free & Local)
The gold standard for privacy.
```yaml
ollama_model: llama3.2:latest
ollama_url: http://localhost:11434
```
[Ollama Setup →](../guides/ollama-setup.md)
</div>

<div class="feature-card" markdown>
### ☁️ OpenAI
Classic high-performance.
```yaml
openai_api_key: sk-proj-...
openai_model: gpt-4o
```
</div>

<div class="feature-card" markdown>
### ✨ Anthropic
Superior PM reasoning.
```yaml
anthropic_api_key: sk-ant-...
anthropic_model: claude-3-5-sonnet
```
</div>

<div class="feature-card" markdown>
### 🌐 Google Gemini
Huge context windows.
```yaml
gemini_api_key: AIza...
gemini_model: gemini-2.0-flash
```
</div>

</div>

---

## Project Tracking

Define your projects in `~/.agentos/projects.yaml`. A single project can aggregate data from multiple repositories and boards.

```yaml
projects:
  - name: Core Platform
    id: core-platform
    color: "#7C3AED"
    github:
      repos:
        - myorg/frontend
        - myorg/backend
      days_to_fetch: 30
    jira:
      - project_key: ENG
        board_id: 101
    tags:
      - critical
      - v1.0
```

!!! tip "GUI Management"
    You don't need to touch YAML to manage projects. Use the **Projects** view in the Web UI to add, edit, or color-code your workspaces with a few clicks.

---

## 🔑 License & Identity

License credentials can be provided via a `.watchtower.json` file placed next to the `agentos` binary:

```json
{
  "url": "https://watchtower.unicolab.io",
  "license_key": "AGENT-XXXX-XXXX",
  "kid": "credential-id",
  "secret": "credential-secret"
}
```

Alternatively, set them as environment variables:
`WATCHTOWER_LICENSE_KEY`, `WATCHTOWER_KID`, `WATCHTOWER_SECRET`.

---

## Server Customization

| Setting | Default | Description |
|---------|---------|-------------|
| `port` | `18080` | Local HTTP server port |
| `host` | `0.0.0.0` | Bind address (use `127.0.0.1` for extra security) |
| `auto_open` | `true` | Automatically open your browser on startup |
| `storage_path` | `~/.agentos` | Base directory for DB and configuration |

---

<div class="hero-cta" markdown>
[Connect GitHub →](../guides/github-setup.md){ .md-button .md-button--primary }
[Connect Jira →](../guides/jira-setup.md){ .md-button }
</div>
