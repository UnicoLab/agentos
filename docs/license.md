# License

AgentOS requires a valid license key to operate. Licenses are managed through the **Watchtower** licensing service by UnicoLab.

---

## 🧪 R&D Testing Program — Free Access

!!! warning "License Required"
    AgentOS **will not work** without a valid license key. To obtain a free testing license, contact us at **[info@unicolab.ai](mailto:info@unicolab.ai)**.

AgentOS is currently an **experimental R&D project** — an autonomous compute node for our project management platform solution. We're actively developing and testing it, and **there may be bugs** as the project is in active research and development.

We're offering **free limited access** to the PM flavor (Jean-Pierre) in exchange for your feedback:

### What You Get
- ✅ **Free license key** for testing — no cost, no commitment
- ✅ **Full access** to the Jean-Pierre PM flavor
- ✅ **Priority support** from the development team
- ✅ **Direct influence** on the product roadmap

### What We Ask
- 💬 **Your feedback** — What works? What doesn't? What's missing?
- 🐛 **Bug reports** — Help us find and fix issues
- 💡 **Feature suggestions** — Tell us what you need

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

## No Vendor Lock-In

AgentOS gives you **full control**:

- 🤖 **Choose your AI model** — Use Ollama (free, local), OpenAI, Anthropic, or Gemini. Switch anytime.
- 📝 **Customize prompts** — Full control over the system prompt and agent behavior
- 🧰 **Choose your tools** — Enable only the integrations you need
- 📂 **Own your data** — Everything stored locally in standard SQLite. Export anytime.
- 🔧 **Extensible** — The flavor system lets you adapt the agent to any use case

You're never locked into a specific AI provider, model, or workflow. AgentOS is a **base engine** that you control.

---

## Privacy Notice

License validation communicates **only**:

- Your license key (to verify it's valid)
- App version (to check for updates)
- Seat count (to enforce seat limits)

**No project data, conversations, or personal information** is ever transmitted. See our full [Security & Privacy](security.md) page.
