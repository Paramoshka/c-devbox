# ============================
# c-devbox Dockerfile
# Ubuntu 24.04 LTS + Neovim 0.11
# ============================

FROM ubuntu:24.04

# Create user 'devbox' with sudo privileges and no password
RUN apt-get update && apt-get install -y \
    libbpf-dev \
    sudo \
    curl \
    wget \
    git \
    make \
    cmake \
    gcc \
    clang \
    clangd \
    llvm \
    python3 \
    python3-pip \
    ripgrep \
    unzip \
    locales && \
    locale-gen en_US.UTF-8 && \
    useradd -ms /bin/bash devbox && \
    echo 'devbox ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install Neovim 0.11.0 AppImage
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.appimage && \
    chmod u+x nvim-linux-x86_64.appimage && \
    ./nvim-linux-x86_64.appimage --appimage-extract && \
    mv squashfs-root /opt/nvim && \
    ln -s /opt/nvim/AppRun /usr/local/bin/nvim

# Install lazy.nvim plugin manager
RUN git clone https://github.com/folke/lazy.nvim.git /home/devbox/.local/share/nvim/site/pack/lazy/start/lazy.nvim

# Copy Neovim config
COPY --chown=devbox:devbox nvim/ /home/devbox/.config/nvim/

# Copy startup script
COPY --chown=devbox:devbox entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
# Set working directory
WORKDIR /workspace

# Fix permissions
RUN mkdir -p /home/devbox/.local/share/nvim && \
    chown -R devbox:devbox /home/devbox


# Switch to devbox user
USER devbox

# Run run.sh script on container start
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
