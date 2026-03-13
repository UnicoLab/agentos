<div class="hero" markdown>

# 🛠️ Installation

Getting AgentOS running on your machine takes **one command**.

<div class="hero-cta" markdown>
[Download Latest Release :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button .md-button--primary }
[Quick Start Guide :material-rocket-launch:](quick-start.md){ .md-button }
</div>

</div>

---

## ⚡ One-Line Install (Recommended)

The fastest way to get started on **macOS** or **Linux**. This script auto-detects your OS and architecture, downloads the correct binary, handles macOS security, and installs it to your PATH:

```bash
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh
```

That's it! After installation, just run `agentos serve` and you're live. 🎉

---

## 🏗️ Supported Platforms

All architectures are pre-built and available on the [Releases Page](https://github.com/UnicoLab/agentos/releases/latest):

| Platform | Architecture | Archive |
|----------|-------------|---------|
| **macOS** Apple Silicon | arm64 (M1/M2/M3/M4) | `agentos_*_darwin_arm64.tar.gz` |
| **macOS** Intel | amd64 (x86_64) | `agentos_*_darwin_amd64.tar.gz` |
| **Linux** x86 | amd64 | `agentos_*_linux_amd64.tar.gz` |
| **Linux** ARM | arm64 | `agentos_*_linux_arm64.tar.gz` |
| **Windows** | amd64 | `agentos_*_windows_amd64.zip` |

!!! tip "Not sure which macOS version?"
    Run `uname -m` in Terminal. `arm64` = Apple Silicon, `x86_64` = Intel.

---

## 🖥️ Manual Install

If you prefer to install manually:

=== "macOS (with admin)"

    ```bash
    # 1. Extract
    tar xzf agentos_*_darwin_*.tar.gz

    # 2. Move to PATH
    sudo mv agentos /usr/local/bin/

    # 3. Clear quarantine + sign
    xattr -rd com.apple.quarantine /usr/local/bin/agentos
    codesign --force --sign - /usr/local/bin/agentos

    # 4. Verify
    agentos version
    ```

=== "macOS (no admin)"

    No admin access? No problem — run it from any folder:

    ```bash
    # 1. Extract
    tar xzf agentos_*_darwin_*.tar.gz

    # 2. Clear quarantine (no sudo needed on your own files)
    xattr -rd com.apple.quarantine ./agentos
    codesign --force --sign - ./agentos

    # 3. Run directly
    ./agentos serve
    ```

    !!! tip "Optional: add to your user PATH"
        ```bash
        mkdir -p ~/.local/bin
        mv agentos ~/.local/bin/
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
        source ~/.zshrc
        ```

    !!! warning "macOS Gatekeeper"
        If you still see a security warning, go to **System Settings → Privacy & Security** and click **"Allow Anyway"** next to the AgentOS entry.

=== "Linux"

    ```bash
    # 1. Extract
    tar xzf agentos_*_linux_*.tar.gz

    # 2. Move to PATH
    sudo mv agentos /usr/local/bin/
    sudo chmod +x /usr/local/bin/agentos

    # 3. Verify
    agentos version
    ```

=== "Windows"

    1. Extract `agentos.exe` from the `.zip` archive.
    2. (Optional) Add the folder to your system **Path**.
    3. Open PowerShell and run:
       ```powershell
       .\agentos.exe serve
       ```

---

## ⚙️ Initial Configuration

Once AgentOS is running, navigate to `http://localhost:18080`. All configuration can be done directly in the **Web UI Settings** panel (++cmd+comma++).

!!! info "CLI Setup is Optional"
    You can also run `agentos setup` for terminal-based configuration, but the Web UI provides the same functionality with a premium visual interface.

### What you'll need:
- 🤖 **AI Provider**: [Ollama](../guides/ollama-setup.md) (free, local) or an API key (OpenAI, Anthropic, Gemini).
- 🐙 **GitHub Token**: For repository tracking (optional).
- 🔑 **License Key**: Request a free beta key at [info@unicolab.ai](mailto:info@unicolab.ai).

---

## 🔋 Background Service

Run AgentOS automatically on boot:

```bash
agentos serve --install-service
```

---

<div class="hero-cta" markdown>
[Next: Quick Start Guide →](quick-start.md){ .md-button .md-button--primary }
</div>
