#!/usr/bin/env bash
# ============================================================================
# Maple Dark Theme - Keybindings
# ============================================================================

# Toggle Focus Mode: prefix + F
tmux bind-key F run-shell "bash $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/toggle-focus.sh"

# Toggle Icon Mode: prefix + I
tmux bind-key I run-shell "bash $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/toggle-icons.sh"

# Reload Theme: prefix + R (capital R to avoid conflicts)
tmux bind-key R run-shell "tmux source-file ~/.tmux.conf && tmux display-message 'Configuration reloaded!'"

