# claude-docker

Run Claude Code CLI in a sandboxed Docker container with your project directory mounted.

## Overview

This setup allows you to run the Claude Code CLI inside a Docker container, providing an isolated sandbox environment. The container mounts your current directory and Claude configuration, keeping your work isolated from your host system.

## Features

- **Norwegian locale** (nb_NO.UTF-8)
- **Latest Node.js** (v24 LTS) for Claude CLI
- **Claude Code CLI** pre-installed
- **Mounted volumes** for seamless integration:
  - Project directory (current working directory)
  - Claude configuration (`~/.claude`)
  - Container home directory (`~/.claude-docker-home`) for Claude state files
- **Security protection** - refuses to run from sensitive directories

## Prerequisites

- Docker installed and running

## Installation

1. Clone or copy these files to a directory:
   ```bash
   mkdir -p ~/claude-docker
   cd ~/claude-docker
   # Copy Dockerfile, claude-docker-setup.sh, and README.md here
   ```

2. Make the setup script executable:
   ```bash
   chmod +x claude-docker-setup.sh
   ```

3. Run the setup script:
   ```bash
   ./claude-docker-setup.sh
   ```

4. Restart your shell (or start a new terminal)

## Usage

Navigate to your project directory and run `claude`:
```bash
cd ~/projects/my-project
claude
```

This starts Claude Code CLI inside the Docker container with your project directory mounted at `/workspace`.

### Authentication

On first use, you'll need to authenticate with Claude:

1. Run `claude` in any project directory
2. Complete the authentication flow
3. Your credentials are saved to `~/.claude` and persist across container restarts

Alternatively, set an API key via environment variable:
```bash
export ANTHROPIC_API_KEY="your-key-here"
claude
```

## How It Works

### Volumes

| Host Path | Container Path | Purpose |
|-----------|----------------|---------|
| `~/.claude-docker-home` | `/home/claudeuser` | Container home (base layer for Claude state files) |
| `$(pwd)` | `/workspace` | Your project directory |
| `~/.claude` | `/home/claudeuser/.claude` | Claude CLI credentials |

The container home (`~/.claude-docker-home`) is mounted first as a base layer, then other directories are overlaid on top. This allows Claude to write its state files (`.claude.json`, etc.) to a persistent location.

### Security

The `claude` function refuses to run from these directories:
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

### Claude CLI not found

Ensure the container was built correctly. You can verify by running:
```bash
docker run --rm claude-docker:latest which claude
```

### Claude asking to log in every time

Make sure `~/.claude` exists and contains your credentials (`.credentials.json`). The `~/.claude-docker-home` directory stores Claude's state files (`.claude.json`). If authentication still fails, try removing `~/.claude-docker-home` and letting it be recreated:
```bash
rm -rf ~/.claude-docker-home
```

### Permission issues

The container runs as your host user (via `--user`). If you encounter permission issues, ensure the mounted directories are owned by your user.

### Terminal colors or display issues

Set the TERM variable if you have issues:
```bash
TERM=xterm-256color claude
```

## Uninstallation

Run the setup script with `--uninstall`:
```bash
./claude-docker-setup.sh --uninstall
```

This removes the shell functions. To also remove the Docker image:
```bash
docker rmi claude-docker:latest
```

## Files

- `Dockerfile` - Container definition with Node.js and Claude CLI
- `claude-docker-setup.sh` - Installation script that builds the image and sets up shell functions
- `README.md` - This documentation
