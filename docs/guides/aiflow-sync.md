# AIFlow Sync

Connect AgentOS to the [AIFlow](https://ai-flow.ai) platform for centralized project intelligence and team-wide AI workflows.

---

## What is AIFlow Sync?

AIFlow Sync lets you push reports, summaries, and project intelligence from your local AgentOS instance to a centralized AIFlow platform. This is useful for:

- Sharing insights with your team
- Centralized project dashboards
- Multi-agent orchestration

!!! note "Optional Feature"
    AIFlow Sync is entirely optional. AgentOS works perfectly as a standalone, local-first tool without it.

---

## Configure

```yaml
aiflow_url: https://your-aiflow-instance.com
aiflow_token: your-api-token
aiflow_project_id: "project-uuid"   # optional
```

---

## Usage

- Ask: *"Sync this report to AIFlow"*
- Use the **AIFlow Sync** button in the header
- AI will push structured reports via `aiflow_sync.push_report`
