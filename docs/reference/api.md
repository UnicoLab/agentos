---
title: API Endpoints
description: "REST API reference for AgentOS. Programmatic access to chat, projects, fleet, memory, and monitoring endpoints."
---

<div class="hero" markdown>

# :material-api: API Endpoints

AgentOS exposes a REST API for programmatic access. All endpoints are available at `http://localhost:18080` when the server is running.

</div>

---

## Chat

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/v1/chat/stream` | Streaming SSE chat with the agent |

---

## Projects

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/v1/projects` | List all projects |
| `GET` | `/v1/projects/{id}` | Get project details |
| `GET` | `/v1/projects/{id}/insights` | Full dashboard data (KPIs, charts, etc.) |
| `GET` | `/v1/projects/{id}/prs/{num}/suggest-reviewer` | AI-powered reviewer suggestion |
| `GET` | `/v1/projects/{id}/briefs` | Daily briefings |
| `POST` | `/v1/projects/{id}/standup/send` | Send standup to Slack |

---

## Fleet

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/v1/fleet/summary` | Multi-project health overview |

---

## Memory

| Method | Endpoint | Description |
|--------|----------|-------------|
| `PUT` | `/v1/memory/{ns}/{key}` | Store a memory |
| `GET` | `/v1/memory/{ns}` | Search memories by namespace |
| `POST` | `/v1/memory/extract` | AI-extract memories from conversation |

---

## Usage & Monitoring

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/v1/usage` | LLM token usage + cost tracking |
| `DELETE` | `/v1/usage` | Clear usage data |
| `GET` | `/v1/health` | Health check |

---

## Webhooks

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/v1/webhook/github` | GitHub webhook receiver |

---

<div class="hero-cta" markdown>
[Download AgentOS :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button .md-button--primary }
[CLI Reference :material-console:](cli.md){ .md-button }
</div>
