---
title: Ollama Setup — Free Local AI
description: "Run high-fidelity LLMs entirely on your machine with Ollama. Maximum privacy, zero recurring costs."
---

<div class="hero" markdown>

# 🤖 Ollama Setup — Free Local AI

[Ollama](https://ollama.com) is the recommended way to run AgentOS. It lets you run high-fidelity Large Language Models **entirely on your machine** with maximum privacy and zero recurring costs.

<div class="hero-cta" markdown>
[Download Ollama :material-download:](https://ollama.com/download){ .md-button .md-button--primary }
[Next: Connect GitHub →](github-setup.md){ .md-button }
</div>

</div>

---

## 🏗️ Installation

<div class="step-grid" markdown>

<div class="step-card" markdown>
### macOS
Download the macOS app or install via Homebrew:
`brew install ollama`
</div>

<div class="step-card" markdown>
### Linux
One-line installer:
`curl -fsSL https://ollama.com/install.sh | sh`
</div>

<div class="step-card" markdown>
### Windows
Download the `.exe` installer from the official site and follow the prompts.
</div>

</div>

---

## 🧠 Choice of Models

After installing, you need to "pull" a model. We've optimized Jean-Pierre for the **Llama 3** family.

```bash
# Recommended for most users
ollama pull llama3.2

# For powerful workstations (M3 Max / RTX 4090)
ollama pull llama3.2:70b

# For ultra-lightweight performance
ollama pull llama3.2:1b
```

### Hardware Recommendations

| Model | RAM | Quality | Best For |
|-------|-----|---------|----------|
| **Llama 3.2 (3b)** | 8GB | ⭐⭐⭐⭐ | **Universal standard** |
| **Mistral (7b)** | 16GB | ⭐⭐⭐⭐ | Alternative logic |
| **Llama 3.1 (70b)** | 48GB | ⭐⭐⭐⭐⭐ | Executive reasoning |

---

## ⚡ Connecting to AgentOS

Once Ollama is running (it stays in your system tray on macOS/Windows), simply tell AgentOS which flavor to use.

<div class="step-grid" markdown>

<div class="step-card" markdown>
<div class="step-num">1</div>
### Web UI
Open **Settings** (++cmd+comma++), select **Ollama** as the provider, and pick your model from the dropdown.
</div>

<div class="step-card" markdown>
<div class="step-num">2</div>
### CLI
Run `agentos serve`. The engine will auto-detect the local Ollama instance at `http://localhost:11434`.
</div>

</div>

---

## 🛠️ Performance Tuning

If the agent feels sluggish, ensure you have:
1. **Model Matching**: Don't run a 70B model on a MacBook Air. Stick to 3B or 7B.
2. **GPU Acceleration**: Ollama automatically uses WebGPU/Metal on macOS. On Linux/Windows, ensure your NVIDIA/AMD drivers are up to date.
3. **Dedicated Resources**: Close high-memory browser tabs or development servers if you're pushing larger models.

---

<div class="hero-cta" markdown>
[Back to Quick Start →](../getting-started/quick-start.md){ .md-button }
</div>
