---
title: AI Copilot
description: "Your AI assistant that understands your projects, remembers your preferences, and helps you make better decisions — powered by local or cloud LLMs."
---

<div class="hero" markdown>

# :material-robot: AI Copilot

Your personal AI assistant that understands your projects, remembers your preferences, and helps you make better decisions — all through natural language.

<div class="hero-cta" markdown>
[View Jean-Pierre Flavor →](../flavors/jean-pierre.md){ .md-button .md-button--primary }
[Download AgentOS :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button }
</div>

</div>

---

## High-Fidelity Interaction

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### :material-lightning-bolt: Streaming Chat
Talk to your agent in natural language. See responses render in real-time with rich markdown support, code blocks, and structured data.
</div>

<div class="feature-card" markdown>
### :material-link-variant: Action Chain
Watch exactly how your agent works. Tool calls are visualized as an expanding chain with full transparency — no black boxes.
</div>

<div class="feature-card" markdown>
### :material-head-lightbulb: JP Memory
Auto-learning facts and preferences. Tell Jean-Pierre once, and he'll remember it across all future sessions and conversations.
</div>

<div class="feature-card" markdown>
### :material-eye: Context Aware
Your agent is deeply synchronized with your current view, whether you're looking at a specific PR, the risk radar, or the fleet overview.
</div>

</div>

---

## In Action

<div class="screenshot" markdown>
![Jean-Pierre Chat](../assets/screens/flavors/pm/JP-chat-planning.png)
</div>

Ask anything in natural language and watch JP plan, execute tools, and synthesize a structured response in real-time. Quick-action pills let you trigger common workflows with one click.

---

## Conversation Examples

Your AI copilot handles complex project queries with ease:

!!! example "Try These"
    - *"Give me a standup report for all active projects"* → Structured report in ~8 seconds
    - *"Which PRs have been open too long?"* → Analysis with reviewer suggestions in ~5 seconds
    - *"What should I focus on today?"* → Prioritized action list based on real data
    - *"Create tasks based on the current sprint risks"* → AI-generated task list with priorities
    - *"Compare velocity this sprint vs. last sprint"* → Trend analysis with recommendations

---

## Smart Memory System

AgentOS includes **JP Memory** — an autonomous long-term memory system:

- :material-note-edit: **Fact Extraction** — Automatically saves team structures, priorities, and project nuances.
- :material-refresh: **Auto-correction** — Correct a fact once, and the agent updates its internal knowledge graph.
- :material-database: **Local Storage** — No vector database is sent to the cloud. Everything stays in your SQLite DB.

!!! tip "Manage Memories"
    Press ++cmd+m++ to view the memory dashboard. You can manually edit, delete, or add permanent facts to your agent's brain.

---

## Supported AI Providers

Choose the provider that fits your needs — switch anytime without losing data:

<div class="step-grid" markdown>

<div class="step-card" markdown>
<div class="step-num">🏠</div>
### Ollama
100% Local. Free. Maximum Privacy. Your prompts never leave your machine.
[Set up Ollama →](../guides/ollama-setup.md)
</div>

<div class="step-card" markdown>
<div class="step-num">☁️</div>
### OpenAI
GPT-4o / GPT-4 Turbo. Industry-leading performance for complex reasoning.
[Connect OpenAI →](../getting-started/configuration.md)
</div>

<div class="step-card" markdown>
<div class="step-num">✨</div>
### Anthropic
Claude 3.5 Sonnet / Opus. Exceptional at nuanced analysis and long-form output.
[Connect Anthropic →](../getting-started/configuration.md)
</div>

<div class="step-card" markdown>
<div class="step-num">🌐</div>
### Gemini
Google's latest models. Fast inference and large context windows.
[Connect Gemini →](../getting-started/configuration.md)
</div>

</div>

---

<div class="hero-cta" markdown>
[Download AgentOS :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button .md-button--primary }
[Quick Start Guide :material-rocket-launch:](../getting-started/quick-start.md){ .md-button }
</div>
