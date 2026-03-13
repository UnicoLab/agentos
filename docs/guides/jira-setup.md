# Jira Setup

Connect AgentOS to your Jira boards to track sprints, issues, epics, and team workload.

---

## Prerequisites

- A Jira Cloud account (Atlassian)
- An API token from Atlassian

---

## Create an API Token

1. Go to [id.atlassian.com/manage-profile/security/api-tokens](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Click **Create API token**
3. Give it a label (e.g., "AgentOS")
4. **Copy the token**

---

## Configure in AgentOS

### Option 1: Settings UI

1. Open Settings (++cmd+comma++)
2. Navigate to **Integrations → Jira**
3. Fill in:
    - **Site URL**: `https://yourcompany.atlassian.net`
    - **Email**: Your Atlassian account email
    - **API Token**: The token you just created
4. Click **Save**

<div class="screenshot">
<img src="../../screens/flavors/pm/jira-config.png" alt="Jira Configuration">
</div>

### Option 2: Config File

```yaml
jira_site_url: https://yourcompany.atlassian.net
jira_email: you@company.com
jira_token: "your-api-token"
```

---

## Add Jira Boards to a Project

```yaml
projects:
  - name: My Product
    jira:
      - project_key: PROD
        board_id: 42
        days_to_fetch: 14
      - project_key: INFRA      # multiple boards supported
        board_id: 55
```

!!! tip "Finding your Board ID"
    Open your Jira board in a browser. The URL will look like:  
    `https://yourcompany.atlassian.net/jira/software/projects/PROD/boards/42`  
    The number at the end (`42`) is your board ID.

---

## What You'll See

- **Sprint Status** — Ring chart showing Done/WIP/Todo
- **Epic Tracker** — Issues grouped by Epic with progress bars
- **Mind Map** — Visual map of issues by type and label
- **Sprint Planner** — AI-generated sprint plans from backlog data

---

## Next Steps

- [Set up Slack →](slack-setup.md)
- [Back to Quick Start →](../getting-started/quick-start.md)
