<div class="hero" markdown>

# 🛠️ Installation

Getting AgentOS running on your machine takes less than 5 minutes. 

<div class="hero-cta" markdown>
[Download Latest Release :material-download:](https://github.com/UnicoLab/agentos/releases/latest){ .md-button .md-button--primary }
[Quick Start Guide :material-rocket-launch:](quick-start.md){ .md-button }
</div>

</div>

---

## 🏗️ Supported Platforms

Head to the **[Releases Page](https://github.com/UnicoLab/agentos/releases/latest)** and grab the archive for your system.

| Platform | Architecture | Recommended For |
|----------|-------------|-----------------|
| **macOS** | arm64 | Apple Silicon (M1, M2, M3, M4) |
| **macOS** | amd64 | Intel Macs |
| **Linux** | amd64 | Standard PC / Cloud Servers |
| **Linux** | arm64 | Raspberry Pi 4/5, Graviton |
| **Windows** | amd64 | Standard PC |

---

## 🚀 Setup Flow

<div class="step-grid" markdown>

<div class="step-card" markdown>
<div class="step-num">1</div>
### Extract
Unzip or untar the downloaded file. You'll get a single `agentos` executable binary.
</div>

<div class="step-card" markdown>
<div class="step-num">2</div>
### Move to PATH
(Optional) Move the binary to `/usr/local/bin` or your Windows PATH so you can run it from anywhere.
</div>

<div class="step-card" markdown>
<div class="step-num">3</div>
### Serve
Run `agentos serve`. This starts the local API engine and launches the premium Web UI.
</div>

</div>

---

## 🖥️ Platform-Specific Steps

=== "macOS"

    ```bash
    # 1. Move to local bin
    sudo mv agentos /usr/local/bin/

    # 2. Clear quarantine (required for first run)
    sudo xattr -rd com.apple.quarantine /usr/local/bin/agentos

    # 3. Verify
    agentos version
    ```

    !!! tip "Apple Silicon vs Intel"
        Run `uname -m` in Terminal. If it says `arm64`, download the **arm64** version. If it says `x86_64`, download the **amd64** version.

=== "Linux"

    ```bash
    # 1. Move to local bin
    sudo mv agentos /usr/local/bin/
    sudo chmod +x /usr/local/bin/agentos

    # 2. Verify
    agentos version
    ```

=== "Windows"

    1. Extract the `agentos.exe` to a permanent folder.
    2. (Optional) Add the folder to your system **Path** variable.
    3. Open PowerShell and run:
       ```powershell
       .\agentos.exe serve
       ```

---

## ⚙️ Initial Configuration

Once AgentOS is running, navigate to `http://localhost:18080` to access the **Interactive Settings Dashboard**. 

You can also run the CLI wizard if you prefer terminal-based setup:
```bash
agentos setup
```

### What you'll need:
- 🤖 **AI Provider**: API keys or a local [Ollama](../guides/ollama-setup.md) installation.
- 🐙 **GitHub Token**: For fetching repository data (optional).
- 🔑 **License Key**: For premium features (request yours at [info@unicolab.ai](mailto:info@unicolab.ai)).

---

## 🔋 Background Service

If you want AgentOS to start automatically on boot:

```bash
# Install as a background service
agentos serve --install-service

# Check status
# macOS: launchctl list | grep agentos
# Linux: systemctl --user status agentos
```

---

<div class="hero-cta" markdown>
[Next: Quick Start Guide →](quick-start.md){ .md-button .md-button--primary }
</div>
