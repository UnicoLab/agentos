# Configuration

AgentOS stores all settings locally on your machine. You can configure everything through the **web UI** (Settings panel, ++cmd+comma++) or by editing config files directly.

---

## Config Files

| File | Location | Purpose |
|------|----------|---------|
| `config.yaml` | `~/.agentos/config.yaml` | AI provider, API keys, integrations |
| `projects.yaml` | `~/.agentos/projects.yaml` | Your tracked projects |
| `.watchtower.json` | Next to the binary | License credentials |

---

## AI Provider Settings

Choose one AI provider (or switch between them anytime):

=== "Ollama (Free, Local)"

    ```yaml
    ollama_model: llama3.2:latest
    ollama_url: http://localhost:11434   # default
    ```

    See the [Ollama Setup Guide](../guides/ollama-setup.md) for installation instructions.

=== "OpenAI"

    ```yaml
    openai_api_key: sk-proj-...
    openai_model: gpt-4o-mini          # or gpt-4o, gpt-4-turbo
    ```

=== "Anthropic"

    ```yaml
    anthropic_api_key: sk-ant-...
    anthropic_model: claude-3-5-sonnet-20241022
    ```

=== "Google Gemini"

    ```yaml
    gemini_api_key: AIza...
    gemini_model: gemini-2.0-flash
    ```

!!! tip "Recommendation"
    For **privacy-first** usage, we recommend **Ollama** — it runs AI models entirely on your machine with zero cloud dependencies. For best quality, **GPT-4o** or **Claude 3.5 Sonnet** are excellent choices.

---

## Projects Configuration

Projects are defined in `~/.agentos/projects.yaml`:

```yaml
projects:
  - name: My Product
    id: my-product
    color: "#6C63FF"
    github:
      repos:
        - myorg/frontend
        - myorg/backend         # multi-repo: all aggregated
        - myorg/infrastructure
      days_to_fetch: 30         # how far back to look
    jira:
      - project_key: PROD
        board_id: 42
        days_to_fetch: 14
    docs:                       # optional documentation links
      - label: Wiki
        url: https://wiki.example.com/my-product
    tags:
      - web
      - production
```

You can also manage projects through the **Projects** page in the web UI — no YAML editing needed.

---

## GitHub Configuration

```yaml
github_token: ghp_...           # Personal Access Token (classic)
```

See [GitHub Setup Guide](../guides/github-setup.md) for token creation instructions.

---

## Jira Configuration

```yaml
jira_token: "your-api-token"
jira_email: you@company.com
jira_site_url: https://yourcompany.atlassian.net
```

See [Jira Setup Guide](../guides/jira-setup.md) for details.

---

## Slack Integration

```yaml
slack_webhook_url: https://hooks.slack.com/services/T.../B.../...
```

See [Slack Setup Guide](../guides/slack-setup.md) for webhook creation.

---

## AIFlow Sync (Optional)

```yaml
aiflow_url: https://your-aiflow-instance.com
aiflow_token: your-api-token
aiflow_project_id: "project-uuid"   # optional — links to a specific AIFlow project
```

See [AIFlow Sync Guide](../guides/aiflow-sync.md) for integration details.

---

## License Configuration

License credentials can be provided in three ways (in priority order):

**1. License file** (recommended):

Place `.watchtower.json` next to the `agentos` binary:

```json
{
  "url": "https://watchtower.unicolab.io",
  "license_key": "your-license-key",
  "kid": "your-credential-kid",
  "secret": "your-credential-secret"
}
```

**2. Environment variables**:

```bash
export WATCHTOWER_LICENSE_KEY="your-license-key"
export WATCHTOWER_KID="your-credential-kid"
export WATCHTOWER_SECRET="your-credential-secret"
```

**3. Config file** (`~/.agentos/config.yaml`):

```yaml
watchtower_url: https://watchtower.unicolab.io
watchtower_license_key: "your-license-key"
watchtower_kid: "your-credential-kid"
watchtower_secret: "your-credential-secret"
```

---

## Server Settings

| Setting | Default | Description |
|---------|---------|-------------|
| `port` | `18080` | HTTP server port |
| `host` | `0.0.0.0` | Bind address |
| `auto_open` | `true` | Auto-open browser on start |

---

## Environment Variables

All config values can also be set via environment variables (uppercase, prefixed with `AGENTOS_`):

```bash
export AGENTOS_OLLAMA_MODEL=llama3.2:latest
export AGENTOS_GITHUB_TOKEN=ghp_...
export AGENTOS_PORT=8080
```

Environment variables take precedence over config file values.
