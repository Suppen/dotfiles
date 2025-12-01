# nvim-claude

Run Neovim with Claude Code CLI support in a Docker container, using your existing Neovim configuration.

## Overview

This setup allows you to use the [claude-code.nvim](https://github.com/greggh/claude-code.nvim) plugin with Neovim inside a Docker container. The container provides the Claude Code CLI while mounting your existing Neovim configuration, ensuring your containerized Neovim is identical to your regular setup—except with Claude available.

## Features

- **Norwegian locale** (nb_NO.UTF-8)
- **Latest Node.js** (v24 LTS) for Claude CLI and plugin support
- **Claude Code CLI** pre-installed
- **Mounted volumes** for seamless integration:
  - Neovim binary (from host)
  - Neovim configuration (`~/.config/nvim`, read-only)
  - Neovim data/plugins (`~/.local/share/nvim`)
  - Neovim state (`~/.local/state/nvim`)
  - Neovim cache (`~/.cache/nvim`)
  - Project directory (current working directory)
  - Claude configuration (`~/.claude`)
  - Supermaven configuration (`~/.supermaven`, `~/.local/share/supermaven`)
  - Container home directory (`~/.nvim-claude-home`) for Claude state files
- **Security protection** - refuses to run from sensitive directories

## Prerequisites

- Docker installed and running
- Neovim 0.7.0+ installed on the host (required—will be mounted into the container)
- A Neovim configuration using Lazy.nvim for plugins
- Run `nvim` once outside the container to install plugins and initialize Supermaven
- Run `claude` once (via `:ClaudeCode` in neovim) to authenticate

## Installation

1. Clone or copy these files to a directory:
   ```bash
   mkdir -p ~/nvim-claude
   cd ~/nvim-claude
   # Copy Dockerfile, nvim-claude-setup.sh, and README.md here
   ```

2. Make the setup script executable:
   ```bash
   chmod +x nvim-claude-setup.sh
   ```

3. Run the setup script:
   ```bash
   ./nvim-claude-setup.sh
   ```

4. Restart your shell (or start a new terminal)

## Usage

### Regular Neovim (without Claude)

Use Neovim as you normally would:
```bash
nvim myfile.py
```

### Neovim with Claude

Navigate to your project directory and use `nvim-claude`:
```bash
cd ~/projects/my-project
nvim-claude
```

This starts Neovim inside the Docker container with Claude Code CLI available.

### Passing arguments

All arguments are passed through to Neovim:
```bash
nvim-claude file1.py file2.py
nvim-claude +100 myfile.py    # Open at line 100
nvim-claude -c "set number"   # Run command on startup
```

## Configuration

### Adding claude-code.nvim to your Neovim config

Add this to your Lazy.nvim plugin configuration (e.g., `~/.config/nvim/lua/plugins/claude.lua`):

```lua
return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("claude-code").setup({
      -- Optional: customize settings
      window = {
        position = "botright",
        split_ratio = 0.3,
      },
      keymaps = {
        toggle = {
          normal = "<C-,>",
          terminal = "<C-,>",
        },
      },
    })
  end,
}
```

### Claude Authentication

The container mounts your Claude configuration from the host. To authenticate:

1. Start `nvim-claude` in any project directory
2. Run `:ClaudeCode` to open the Claude terminal
3. Complete the authentication flow
4. Your credentials are saved to `~/.claude` and persist across container restarts

Alternatively, set an API key via environment variable:
```bash
export ANTHROPIC_API_KEY="your-key-here"
nvim-claude
```

### Customizing blocked directories

Edit `~/.nvim-claude-function.sh` (bash) or `~/.config/fish/functions/nvim-claude.fish` (fish) to modify the `BLOCKED_DIRS` array if you need to add or remove protected directories.

## How It Works

### Volumes

| Host Path | Container Path | Purpose |
|-----------|----------------|---------|
| `~/.nvim-claude-home` | `/home/nvimuser` | Container home (base layer for Claude state files) |
| Host Neovim installation | `/host-nvim` | System Neovim binary (required) |
| `~/.config/nvim` | `/home/nvimuser/.config/nvim` | Your Neovim configuration (read-only) |
| `~/.local/share/nvim` | `/home/nvimuser/.local/share/nvim` | Plugins, data |
| `~/.local/state/nvim` | `/home/nvimuser/.local/state/nvim` | State files |
| `~/.cache/nvim` | `/home/nvimuser/.cache/nvim` | Cache files |
| `$(pwd)` | `/workspace` | Your project directory |
| `~/.claude` | `/home/nvimuser/.claude` | Claude CLI credentials |
| `~/.supermaven` | `/home/nvimuser/.supermaven` | Supermaven credentials |
| `~/.local/share/supermaven` | `/home/nvimuser/.local/share/supermaven` | Supermaven binary |

The container home (`~/.nvim-claude-home`) is mounted first as a base layer, then other directories are overlaid on top. This allows Claude to write its state files (`.claude.json`, etc.) to a persistent location.

### Security

The `nvim-claude` function refuses to run from these directories:
- `$HOME`
- `$HOME/.ssh`
- `$HOME/.gnupg`
- `$HOME/.aws`
- `$HOME/.config`
- `$HOME/.local`
- `$HOME/.cache`
- `$HOME/.password-store`
- `$HOME/.mozilla`
- `$HOME/.thunderbird`
- `$HOME/.kube`
- `$HOME/.docker`
- `/etc`
- `/root`
- `/`

This prevents accidentally exposing sensitive data to Claude.

## Troubleshooting

### Neovim not found

If you get an error about Neovim not being installed, ensure Neovim is installed on your host system and available in your PATH:
```bash
which nvim
nvim --version
```

The function expects a standard Neovim installation structure with `bin/nvim` and `share/nvim` directories.

### Plugins not loading

If plugins don't load in the container, they may need to be installed first. Run regular `nvim` once to ensure Lazy.nvim has installed all plugins, then try `nvim-claude` again.

### Permission issues

The container runs as your host user (via `--user`). If you encounter permission issues, ensure the mounted directories are owned by your user.

### Claude CLI not found

Ensure the container was built correctly. You can verify by running:
```bash
docker run --rm nvim-claude:latest which claude
```

### Claude asking to log in every time

Make sure `~/.claude` exists and contains your credentials (`.credentials.json`). The `~/.nvim-claude-home` directory stores Claude's state files (`.claude.json`). If authentication still fails, try removing `~/.nvim-claude-home` and letting it be recreated:
```bash
rm -rf ~/.nvim-claude-home
```

### Supermaven downloading every time

Ensure `~/.supermaven` and `~/.local/share/supermaven` are mounted. Run `nvim` once outside the container to initialize Supermaven and download the binary.

### Terminal colors or display issues

Set the TERM variable if you have issues:
```bash
TERM=xterm-256color nvim-claude
```

## Uninstallation

Run the setup script with `--uninstall`:
```bash
./nvim-claude-setup.sh --uninstall
```

This removes the shell functions. To also remove the Docker image:
```bash
docker rmi nvim-claude:latest
```

## Files

- `Dockerfile` - Container definition with Node.js and Claude CLI
- `nvim-claude-setup.sh` - Installation script that builds the image and sets up shell functions
- `README.md` - This documentation
