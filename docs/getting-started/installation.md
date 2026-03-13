# Installation

Getting AgentOS running on your machine takes less than 5 minutes. Pick your platform and follow the steps below.

---

## Download

Head to the **[Releases Page](https://github.com/UnicoLab/agentos/releases/latest)** and download the archive matching your system:

| Platform | Architecture | File |
|----------|-------------|------|
| **macOS** (Apple Silicon — M1/M2/M3/M4) | arm64 | `agentos_*_darwin_arm64.tar.gz` |
| **macOS** (Intel) | amd64 | `agentos_*_darwin_amd64.tar.gz` |
| **Linux** | x86_64 | `agentos_*_linux_amd64.tar.gz` |
| **Linux** (ARM — Raspberry Pi, etc.) | arm64 | `agentos_*_linux_arm64.tar.gz` |
| **Windows** | x86_64 | `agentos_*_windows_amd64.zip` |

!!! tip "Not sure which macOS version?"
    Open **Terminal** and run: `uname -m`  
    — If it says `arm64`, you have Apple Silicon  
    — If it says `x86_64`, you have Intel

---

## Install

=== "macOS"

    ```bash
    # 1. Extract the archive
    tar xzf agentos_*_darwin_*.tar.gz

    # 2. Move the binary to your PATH (so you can run it from anywhere)
    sudo mv agentos /usr/local/bin/

    # 3. Remove the quarantine flag (macOS security)
    sudo xattr -rd com.apple.quarantine /usr/local/bin/agentos

    # 4. Verify it works
    agentos version
    ```

    !!! note "macOS Gatekeeper"
        Since AgentOS is not (yet) notarized with Apple, macOS may show a security warning the first time you run it. The `xattr` command above removes this. Alternatively, go to **System Settings → Privacy & Security** and click "Allow Anyway".

=== "Linux"

    ```bash
    # 1. Extract the archive
    tar xzf agentos_*_linux_*.tar.gz

    # 2. Move the binary to your PATH
    sudo mv agentos /usr/local/bin/

    # 3. Make it executable (usually already set)
    sudo chmod +x /usr/local/bin/agentos

    # 4. Verify it works
    agentos version
    ```

=== "Windows"

    1. **Extract** the `.zip` archive to a folder (e.g., `C:\Program Files\AgentOS\`)
    2. **Add to PATH** (optional, for command-line access):
        - Open **Settings → System → About → Advanced system settings**
        - Click **Environment Variables**
        - Edit the **Path** variable and add `C:\Program Files\AgentOS\`
    3. **Double-click** `agentos.exe` to launch, or run from PowerShell:
    
    ```powershell
    cd "C:\Program Files\AgentOS"
    .\agentos.exe serve
    ```

---

## First Run — Setup Wizard

When you launch AgentOS for the first time, it will guide you through an interactive setup wizard:

```bash
agentos setup
```

The wizard will help you configure:

1. **AI Provider** — Choose between Ollama (free, local), OpenAI, Anthropic, or Google Gemini
2. **GitHub Connection** — Connect your GitHub repos for project tracking
3. **Jira Connection** — (Optional) Connect Jira boards for sprint data
4. **License Key** — Enter your Watchtower license key

!!! info "No license key yet?"
    We offer **free beta licenses** for early adopters! See the [License page](../license.md) for details on how to get one.

---

## Quick Launch

Once setup is done, start AgentOS:

```bash
# Start the server
agentos serve

# Your browser will open automatically at:
# → http://localhost:18080
```

That's it! 🎉 AgentOS is now running on your machine with a premium web interface.

---

## Run as a Background Service

Want AgentOS to start automatically when you log in?

=== "macOS (launchd)"

    ```bash
    # Install as a user service
    agentos serve --install-service

    # Check status
    launchctl list | grep agentos

    # Uninstall later
    agentos serve --uninstall-service
    ```

=== "Linux (systemd)"

    ```bash
    # Install as a user service
    agentos serve --install-service

    # Check status
    systemctl --user status agentos

    # Uninstall later
    agentos serve --uninstall-service
    ```

Once installed as a service, AgentOS runs in the background and is always available at `http://localhost:18080`.

---

## Next Steps

- [Quick Start Guide →](quick-start.md) — 5-minute walkthrough of your first session
- [Set up Ollama for free local AI →](../guides/ollama-setup.md) — Run AI completely on your machine
- [Connect GitHub →](../guides/github-setup.md) — Track your repositories
