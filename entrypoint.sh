#!/usr/bin/env bash

# Ensure permissions are correct
chown -R devbox:devbox /home/devbox

# Change to workspace directory
cd /workspace

# Optional: Update plugins (future improvement)

# Start Neovim
exec nvim

