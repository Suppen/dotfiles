# Dockerfile for Mistral Vibe CLI in a sandboxed environment
# This container provides the Mistral Vibe CLI in an isolated environment
# with your project directory and Mistral configuration mounted.

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
RUN useradd -m -s /bin/bash vibeuser

# Create mount point directories with permissive permissions
# These will be overlaid by volume mounts at runtime
# The 777 permissions allow any UID (via --user) to write here
RUN mkdir -p /home/vibeuser/.vibe \
             /workspace && \
    chmod -R 777 /home/vibeuser /workspace

# Ensure bash is used as the default shell
ENV SHELL=/bin/bash

# Switch to non-root user
USER vibeuser

# Install Mistral Vibe
RUN curl -LsSf https://mistral.ai/vibe/install.sh | bash

# Move the .local directory to somewhere else to stop Vibe from leaking to outside the sandbox
USER root
RUN mv /home/vibeuser/.local/ /opt/vibeuser-local
RUN ln -s /opt/vibeuser-local/bin/vibe /usr/local/bin/vibe

# Switch back to the unprivileged user
USER vibeuser
WORKDIR /workspace

# Default command
CMD ["vibe"]
