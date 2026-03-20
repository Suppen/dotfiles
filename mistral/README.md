# mistral-docker

Run Mistral Vibe CLI in a sandboxed Docker container with your project directory mounted.

## Overview

This setup allows you to run the Mistral Vibe CLI inside a Docker container, providing an isolated sandbox environment. The container mounts your current directory and Mistral configuration, keeping your work isolated from your host system.

## Features

- **Norwegian locale** (nb_NO.UTF-8)
- **Mistral Vibe CLI** pre-installed
- **Mounted volumes** for seamless integration:
  - Project directory (current working directory)
  - Mistral configuration (`~/.vibe`)
  - Container home directory (`~/.mistral-docker-home`) for Mistral state files
- **Security protection** - refuses to run from sensitive directories

## Prerequisites

- Docker installed and running

## Installation

1. Clone or copy these files to a directory:
   ```bash
   mkdir -p ~/mistral-docker
   cd ~/mistral-docker
   # Copy Dockerfile, mistral-docker-setup.sh, and README.md here
   ```

2. Make the setup script executable:
   ```bash
   chmod +x mistral-docker-setup.sh
   ```

3. Run the setup script:
   ```bash
   ./mistral-docker-setup.sh
   ```

4. Restart your shell (or start a new terminal)

## Usage

Navigate to your project directory and run `mistral`:
```bash
cd ~/projects/my-project
mistral
```

This starts Mistral Vibe CLI inside the Docker container with your project directory mounted at `/workspace`.

### Authentication

On first use, you'll need to authenticate with Mistral:

1. Run `mistral` in any project directory
2. Complete the authentication flow
3. Your credentials are saved to `~/.vibe` and persist across container restarts

Alternatively, set an API key via environment variable:
```bash
export MISTRAL_API_KEY="your-key-here"
mistral
```

## How It Works

### Volumes

| Host Path | Container Path | Purpose |
|-----------|----------------|---------|
| `~/.mistral-docker-home` | `/home/mistraluser` | Container home (base layer for Mistral state files) |
| `$(pwd)` | `/workspace` | Your project directory |
| `~/.mistral-docker-home/.vibe` | `/home/mistraluser/.vibe` | Mistral Vibe credentials and config |

The container home (`~/.mistral-docker-home`) is mounted first as a base layer, then other directories are overlaid on top. This allows Mistral to write its state files to a persistent location.

### Security

The `mistral` function refuses to run from these directories:
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

This prevents accidentally exposing sensitive data to Mistral.

## Troubleshooting

### Mistral Vibe CLI not found

Ensure the container was built correctly. You can verify by running:
```bash
docker run --rm mistral-docker:latest which vibe
```

### Mistral asking to log in every time

Make sure `~/.mistral-docker-home/.vibe` exists and contains your credentials. If authentication still fails, try removing `~/.mistral-docker-home` and letting it be recreated:
```bash
rm -rf ~/.mistral-docker-home
```

### Permission issues

The container runs as your host user (via `--user`). If you encounter permission issues, ensure the mounted directories are owned by your user.

### Terminal colors or display issues

Set the TERM variable if you have issues:
```bash
TERM=xterm-256color mistral
```

## Uninstallation

Run the setup script with `--uninstall`:
```bash
./mistral-docker-setup.sh --uninstall
```

This removes the shell functions. To also remove the Docker image:
```bash
docker rmi mistral-docker:latest
```

## Files

- `Dockerfile` - Container definition with Mistral Vibe CLI
- `mistral-docker-setup.sh` - Installation script that builds the image and sets up shell functions
- `README.md` - This documentation
