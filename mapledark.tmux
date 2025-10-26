#!/usr/bin/env bash
# ============================================================================
# Maple Dark Theme for Tmux - Main Plugin Entry Point
# ============================================================================
# TPM (Tmux Plugin Manager) compatible plugin
# Repository: https://github.com/yourusername/mapledark.tmux
# ============================================================================

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ============================================================================
# Default Options
# ============================================================================
# Users can override these in their tmux.conf with:
# set -g @mapledark-option-name "value"

get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value
    option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

# Get user options or use defaults
ICON_MODE=$(get_tmux_option "@mapledark-icon-mode" "nerd")
FOCUS_MODE=$(get_tmux_option "@mapledark-focus-mode" "0")
STATUS_POSITION=$(get_tmux_option "@mapledark-status-position" "bottom")
TIME_FORMAT=$(get_tmux_option "@mapledark-time-format" "%Y-%m-%d %H:%M")
SHOW_DIRECTORY=$(get_tmux_option "@mapledark-show-directory" "1")
SHOW_USER=$(get_tmux_option "@mapledark-show-user" "1")
SHOW_HOST=$(get_tmux_option "@mapledark-show-host" "1")
SHOW_TIME=$(get_tmux_option "@mapledark-show-time" "1")
MILITARY_TIME=$(get_tmux_option "@mapledark-military-time" "true")
WINDOW_STATUS_SEPARATOR=$(get_tmux_option "@mapledark-window-status-separator" "")

# ============================================================================
# Color Definitions (from colors.json)
# ============================================================================
BACKGROUND="#1e1e1f"
FOREGROUND="#cbd5e1"
BRIGHT_BLACK="#666666"
BRIGHT_BLUE="#a8e0ff"
BRIGHT_CYAN="#bafffe"
BRIGHT_GREEN="#bdf8c7"
BRIGHT_PURPLE="#ebe5ff"
BRIGHT_RED="#ffc4c4"
BRIGHT_WHITE="#ffffff"
BRIGHT_YELLOW="#ffe8b9"
BLACK="#333333"
BLUE="#8fc7ff"
CYAN="#a1e8e5"
GREEN="#a4dfae"
PURPLE="#d2ccff"
RED="#edabab"
WHITE="#f3f2f2"
YELLOW="#eecfa0"

# ============================================================================
# Icon Configuration
# ============================================================================
if [ "$ICON_MODE" = "nerd" ]; then
    ICON_SESSION=""
    ICON_WINDOW=""
    ICON_DIR=""
    ICON_USER=""
    ICON_HOST=""
    ICON_CLOCK=""
    SEP_LEFT=""
    SEP_RIGHT=""
else
    ICON_SESSION="[S]"
    ICON_WINDOW="#"
    ICON_DIR="DIR"
    ICON_USER="@"
    ICON_HOST=">>"
    ICON_CLOCK=""
    SEP_LEFT="|"
    SEP_RIGHT=">"
fi

# ============================================================================
# Set Environment Variables for Runtime Access
# ============================================================================
tmux setenv -g TMUX_FOCUS_MODE "$FOCUS_MODE"
tmux setenv -g TMUX_ICON_MODE "$ICON_MODE"

# ============================================================================
# Apply Theme Settings
# ============================================================================

# General Status Bar Settings
tmux set-option -g status on
tmux set-option -g status-position "$STATUS_POSITION"
tmux set-option -g status-justify left
tmux set-option -g status-interval 5
tmux set-option -g status-style "bg=$BACKGROUND,fg=$FOREGROUND"
tmux set-option -g status-left-length 50
tmux set-option -g status-right-length 150

# Pane Border Styling
tmux set-option -g pane-border-style "fg=$BRIGHT_BLACK"
tmux set-option -g pane-active-border-style "fg=$BLUE"
tmux set-option -g display-panes-colour "$BRIGHT_BLACK"
tmux set-option -g display-panes-active-colour "$BLUE"

# Window Styling
tmux set-option -g window-style "fg=$FOREGROUND"
tmux set-option -g window-active-style "fg=$BRIGHT_WHITE"

# Message Styling
tmux set-option -g message-style "bg=$BLACK,fg=$FOREGROUND"
tmux set-option -g message-command-style "bg=$BLACK,fg=$BLUE"

# Copy Mode Styling
tmux set-option -g mode-style "bg=$BLUE,fg=$BACKGROUND"

# Clock Mode
tmux set-option -g clock-mode-colour "$BLUE"
if [ "$MILITARY_TIME" = "true" ]; then
    tmux set-option -g clock-mode-style 24
else
    tmux set-option -g clock-mode-style 12
fi

