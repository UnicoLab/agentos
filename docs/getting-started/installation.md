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

The fastest way to get started on **macOS** or **Linux**. This script auto-detects your OS and architecture, downloads the correct flavour binary, renames it to `agentos`, and installs it to your PATH:

```bash
# Default: installs Jean-Pierre (PM copilot)
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh

# Choose a different flavour:
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour retail
curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour office
```

!!! info "Available Flavours"
    | Flavour | Description |
    |---------|-------------|
    | **pm** (default) | Jean-Pierre — AI Project Management Copilot |
    | **retail** | Retail Operations Assistant |
    | **office** | Office Productivity Assistant |

That's it! After installation, just run `agentos serve` and you're live. 🎉 The binary is always called `agentos` regardless of flavour.

---

## 🏗️ Supported Platforms

All architectures are pre-built and available on the [Releases Page](https://github.com/UnicoLab/agentos/releases/latest).

Each flavour has its own archive. Choose the one that matches your role:

| Flavour | Platform | Archive Pattern |
|---------|----------|---------|
| 🎩 **PM** | macOS arm64 / amd64, Linux | `agentos-pm_v*_{os}_{arch}.tar.gz` |
| 🛒 **Retail** | macOS arm64 / amd64, Linux | `agentos-retail_v*_{os}_{arch}.tar.gz` |
| 🏢 **Office** | macOS arm64 / amd64, Linux | `agentos-office_v*_{os}_{arch}.tar.gz` |

!!! tip "Not sure which macOS version?"
    Run `uname -m` in Terminal. `arm64` = Apple Silicon, `x86_64` = Intel.

!!! note "Binary is always called `agentos`"
    The install script automatically renames the per-flavour binary to `agentos`. If installing manually, rename it yourself: `mv agentos-pm agentos`.

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

    **Automatic (recommended):**

    ```powershell
    # Download and run the installer (default: PM flavour)
    curl -fsSL https://unicolab.github.io/agentos/install.bat -o install.bat
    .\install.bat

    # Choose a different flavour:
    .\install.bat --flavour retail
    ```

    **Manual:**

    1. Download the `.zip` for your flavour from the [Releases Page](https://github.com/UnicoLab/agentos/releases/latest)
    2. Extract the archive
    3. Rename the binary: `ren agentos-pm.exe agentos.exe`
    4. (Optional) Move to a folder in your system **Path**
    5. Open PowerShell and run:
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
