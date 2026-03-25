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
| `POST` | `/v1/projects` | Create a new project |
| `PUT` | `/v1/projects/{id}` | Update a project |
| `DELETE` | `/v1/projects/{id}` | Delete a project |
| `GET` | `/v1/projects/{id}/insights` | Full dashboard data (KPIs, charts, etc.) |
| `GET` | `/v1/projects/{id}/prs/{num}/suggest-reviewer` | AI-powered reviewer suggestion |
| `GET` | `/v1/projects/{id}/briefs` | Daily briefings |
| `POST` | `/v1/projects/{id}/standup/send` | Send standup to Slack |

---

## Tasks

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/v1/projects/{id}/tasks` | List all tasks |
| `POST` | `/v1/projects/{id}/tasks` | Create a task |
| `PUT` | `/v1/projects/{id}/tasks/{tid}` | Update a task |
| `DELETE` | `/v1/projects/{id}/tasks/{tid}` | Delete a task |

---

## Recipes & Automation

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/v1/recipes` | List all recipes |
| `POST` | `/v1/recipes` | Create a recipe |
| `PUT` | `/v1/recipes/{id}` | Update a recipe |
| `DELETE` | `/v1/recipes/{id}` | Delete a recipe |
| `POST` | `/v1/recipes/{id}/run` | Execute a recipe |
| `GET` | `/v1/automations` | List scheduled automations |
| `POST` | `/v1/automations` | Create an automation |

---

## Sessions

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/v1/sessions` | List chat sessions |
| `POST` | `/v1/sessions` | Create a new session |
| `GET` | `/v1/sessions/{id}` | Get session details |
| `GET` | `/v1/sessions/{id}/messages` | Get session messages |

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
| `GET` | `/v1/tools` | List available agent tools |
| `GET` | `/v1/models` | List available AI models |

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
