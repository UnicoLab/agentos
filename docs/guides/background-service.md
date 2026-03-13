# Background Service

Run AgentOS as a persistent background service that starts automatically when you log in.

---

## Install as a Service

=== "macOS (launchd)"

    ```bash
    agentos serve --install-service
    ```

    This creates a `launchd` user agent that:
    - Starts automatically on login
    - Keeps AgentOS running in the background
    - Restarts automatically if it crashes
    - Accessible at `http://localhost:18080`

    **Manage the service:**
    ```bash
    # Check status
    launchctl list | grep agentos

    # Stop
    launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.unicolab.agentos.plist

    # Start
    launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.unicolab.agentos.plist

    # Uninstall
    agentos serve --uninstall-service
    ```

=== "Linux (systemd)"

    ```bash
    agentos serve --install-service
    ```

    **Manage the service:**
    ```bash
    # Check status
    systemctl --user status agentos

    # Stop
    systemctl --user stop agentos

    # Start
    systemctl --user start agentos

    # View logs
    journalctl --user -u agentos -f

    # Uninstall
    agentos serve --uninstall-service
    ```

=== "Windows"

    On Windows, simply add `agentos.exe serve` to your **Startup** folder:
    
    1. Press ++win+r++, type `shell:startup`, press Enter
    2. Create a shortcut to `agentos.exe serve` in this folder
    
    Alternatively, run as a service using [NSSM](https://nssm.cc/).

---

## Verify

After installing, close and reopen your terminal (or log out and back in), then:

```bash
# Check if it's running
curl http://localhost:18080/v1/health
# → {"status":"ok"}
```

Open your browser to `http://localhost:18080` — AgentOS is always there.
