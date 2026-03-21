# Self-Evolving Memory

> *"The system doesn't rewrite its code — it rewrites its understanding."*

Welcome to the future of **AgentOS**. Instead of risking instability by modifying its own source code, AgentOS relies on a powerful, biologically-inspired paradigm: **Self-Evolving Memory**.

Just like humans learn from their mistakes, adapt to preferences, and discover better ways to use their tools over time, AgentOS gets smarter every day through lived experience. **Same codebase, evolved mind.**

---

## 🧬 How It Works

AgentOS observes its own execution in the background — with **zero impact** on your response times — and categorizes its experiences into six distinct namespaces. Every 6 hours, an intelligent background process (the **Consolidator**) analyzes these memories to find reoccurring patterns and generate generalized rules.

These rules form a **Knowledge Graph** of causal relationships (e.g., *Tool A causes Error B, which is resolved by Solution C*) and get injected into the agent's system prompt on every future request.

### The 6 Memory Namespaces

1. 🔴 **Error Patterns**: What went wrong and why. The agent remembers past failures (like a `401 Unauthorized` flag on the GitHub tool) so it can automatically diagnose and bypass them next time.
2. 🔧 **Tool Wisdom**: What works with each tool. It learns that `github.get_prs` works best with a 30-day window for quiet repositories, adjusting its arguments without you having to ask.
3. 👤 **User Adaptation**: How you work. It implicitly tracks your response style (e.g., preferring bullet points) and tool preferences.
4. ✏️ **Corrections**: When you say "no, that's wrong," it remembers the exact context and what you corrected it to.
5. 📊 **Performance**: Speed and reliability. It remembers which tools take the longest to execute (e.g., >2s latencies) and optimizes its workflow around them.
6. 🧠 **System Knowledge**: The generalized rules extracted from the other five namespaces. This is the "Aha!" moment where the agent synthesizes raw data into pure understanding.

---

## 🔒 Full Transparency & Local-First

Your data is yours. The entire evolution process happens **locally on your machine**:
- **Zero Cloud Bleed**: Memories are stored locally in your `~/.agentos/` SQLite database. We never send your memories, errors, or preferences to external servers.
- **Transparent Understanding**: You can see exactly what the agent is learning. The memories are stored as highly readable plain text. Just use the CLI or Dashboard to inspect them.
- **Easy Forgetting**: If the agent learns a bad habit, you can tell it to explicitly `/forget` a specific namespace, or overwrite it by correcting it.

### Commands to Explore Your Agent's Mind

You can interact directly with the evolution engine via the AgentOS CLI:

- `agentos evolution stats` — See how many memories your agent has collected across all namespaces.
- `agentos evolution list <namespace>` — View exactly what the agent remembers in a plain-text list.
- `agentos evolution context "my query"` — Simulate what the agent *would* inject into its prompt for a given query.
- `agentos evolution forget <namespace>` — Erase a specific namespace if you want a clean slate.

---

## 🚀 A Day in the Life

**Day 1:** AgentOS knows nothing. It's a fresh install.
**Week 1:** You correct it a few times. It learns that your API keys expire quickly and that you prefer code snippets over long explanations. 
**Month 3:** AgentOS anticipates your needs. It proactively retries flaky network requests before bothering you. It constructs perfect GraphQL queries on the first try because it remembers the exact syntax that worked last week.

**The result?** A truly autonomous agent that doesn't just execute instructions — it understands your exact environment, your habits, and its own capabilities.

*This is software that grows wiser with age.*
