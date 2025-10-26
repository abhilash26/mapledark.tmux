# Maple Dark Plugin Options

Complete reference for all available customization options.

## Quick Reference

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `@mapledark-icon-mode` | string | `"nerd"` | Icon set: "nerd" or "ascii" |
| `@mapledark-focus-mode` | string | `"0"` | Focus mode: "0" (off) or "1" (on) |
| `@mapledark-status-position` | string | `"bottom"` | Status bar position: "bottom" or "top" |
| `@mapledark-time-format` | string | `"%Y-%m-%d %H:%M"` | Time format (strftime) |
| `@mapledark-show-directory` | string | `"1"` | Show directory: "1" (yes) or "0" (no) |
| `@mapledark-show-user` | string | `"1"` | Show username: "1" (yes) or "0" (no) |
| `@mapledark-show-host` | string | `"1"` | Show hostname: "1" (yes) or "0" (no) |
| `@mapledark-show-time` | string | `"1"` | Show time: "1" (yes) or "0" (no) |
| `@mapledark-military-time` | string | `"true"` | 24-hour format: "true" or "false" |
| `@mapledark-window-status-separator` | string | `""` | Separator between windows |
| `@mapledark-window-rename-mode` | string | `"none"` | Window naming: "none", "automatic", or "manual" |

## Detailed Options

### Icon Mode

Controls which icon set to use.

```bash
set -g @mapledark-icon-mode "nerd"
```

**Values:**
- `"nerd"` (default) - Use Nerd Font icons (requires Nerd Font installation)
- `"ascii"` - Use ASCII characters for maximum compatibility

**Nerd Font Icons:**
- Session:
- Window:
- Directory:
- User:
- Host:
- Clock:
- Separators:

**ASCII Icons:**
- Session: [S]
- Window: #
- Directory: DIR
- User: @
- Host: >>
- Separators: | and >

**Runtime Toggle:** `prefix + I`

---

### Focus Mode

Minimal status bar showing only session and window list.

```bash
set -g @mapledark-focus-mode "0"
```

**Values:**
- `"0"` (default) - Show all components
- `"1"` - Show only session name and window list

**When enabled:**
- ✅ Visible: Session name, window list
- ❌ Hidden: Directory, username, hostname, date/time

**Runtime Toggle:** `prefix + F`

---

### Status Position

Control where the status bar appears.

```bash
set -g @mapledark-status-position "bottom"
```

**Values:**
- `"bottom"` (default) - Status bar at bottom
- `"top"` - Status bar at top

---

### Time Format

Customize the date/time display using strftime format.

```bash
set -g @mapledark-time-format "%Y-%m-%d %H:%M"
```

**Common Formats:**

| Format | Example | Description |
|--------|---------|-------------|
| `"%Y-%m-%d %H:%M"` | 2025-01-26 14:32 | Full date with 24h time (default) |
| `"%H:%M"` | 14:32 | Time only (24h) |
| `"%I:%M %p"` | 02:32 PM | Time only (12h) |
| `"%m/%d %H:%M"` | 01/26 14:32 | Short date with time |
| `"%a %H:%M"` | Sun 14:32 | Weekday with time |
| `"%b %d"` | Jan 26 | Month and day |

**Format Codes:**
- `%Y` - Year (4 digits)
- `%m` - Month (01-12)
- `%d` - Day (01-31)
- `%H` - Hour 24h (00-23)
- `%I` - Hour 12h (01-12)
- `%M` - Minute (00-59)
- `%S` - Second (00-59)
- `%p` - AM/PM
- `%a` - Weekday short (Mon)
- `%A` - Weekday full (Monday)
- `%b` - Month short (Jan)
- `%B` - Month full (January)

---

### Show Directory

Toggle directory display in status bar.

```bash
set -g @mapledark-show-directory "1"
```

**Values:**
- `"1"` (default) - Show current directory basename
- `"0"` - Hide directory

**Display:** Shows basename only (e.g., `~/dev` instead of `/home/user/dev`)

---

### Show User

Toggle username display in status bar.

```bash
set -g @mapledark-show-user "1"
```

**Values:**
- `"1"` (default) - Show username
- `"0"` - Hide username

**Display:** Shows result of `whoami` command

---

### Show Host

Toggle hostname display in status bar.

```bash
set -g @mapledark-show-host "1"
```

**Values:**
- `"1"` (default) - Show hostname
- `"0"` - Hide hostname

**Display:** Shows system hostname (short form)

---

### Show Time

Toggle date/time display in status bar.

```bash
set -g @mapledark-show-time "1"
```

**Values:**
- `"1"` (default) - Show date/time
- `"0"` - Hide date/time

**Format:** Uses `@mapledark-time-format` option

---

### Military Time

Control clock mode time format (not status bar).

```bash
set -g @mapledark-military-time "true"
```

**Values:**
- `"true"` (default) - Use 24-hour format in clock mode
- `"false"` - Use 12-hour format in clock mode

**Note:** This affects tmux clock mode (`prefix + t`), not the status bar time display. Use `@mapledark-time-format` to control status bar time.

---

### Window Rename Mode

Control how tmux names your windows - fixes the issue where windows show directory names instead of application names.

```bash
set -g @mapledark-window-rename-mode "none"
```

**Values:**
- `"none"` (default) - **Show application/process name** - Disables automatic renaming so windows show the running application (vim, bash, htop, etc.)
- `"automatic"` - Show directory name - Let tmux automatically rename windows based on current directory
- `"manual"` - Manual names only - Respect only user-set window names, ignore automatic renaming

