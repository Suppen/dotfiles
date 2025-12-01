# Dockerfile for Neovim with Claude Code CLI support
# This container provides the Claude Code CLI environment while using
# your host's Neovim configuration and cache via mounted volumes.

FROM ubuntu:24.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set Norwegian locale
RUN apt-get update && apt-get install -y locales && \
    sed -i '/nb_NO.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen nb_NO.UTF-8
ENV LANG=nb_NO.UTF-8
ENV LANGUAGE=nb_NO:nb
ENV LC_ALL=nb_NO.UTF-8

# Install base dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    ripgrep \
    fd-find \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install latest Node.js (LTS) via NodeSource
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_24.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Claude Code CLI globally
RUN npm install -g @anthropic-ai/claude-code

# Create a non-root user
RUN useradd -m -s /bin/bash nvimuser

# Create mount point directories with permissive permissions
# These will be overlaid by volume mounts at runtime
# The 777 permissions allow any UID (via --user) to write here
RUN mkdir -p /home/nvimuser/.config/nvim \
             /home/nvimuser/.local/share/nvim \
             /home/nvimuser/.local/state/nvim \
             /home/nvimuser/.cache/nvim \
             /workspace \
             /host-nvim && \
    chmod -R 777 /home/nvimuser /workspace

# Ensure bash is used as the default shell
ENV SHELL=/bin/bash

# Set up PATH to include host neovim (must be mounted)
# Also ensure npm global binaries are in PATH
ENV PATH="/host-nvim/bin:${PATH}"
ENV npm_config_prefix=/home/nvimuser/.npm-global
ENV PATH="/home/nvimuser/.npm-global/bin:${PATH}"

# Switch to non-root user
USER nvimuser
WORKDIR /workspace

# Set XDG directories to use mounted volumes
ENV XDG_CONFIG_HOME=/home/nvimuser/.config
ENV XDG_DATA_HOME=/home/nvimuser/.local/share
ENV XDG_STATE_HOME=/home/nvimuser/.local/state
ENV XDG_CACHE_HOME=/home/nvimuser/.cache

# Default command
CMD ["nvim"]
