---
title: License & Evaluation
description: "Get a free evaluation license for AgentOS. Join our early access program and experience AI-powered project management with zero risk."
---

<div class="hero" markdown>

# :material-key-variant: License & Evaluation

AgentOS requires a valid license key to operate. Licenses are managed through the **Watchtower** licensing service by UnicoLab.

<div class="hero-cta" markdown>
[Request Free License :material-email:](mailto:info@unicolab.ai){ .md-button .md-button--primary }
[Download AgentOS :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button }
</div>

</div>

---

## :material-star-shooting: Early Access Program — Free Evaluation

!!! success "Your Opportunity"
    AgentOS is an **innovative AI platform** currently in active development. We're inviting early adopters to experience the future of project management — **completely free**. This is your chance to get hands-on with cutting-edge technology, provide feedback, and help shape the product before general availability.

As an early-stage platform, you may encounter occasional rough edges — but that's also what makes this an **incredible opportunity**: free access to enterprise-grade AI project intelligence with direct influence on the roadmap.

### What You Get
- ✅ **Free evaluation license** — full access to the Jean-Pierre PM flavor, no cost
- ✅ **Priority support** from the core development team
- ✅ **Direct influence** on the product roadmap — your feedback shapes the future
- ✅ **First look** at new features, flavours, and capabilities

### What We Value
- 💬 **Your feedback** — What works? What could be better? What's missing?
- 🐛 **Bug reports** — Help us polish the experience
- 💡 **Feature ideas** — Tell us what would make AgentOS indispensable for you

### How to Get Your License

1. **Email** [info@unicolab.ai](mailto:info@unicolab.ai) with:
    - Your name / organization
    - Your use case (what projects you want to manage)
    - Your platform (macOS / Linux / Windows)
2. We'll send you a `.watchtower.json` license file within **24 hours**
3. Place it next to your `agentos` binary and you're ready to go!

---

## License Setup

Once you receive your `.watchtower.json` file:

### Option 1: License File (Recommended)

Place the `.watchtower.json` file in the same directory as your `agentos` binary:

```json
{
  "url": "https://watchtower.unicolab.io",
  "license_key": "xxxx-xxxx-xxxx-xxxx-xxxx-xxxx",
  "kid": "wt_xxxxxxxxxxxxxxxx",
  "secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "credential_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "deployment_mode": "floating"
}
```

### Option 2: Environment Variables

```bash
export WATCHTOWER_LICENSE_KEY="xxxx-xxxx-xxxx-xxxx-xxxx-xxxx"
export WATCHTOWER_KID="wt_xxxxxxxxxxxxxxxx"
export WATCHTOWER_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

### Option 3: Setup Wizard

Run `agentos setup` and enter your credentials when prompted.

---

## Check License Status

```bash
$ agentos license

🟢 License Status: enterprise (active)
   Seats: 3 / 10
   Expires: 2027-01-01
   Features: all
```

---

## :material-lock-open-variant: No Vendor Lock-In

AgentOS gives you **full control**:

- :material-robot: **Choose your AI model** — Use Ollama (free, local), OpenAI, Anthropic, or Gemini. Switch anytime.
- :material-pencil: **Customize prompts** — Full control over the system prompt and agent behavior
- :material-wrench: **Choose your tools** — Enable only the integrations you need
- :material-folder: **Own your data** — Everything stored locally in standard SQLite. Export anytime.
- :material-cog: **Extensible** — The flavor system lets you adapt the agent to any use case

You're never locked into a specific AI provider, model, or workflow. AgentOS is a **base engine** that you control.

---

## Privacy Notice

License validation communicates **only**:

- Your license key (to verify it's valid)
- App version (to check for updates)
- Seat count (to enforce seat limits)

**No project data, conversations, or personal information** is ever transmitted. See our full [Security & Privacy](security.md) page.
