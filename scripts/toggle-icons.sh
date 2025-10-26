#!/usr/bin/env bash
# ============================================================================
# Toggle Icon Mode
# ============================================================================

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(dirname "$CURRENT_DIR")"

CURRENT_MODE=$(tmux show-environment -g TMUX_ICON_MODE 2>/dev/null | cut -d= -f2)

if [ -z "$CURRENT_MODE" ]; then
    CURRENT_MODE="nerd"
fi

if [ "$CURRENT_MODE" = "nerd" ]; then
    tmux setenv -g TMUX_ICON_MODE ascii
    tmux set-option -g @mapledark-icon-mode ascii
    tmux display-message "Icon Mode: ASCII"
else
    tmux setenv -g TMUX_ICON_MODE nerd
    tmux set-option -g @mapledark-icon-mode nerd
    tmux display-message "Icon Mode: Nerd Fonts"
fi

# Reload the plugin to apply new icons
bash "$PLUGIN_DIR/mapledark.tmux"

