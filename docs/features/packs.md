---
title: Pack System
description: Domain-specific configurations that define Jean-Pierre's personality, tools, and UI layout.
---

# Pack System :material-puzzle:

> Packs transform Jean-Pierre from a generic AI assistant into a **domain-specific copilot** — with the right tools, prompts, and workflows for your use case.

---

## How Packs Work

A **Pack** is a YAML configuration that defines:

- **Persona** — name, icon, accent color, welcome message
- **System Prompt** — specialized instructions for the AI
- **Tools** — which tools the AI can access
- **UI Layout** — sidebar modules and dashboard cards
- **Quick Actions** — one-click command buttons

---

## Available Packs

=== ":material-chart-gantt: PM Co-pilot (default)"

    **`aiflow-pm`** — Project management co-pilot with full dev tool integration.

    **Tools**: GitHub, Jira, meeting notes, project tracking, AIFlow sync, web search, files, shell

    **Highlights**:

    - Standup report generation
    - Sprint status tracking
    - PR reviewer suggestion
    - Meeting note management
    - Task creation and prioritization
    - Strategic Canvas with live project data

=== ":material-briefcase: Office Assistant"

    **`office`** — Office productivity assistant for schedule and task management.

    **Tools**: Schedule, tasks, web search, files, shell

    **Highlights**:

    - Calendar management
    - Task tracking and prioritization
    - Document handling
    - Web research

=== ":material-store: Retail Operations"

    **`retail-ops`** — Retail operations management for inventory and shifts.

    **Tools**: Inventory, shifts, HTTP, files, shell

    **Highlights**:

    - Inventory tracking
    - Shift scheduling
    - Operational dashboards
    - HTTP integrations

---

## Creating Custom Packs

Create a `pack.yaml` in the `packs/` directory:

```yaml
name: my-custom-pack
version: "1.0"
display_name: "My Custom Assistant"
icon: "🔧"
accent_color: "#3b82f6"
welcome_message: "Hello! I'm your custom assistant."

sidebar_modules:
  - history
  - tools
  - settings

agent_profile:
  system_prompt: |
    You are a specialized assistant for...
  allowed_tools:
    - files
    - shell
    - system
    - http
    - web_search
  temperature: 0.3
  max_tokens: 16384

quick_actions:
  - icon: "📊"
    label: "Status Report"
    prompt: "Generate a status report..."
```

### Pack Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | ✅ | Unique identifier |
| `display_name` | ✅ | Shown in the UI header |
| `icon` | ✅ | Emoji icon |
| `accent_color` | ❌ | Theme accent (hex color) |
| `welcome_message` | ❌ | First message shown in chat |
| `sidebar_modules` | ❌ | Which sidebar tabs to show |
| `dashboard_cards` | ❌ | Which dashboard cards to display |
| `agent_profile.system_prompt` | ✅ | AI behavior instructions |
| `agent_profile.allowed_tools` | ✅ | List of tool names the AI can use |
| `agent_profile.temperature` | ❌ | LLM creativity (0.0 - 1.0) |
| `agent_profile.max_tokens` | ❌ | Max response tokens |
| `quick_actions` | ❌ | One-click command buttons |

---

## Base Tools

These tools are available in **every** pack:

| Tool | Description |
|------|-------------|
| :material-file-document: `files` | Read, write, and list files |
| :material-console: `shell` | Execute shell commands |
| :material-information: `system` | System information |
| :material-web: `http` | HTTP requests |
| :material-magnify: `web_search` | Web search |
| :material-source-fork: `spawn` | Sub-process management |
| :material-note-text: `notes` | Persistent notes |
| :material-notebook: `meeting_notes` | Meeting minutes |

---

## Budget Guards

The engine enforces a **MaxToolCalls** limit per execution run (default: 25). This prevents:

- Infinite tool-calling loops
- Excessive API usage
- Runaway cost from LLM tool calls

!!! tip "Adjusting the limit"
    Set `max_tool_calls` in your pack's `agent_profile` section to adjust the budget per run.

---

## Skills Extension

Packs can be extended with **Skills** — markdown-defined reusable workflows:

```markdown
# Weekly Sprint Review

1. Fetch sprint status for all projects
2. Calculate velocity trends
3. Identify at-risk items
4. Generate summary report
5. Post to Slack channel
```

Place skills in `~/.agentos/skills/` and JP can discover and execute them via the `skills` tool.