**Problem this solves:**
By default, some tmux setups show the current directory instead of the running application in window names. Setting this to `"none"` (default) ensures you see what program is running (e.g., "vim", "htop") rather than the directory path.

**Examples:**

```bash
# Default - show application names (vim, bash, etc.)
set -g @mapledark-window-rename-mode "none"
# Window shows: "vim" when editing, "htop" when monitoring

# Automatic - show directory names
set -g @mapledark-window-rename-mode "automatic"
# Window shows: "~" or "~/dev" or "project"

# Manual - only use names you set with Ctrl+b ,
set -g @mapledark-window-rename-mode "manual"
# Window shows: whatever you name it manually
```

**Note:** This is related to tmux's `automatic-rename` and `allow-rename` options. The plugin sets these for you based on your preference.

---

### Window Status Separator

Character(s) between window items in the window list.

```bash
set -g @mapledark-window-status-separator ""
```

**Values:**
- `""` (default) - No separator (seamless)
- `" "` - Single space
- `" | "` - Pipe separator with spaces
- Any custom string

**Examples:**

```bash
# No separator (default)
set -g @mapledark-window-status-separator ""
# Result: 1:vim 2:bash* 3:htop

# Space separator
set -g @mapledark-window-status-separator " "
# Result: 1:vim  2:bash*  3:htop

# Pipe separator
set -g @mapledark-window-status-separator " | "
# Result: 1:vim | 2:bash* | 3:htop
```

---

## Configuration Examples

### Minimal Setup

```bash
# ~/.tmux.conf
set -g @plugin 'yourusername/mapledark.tmux'
run '~/.tmux/plugins/tpm/tpm'
```

### Customized Setup

```bash
# ~/.tmux.conf

# Use ASCII icons (no Nerd Font required)
set -g @mapledark-icon-mode "ascii"

# Show time only, no date
set -g @mapledark-time-format "%H:%M"

# Hide hostname
set -g @mapledark-show-host "0"

# Add separator between windows
set -g @mapledark-window-status-separator " "

# Load plugin
set -g @plugin 'yourusername/mapledark.tmux'
run '~/.tmux/plugins/tpm/tpm'
```

### Minimal Status Bar

```bash
# ~/.tmux.conf

# Hide all optional components
set -g @mapledark-show-directory "0"
set -g @mapledark-show-user "0"
set -g @mapledark-show-host "0"
set -g @mapledark-show-time "0"

# Or just enable focus mode by default
set -g @mapledark-focus-mode "1"

# Load plugin
set -g @plugin 'yourusername/mapledark.tmux'
run '~/.tmux/plugins/tpm/tpm'
```

### Top Status Bar

```bash
# ~/.tmux.conf

# Move status bar to top
set -g @mapledark-status-position "top"

# Load plugin
set -g @plugin 'yourusername/mapledark.tmux'
run '~/.tmux/plugins/tpm/tpm'
```

### 12-Hour Time Format

```bash
# ~/.tmux.conf

# Show 12-hour time with AM/PM
set -g @mapledark-time-format "%I:%M %p"
set -g @mapledark-military-time "false"

# Load plugin
set -g @plugin 'yourusername/mapledark.tmux'
run '~/.tmux/plugins/tpm/tpm'
```

---

## Dynamic Updates

Most options can be changed at runtime:

```bash
# Change an option
tmux set-option -g @mapledark-show-host "0"

# Reload the plugin
tmux run-shell ~/.tmux/plugins/mapledark.tmux/mapledark.tmux
```

Or reload your entire configuration:

```bash
tmux source-file ~/.tmux.conf
# Or use: prefix + R
```

---

## Option Precedence

Options are loaded in this order (later overrides earlier):

1. Plugin defaults (in `mapledark.tmux` script)
2. User options in `~/.tmux.conf` (before loading plugin)
3. Runtime environment variables (`TMUX_FOCUS_MODE`, `TMUX_ICON_MODE`)
4. Manual tmux commands

---

## Validation

Options are not strictly validated. Invalid values may cause unexpected behavior:

**Safe values:**
- Boolean options: `"0"` or `"1"`
- String options: any valid string
- Time format: valid strftime format

**Unsafe values:**
- Non-boolean values for show-* options
- Invalid strftime format strings
- Special characters in separators (may break formatting)

---

## Performance Impact

Options that affect performance:

| Option | Impact | Notes |
|--------|--------|-------|
| `@mapledark-show-directory` | Low | Basename only (fast) |
| `@mapledark-show-user` | Low | Calls `whoami` once |
| `@mapledark-show-host` | None | Built-in tmux variable |
| `@mapledark-show-time` | None | Built-in tmux formatting |
| `@mapledark-icon-mode` | None | Static strings |
| `@mapledark-focus-mode` | Positive | Hides components = better performance |

**Recommendation:** All options have minimal to no performance impact. Focus mode can actually improve performance by hiding components.

---

## Environment Variables

The plugin also uses environment variables internally:

- `TMUX_FOCUS_MODE` - Tracks focus mode state
- `TMUX_ICON_MODE` - Tracks icon mode state

These are automatically managed by the plugin but can be set manually:

```bash
# Enable focus mode
tmux setenv -g TMUX_FOCUS_MODE 1

# Switch to ASCII icons
tmux setenv -g TMUX_ICON_MODE ascii

# Refresh display
tmux refresh-client -S
```

---

## See Also

- [README.md](README.md) - General documentation
- [Example Configuration](example.tmux.conf) - Sample setup
- [Keybindings](README.md#keybindings) - Runtime toggles

