---
title: "Self-Evolving Memory — An Agent That Gets Smarter Every Day"
description: "AgentOS doesn't just follow instructions — it learns from its own experience. Six memory namespaces, automatic consolidation, and a knowledge graph that grows wiser with every interaction."
---

<div class="hero" markdown>

# :material-head-lightbulb: Self-Evolving Memory

**Same codebase. Evolved mind.** Jean-Pierre doesn't rewrite his code — he rewrites his understanding. Every interaction teaches him something new: your preferences, your team's patterns, his own mistakes. Over time, he becomes genuinely smarter.

<div class="hero-cta" markdown>
[View Jean-Pierre →](../flavors/jean-pierre.md){ .md-button .md-button--primary }
[Download AgentOS :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button }
</div>

</div>

---

## The Problem

Traditional AI assistants have amnesia. Every conversation starts from zero. You explain your team structure, correct the same mistakes, repeat your preferences — over and over. **The AI never learns.**

---

## The Solution

AgentOS observes its own execution in the background — with **zero impact** on your response times — and categorizes its experiences into six distinct memory namespaces. Every 6 hours, an intelligent **Consolidator** analyzes these memories to find patterns and generate rules that get injected into every future interaction.

!!! success "Impact"
    **Day 1:** JP knows nothing. **Week 1:** He remembers your preferences and past mistakes. **Month 3:** He anticipates your needs, retries flaky requests automatically, and constructs perfect queries on the first try.

---

## The 6 Memory Namespaces

<div class="feature-grid" markdown>

<div class="feature-card" markdown>
### :material-alert-circle: Error Patterns
What went wrong and why. JP remembers past failures (like a `401` on the GitHub tool) and **automatically diagnoses and bypasses them** next time.
</div>

<div class="feature-card" markdown>
### :material-wrench: Tool Wisdom
What works with each tool. JP learns that `github.get_prs` works best with a 30-day window for quiet repos — **adjusting arguments without being asked**.
</div>

<div class="feature-card" markdown>
### :material-account: User Adaptation
How you work. JP tracks your response style (bullet points vs. tables), communication preferences, and workflow habits — **adapting silently**.
</div>

<div class="feature-card" markdown>
### :material-pencil: Corrections
When you say *"no, that's wrong"*, JP remembers **the exact context and correction** — and never makes the same mistake again.
</div>

<div class="feature-card" markdown>
### :material-speedometer: Performance
Speed and reliability insights. JP remembers which tools take longest to execute and **optimizes its workflow** around them.
</div>

<div class="feature-card" markdown>
### :material-brain: System Knowledge
Generalized rules extracted from all other namespaces. This is the **"Aha!" moment** — raw data synthesized into pure understanding.
</div>

</div>

---

## A Day in the Life

| Timeline | What JP Has Learned |
|----------|-------------------|
| **Day 1** | Fresh install — JP knows nothing |
| **Week 1** | Remembers your API keys expire quickly, you prefer code snippets over long explanations |
| **Month 1** | Proactively retries flaky network requests before bothering you |
| **Month 3** | Anticipates your needs, constructs perfect queries on the first try, knows your team's dynamics |

---

## 🔒 Private by Design

Your memories are **yours alone**:

<div class="step-grid" markdown>

<div class="step-card" markdown>
<div class="step-num">🗄️</div>
### Local Storage
Memories are stored in your local `~/.agentos/` SQLite database. **Never sent to external servers.**
</div>

<div class="step-card" markdown>
<div class="step-num">👁️</div>
### Transparent
You can see exactly what JP is learning. Memories are stored as readable plain text. Inspect them anytime.
</div>

<div class="step-card" markdown>
<div class="step-num">🧹</div>
### Easy Forgetting
If JP learns a bad habit, tell him to `/forget` a specific namespace or correct him directly.
</div>

</div>

---

## Manage Your Agent's Mind

Press ++cmd+m++ to open the **Memory Dashboard**, or use these quick commands:

| Action | What It Does |
|--------|-------------|
| **View Memories** | See what JP remembers across all 6 namespaces |
| **Edit / Delete** | Manually correct or remove specific memories |
| **Add Facts** | Permanently teach JP something: *"We use 2-week sprints starting Monday"* |
| **Forget All** | Clear a namespace completely for a fresh start |

---

## Try It

Tell JP something once — he remembers it forever:

> *"We use 2-week sprints starting Monday"*

> *"Alice is on vacation until the 20th"*

> *"I prefer tables over bullet points"*

> *"The Jira key is INFRA, not BACKEND"*

No configuration needed. JP learns from your conversations and applies this knowledge automatically.

---

<div class="hero-cta" markdown>
[Download AgentOS :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button .md-button--primary }
[Quick Start Guide :material-rocket-launch:](../getting-started/quick-start.md){ .md-button }
</div>
