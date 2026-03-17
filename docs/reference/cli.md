---
title: CLI Commands
description: "Complete reference for all AgentOS CLI commands, including serve, chat, setup, and interactive slash commands."
---

<div class="hero" markdown>

# :material-console: CLI Commands

AgentOS provides a powerful command-line interface for all operations — from launching the server to interactive AI chat sessions.

</div>

---

## Main Commands

```bash
agentos serve          # Start HTTP server + web UI (default)
agentos chat           # Interactive CLI chat session
agentos run "message"  # Execute a single message and exit
agentos setup          # Interactive first-time setup wizard
agentos config         # View/edit configuration
agentos projects       # Manage tracked projects
agentos license        # Check Watchtower license status
agentos version        # Print version, commit, and build date
```

---

## `agentos serve`

Start the HTTP API server with embedded web UI.

```bash
agentos serve                      # Default: http://localhost:18080
agentos serve --port 8080          # Custom port
agentos serve --no-open            # Don't auto-open browser
agentos serve --install-service    # Install as background service
agentos serve --uninstall-service  # Remove background service
```

---

## `agentos chat`

Start an interactive CLI chat session with your agent.

### Slash Commands

| Command | Description |
|---------|-------------|
| `/help` | Show all commands |
| `/tools` | List available tools |
| `/models` | List available models |
| `/model <name>` | Switch model |
| `/sessions` | List active sessions |
| `/session <id>` | Switch session |
| `/new` | Start a new session |
| `/memory` | Show agent memory |
| `/forget` | Clear agent memory |
| `/history` | Show recent runs |
| `/events <id>` | Show events for a run |
| `/license` | Show license status |
| `/feedback` | Submit feedback |
| `/bugreport` | Report a bug |
| `/clear` | Clear screen |
| `/quit` | Exit |

---

## `agentos setup`

Interactive wizard for first-time configuration. Walks you through:

1. AI provider selection and configuration
2. GitHub token setup
3. Jira credentials (optional)
4. License key entry

---

## `agentos version`

```bash
$ agentos version
Jean-Pierre v0.13.0 (abc1234) built 2026-03-15T12:00:00Z
Pack: aiflow-pm (Jean-Pierre — The PM 🎩)
License: 🟢 enterprise (active) [3/10 seats]
```

---

<div class="hero-cta" markdown>
[Download AgentOS :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button .md-button--primary }
[Quick Start Guide :material-rocket-launch:](../getting-started/quick-start.md){ .md-button }
</div>