# ============================================================================
# Status Left: Session Name + Window List
# ============================================================================
STATUS_LEFT="#[fg=$BACKGROUND]#[bg=$BLUE]#[bold] $ICON_SESSION #S #[fg=$BLUE]#[bg=$BACKGROUND]$SEP_LEFT #[fg=$FOREGROUND]#[bg=$BACKGROUND]"
tmux set-option -g status-left "$STATUS_LEFT"

# ============================================================================
# Window Status Format
# ============================================================================
WINDOW_STATUS_FORMAT="#[fg=$BRIGHT_BLACK]#[bg=$BACKGROUND] $ICON_WINDOW #[fg=$YELLOW]#I#[fg=$BRIGHT_BLACK]:#[fg=$FOREGROUND]#W#[fg=$RED]#{?window_flags,#{window_flags}, } "
WINDOW_STATUS_CURRENT="#[fg=$BACKGROUND]#[bg=$YELLOW]#[bold] $ICON_WINDOW #[fg=$BACKGROUND]#I#[fg=$BACKGROUND]:#[fg=$BACKGROUND]#W#[fg=$RED]#{?window_flags,#{window_flags}, } #[fg=$YELLOW]#[bg=$BACKGROUND]$SEP_LEFT"

tmux set-option -g window-status-format "$WINDOW_STATUS_FORMAT"
tmux set-option -g window-status-current-format "$WINDOW_STATUS_CURRENT"
tmux set-option -g window-status-style "fg=$FOREGROUND,bg=$BACKGROUND"
tmux set-option -g window-status-current-style "fg=$BACKGROUND,bg=$YELLOW,bold"
tmux set-option -g window-status-activity-style "fg=$RED,bg=$BACKGROUND"
tmux set-option -g window-status-bell-style "fg=$BRIGHT_RED,bg=$BACKGROUND,bold"
tmux set-option -g window-status-separator "$WINDOW_STATUS_SEPARATOR"

# ============================================================================
# Status Right: Directory, Username, Hostname, Date/Time
# ============================================================================
STATUS_RIGHT=""

# Build status right based on user options
if [ "$SHOW_DIRECTORY" = "1" ]; then
    STATUS_RIGHT="$STATUS_RIGHT#[fg=$GREEN]#[bg=$BACKGROUND]$SEP_RIGHT#[fg=$BACKGROUND]#[bg=$GREEN]#[bold] $ICON_DIR #{b:pane_current_path} "
fi

if [ "$SHOW_USER" = "1" ]; then
    STATUS_RIGHT="$STATUS_RIGHT#[fg=$PURPLE]#[bg=$BACKGROUND]$SEP_RIGHT#[fg=$BACKGROUND]#[bg=$PURPLE]#[bold] $ICON_USER #(whoami) "
fi

if [ "$SHOW_HOST" = "1" ]; then
    STATUS_RIGHT="$STATUS_RIGHT#[fg=$CYAN]#[bg=$BACKGROUND]$SEP_RIGHT#[fg=$BACKGROUND]#[bg=$CYAN]#[bold] $ICON_HOST #H "
fi

if [ "$SHOW_TIME" = "1" ]; then
    STATUS_RIGHT="$STATUS_RIGHT#[fg=$BLUE]#[bg=$BACKGROUND]$SEP_RIGHT#[fg=$BACKGROUND]#[bg=$BLUE]#[bold] $ICON_CLOCK $TIME_FORMAT "
fi

# Set minimal status for focus mode
STATUS_RIGHT_MINIMAL=""

# Apply conditional status right based on focus mode
tmux set-option -g status-right "#{?#{==:#{TMUX_FOCUS_MODE},1},$STATUS_RIGHT_MINIMAL,$STATUS_RIGHT}"

# ============================================================================
# Optional Key Bindings (users can add these to their tmux.conf)
# ============================================================================
# Uncomment to enable keybindings (or add to your own tmux.conf):
#
# Toggle focus mode: prefix + F
# bind-key F run-shell "bash $CURRENT_DIR/scripts/toggle-focus.sh"
#
# Toggle icon mode: prefix + I
# bind-key I run-shell "bash $CURRENT_DIR/scripts/toggle-icons.sh"

# ============================================================================
# Plugin Initialization Complete
# ============================================================================
# Note: This plugin only sets the theme. It does NOT modify:
# - Terminal settings (default-terminal, terminal-overrides)
# - Window/pane numbering (base-index, pane-base-index)
# - Behavior settings (renumber-windows, escape-time, etc.)
# - Activity monitoring settings
# - History limits
#
# Add your preferred settings to your own ~/.tmux.conf
# ============================================================================

