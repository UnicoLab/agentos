# GitHub Setup

Connect AgentOS to your GitHub repositories to track PRs, commits, issues, and contributor activity in real-time.

---

## Create a Personal Access Token

1. Go to [github.com/settings/tokens](https://github.com/settings/tokens)
2. Click **Generate new token (classic)**
3. Give it a descriptive name (e.g., "AgentOS")
4. Select these scopes:
    - [x] `repo` — Full control of private repositories
    - [x] `read:org` — Read org membership (optional, for org repos)
5. Click **Generate token**
6. **Copy the token** — you won't see it again!

!!! warning "Keep your token safe"
    Your token is stored locally in `~/.agentos/config.yaml` and is **never sent anywhere** except directly to GitHub's API from your machine.

---

## Configure in AgentOS

### Option 1: Settings UI (easiest)

1. Open AgentOS at `http://localhost:18080`
2. Press ++cmd+comma++ to open Settings
3. Navigate to **Integrations → GitHub**
4. Paste your token
5. Click **Save**

<div class="screenshot">
<img src="../../screens/flavors/pm/github-config.png" alt="GitHub Configuration">
</div>

### Option 2: Config File

Add to `~/.agentos/config.yaml`:

```yaml
github_token: ghp_xxxxxxxxxxxxxxxxxxxx
```

---

## Add GitHub Repos to a Project

Once your token is configured, add repos to a project:

1. Go to **Projects** → Select or create a project
2. Under **GitHub**, add your repository paths:
    - Format: `owner/repo-name`
    - Example: `facebook/react`, `myorg/my-app`
3. You can add **multiple repos** — they'll be aggregated in the dashboard

```yaml
# Example in projects.yaml
projects:
  - name: My Product
    github:
      repos:
        - myorg/frontend
        - myorg/backend
        - myorg/docs
      days_to_fetch: 30
```

---

## What You'll See

Once connected, your dashboard will show:

- **KPIs** — Open PRs, issues, commit count, contributors
- **PR List** — All open PRs with review status and AI reviewer suggestions
- **Commit Chart** — Activity over time with per-author breakdown
- **Velocity Chart** — 8-week contributor velocity
- **Contribution Heatmap** — 26-week activity grid
- **Risk Radar** — AI-scored risk from stale PRs, missing reviewers, etc.

---

## Webhooks (Optional, Advanced)

For **real-time** updates (instead of polling), you can set up a GitHub webhook:

1. In your GitHub repo, go to **Settings → Webhooks**
2. Add webhook:
    - **URL**: `http://your-machine:18080/v1/webhook/github`
    - **Content type**: `application/json`
    - **Secret**: (optional, for HMAC verification)
    - **Events**: Push, Pull requests, Issues

!!! note
    Webhooks require your machine to be reachable from the internet. For local development, this is typically not needed — AgentOS polls GitHub automatically.

---

## Next Steps

- [Set up Jira →](jira-setup.md)
- [Set up Slack →](slack-setup.md)
- [Back to Quick Start →](../getting-started/quick-start.md)
