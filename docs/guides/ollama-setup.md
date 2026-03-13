# Ollama Setup — Free Local AI

[Ollama](https://ollama.com) lets you run powerful AI models **entirely on your machine** — no API keys, no costs, no data leaving your computer. This is the recommended setup for maximum privacy.

---

## Install Ollama

=== "macOS"

    ```bash
    # Install via Homebrew (recommended)
    brew install ollama

    # Or download from https://ollama.com/download
    ```

=== "Linux"

    ```bash
    # One-line installer
    curl -fsSL https://ollama.com/install.sh | sh
    ```

=== "Windows"

    Download the installer from [ollama.com/download](https://ollama.com/download) and run it.

---

## Download a Model

After installing Ollama, pull a model. We recommend starting with **Llama 3.2** — it's fast, capable, and free:

```bash
# Pull the default model (recommended for most systems)
ollama pull llama3.2

# For more powerful systems (16GB+ RAM), try the larger version
ollama pull llama3.2:70b

# For lightweight systems (8GB RAM), use the smaller version
ollama pull llama3.2:1b
```

### Model Recommendations

| Model | RAM Needed | Quality | Speed | Best For |
|-------|-----------|---------|-------|----------|
| `llama3.2:1b` | 4GB | ⭐⭐ | ⚡⚡⚡ | Low-resource machines |
| `llama3.2` (8b) | 8GB | ⭐⭐⭐⭐ | ⚡⚡ | **Most users (recommended)** |
| `llama3.2:70b` | 48GB | ⭐⭐⭐⭐⭐ | ⚡ | Best quality, needs powerful hardware |
| `mistral` | 8GB | ⭐⭐⭐⭐ | ⚡⚡ | Good alternative |
| `codellama` | 8GB | ⭐⭐⭐ | ⚡⚡ | Code-focused tasks |

---

## Start Ollama

Ollama runs as a background service:

```bash
# Start the Ollama server (runs on port 11434)
ollama serve

# Verify it's running
curl http://localhost:11434/api/tags
```

!!! tip "Auto-start"
    On macOS, Ollama auto-starts when you open the app. On Linux, it runs as a systemd service automatically after installation.

---

## Configure AgentOS to use Ollama

### Option 1: Setup Wizard

Run `agentos setup` and select **Ollama** as your AI provider. It will auto-detect available models.

### Option 2: Settings UI

1. Open AgentOS at `http://localhost:18080`
2. Press ++cmd+comma++ to open Settings
3. Under **AI Provider**, select **Ollama**
4. Choose your model from the dropdown

### Option 3: Config File

Edit `~/.agentos/config.yaml`:

```yaml
ollama_model: llama3.2:latest
ollama_url: http://localhost:11434
```

---

## Verify It Works

1. Start AgentOS: `agentos serve`
2. Open the chat panel
3. Ask: *"Hello, introduce yourself"*

If everything is configured correctly, you'll see the agent respond using your local Ollama model — **completely offline, completely private**.

---

## Troubleshooting

??? question "AgentOS can't connect to Ollama"
    Make sure Ollama is running: `ollama serve`  
    Check the URL in your config matches (default: `http://localhost:11434`)

??? question "Model is too slow"
    Try a smaller model: `ollama pull llama3.2:1b`  
    Close other memory-heavy applications

??? question "Out of memory errors"
    Your chosen model needs more RAM than available.  
    Switch to a smaller model or close other applications.

---

## Next Steps

- [Connect GitHub →](github-setup.md)
- [Connect Jira →](jira-setup.md)
- [Back to Quick Start →](../getting-started/quick-start.md)
