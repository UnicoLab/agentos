---
title: "Brigitte — Management Intelligence Copilot"
description: "Meet Brigitte, your AI-powered management intelligence copilot. Executive coaching, team dynamics, leadership analytics, and organizational health — running locally on your machine."
---

<div class="hero" markdown>

# 🧠 Brigitte — Management Intelligence

<p class="subtitle">
Your AI-powered management copilot for <strong>executive coaching, team dynamics, and organizational intelligence</strong>.
Brigitte transforms management data into actionable leadership insights — running entirely on your machine.
</p>

<div class="hero-cta" markdown>
[Install Brigitte :material-download:](#install){ .md-button .md-button--primary }
[Back to All Copilots →](index.md){ .md-button }
</div>

</div>

---

## What Brigitte Does

Brigitte is an AI management intelligence copilot designed for **managers, directors, and executives** who need real-time insight into their teams and organizations. She combines leadership frameworks with live operational data to deliver coaching-grade intelligence.

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### :material-account-group: Team Dynamics
Analyze team composition, collaboration patterns, workload distribution, and interpersonal dynamics. Identify bottlenecks before they become blockers.
</div>

<div class="feature-card" markdown>
### :material-chart-line: Leadership Scoring
Track management KPIs: response times, decision velocity, delegation patterns, and feedback frequency. Benchmark against best practices.
</div>

<div class="feature-card" markdown>
### :material-brain: Meeting Intelligence
Summarize meetings, extract action items, track follow-through, and identify recurring discussion patterns that signal deeper organizational issues.
</div>

<div class="feature-card" markdown>
### :material-hospital-building: Org Health Dashboard
A living dashboard of organizational health metrics: engagement signals, retention risk, skill gaps, and cross-team collaboration health.
</div>

</div>

---

## Key Capabilities

| Capability | What It Does |
|-----------|-------------|
| **Executive Standup** | One-click daily brief: team status, blockers, decisions needed |
| **Team Pulse Analysis** | Workload heatmaps, burnout detection, collaboration scoring |
| **Decision Journal** | Track decisions, outcomes, and patterns over time |
| **1:1 Prep** | Auto-generated talking points based on team member activity |
| **Coaching Insights** | Leadership pattern analysis with actionable improvement suggestions |
| **Organizational Radar** | Cross-team visibility into dependencies, risks, and opportunities |

---

## Who Is Brigitte For?

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### Engineering Managers
Track team velocity, review cycles, and technical debt while maintaining people-first management practices.
</div>

<div class="feature-card" markdown>
### Directors & VPs
Portfolio-level visibility across multiple teams with rollup KPIs and organizational health scoring.
</div>

<div class="feature-card" markdown>
### C-Suite Executives
Strategic dashboards with signal-to-noise filtering — see what matters without the data overload.
</div>

<div class="feature-card" markdown>
### Team Leads
Day-to-day management support: standup prep, 1:1 talking points, and workload rebalancing suggestions.
</div>

</div>

---

## Install { #install }

=== "macOS / Linux"

    ```bash
    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour brigitte
    ```

=== "Windows"

    ```powershell
    curl -fsSL https://unicolab.github.io/agentos/install.bat -o install.bat
    .\install.bat --flavour brigitte
    ```

=== "Manual"

    ```bash
    # Download from releases
    tar xzf agentos-brigitte_*.tar.gz
    mv agentos-brigitte agentos

    # macOS: clear Gatekeeper
    xattr -rd com.apple.quarantine ./agentos
    codesign --force --sign - ./agentos

    # Run
    ./agentos serve
    ```

Open **http://localhost:18080** after install.

!!! note "Same binary, same commands"
    The installer renames `agentos-brigitte` to `agentos`. All commands work identically: `agentos serve`, `agentos chat`, `agentos setup`.

---

## First Interaction

Once Brigitte is running, try these prompts:

!!! example "Management Workflows"
    - *"Give me a standup brief for my team"*
    - *"Prepare talking points for my 1:1 with Sarah"*
    - *"Analyze team workload distribution this sprint"*
    - *"What are the biggest organizational risks right now?"*
    - *"Score my management practices this week"*

---

## Privacy & Security

All data stays on your machine — team insights, conversations, management notes, API keys. Nothing is transmitted to UnicoLab except license validation.

Using **Ollama**? Zero cloud communication. Fully air-gap capable.

[Full Security & Privacy Details →](../security.md){ .md-button }

---

<div class="hero-cta" markdown>
[Install Brigitte :material-download:](#install){ .md-button .md-button--primary }
[Back to All Copilots →](index.md){ .md-button }
[Download from GitHub :material-github:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button }
</div>
