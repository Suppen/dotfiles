# Dockerfile for Claude Code CLI in a sandboxed environment
# This container provides the Claude Code CLI in an isolated environment
# with your project directory and Claude configuration mounted.

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

# Create a non-root user
RUN useradd -m -s /bin/bash claudeuser

# Create mount point directories with permissive permissions
# These will be overlaid by volume mounts at runtime
# The 777 permissions allow any UID (via --user) to write here
RUN mkdir -p /home/claudeuser/.claude \
             /workspace && \
    chmod -R 777 /home/claudeuser /workspace

# Ensure bash is used as the default shell
ENV SHELL=/bin/bash

# Switch to non-root user
USER claudeuser
WORKDIR /workspace

# Install Claude Code
RUN curl -fsSL https://claude.ai/install.sh | bash

# Default command
CMD ["/home/claudeuser/.local/bin/claude"]
