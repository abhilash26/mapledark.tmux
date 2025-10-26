#!/usr/bin/env bash
# ============================================================================
# Toggle Focus Mode
# ============================================================================

CURRENT_MODE=$(tmux show-environment -g TMUX_FOCUS_MODE 2>/dev/null | cut -d= -f2)

if [ -z "$CURRENT_MODE" ]; then
    CURRENT_MODE="0"
fi

if [ "$CURRENT_MODE" = "1" ]; then
    tmux setenv -g TMUX_FOCUS_MODE 0
    tmux set-option -g @mapledark-focus-mode 0
    tmux display-message "Focus Mode: OFF"
else
    tmux setenv -g TMUX_FOCUS_MODE 1
    tmux set-option -g @mapledark-focus-mode 1
    tmux display-message "Focus Mode: ON"
fi

# Refresh status bar
tmux refresh-client -S

