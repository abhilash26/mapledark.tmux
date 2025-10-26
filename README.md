# Maple Dark Theme for Tmux

A performance-optimized tmux theme plugin using the Maple Dark color scheme. Works with [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm) or as a standalone configuration.

**Note:** This plugin is purely a theme - it only sets colors and status bar styling. It does not modify any tmux behavior settings (keybindings, mouse support, window numbering, etc.). This gives you complete control over your tmux configuration.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Tmux](https://img.shields.io/badge/tmux-2.9%2B-green.svg)

## Features

- 🎨 **Beautiful Maple Dark color scheme** - Dark background with soft, muted accent colors
- ⚡ **Performance optimized** - Minimal refresh interval, no heavy scripts
- 🔌 **Plugin architecture** - Easy installation with TPM
- 🔤 **Dual icon support** - Nerd Fonts with ASCII fallback
- 🎯 **Focus mode** - Minimal distraction mode showing only essentials
- 🎛️ **Highly customizable** - Configure via tmux user options (@mapledark-*)
- 📦 **Standalone option** - Works without plugin manager too
- 🎨 **Consistent styling** - Pane borders, messages, and copy mode all themed

## Preview

### Default Mode (Nerd Fonts)
```
┌────────────────────────────────────────────────────────────────────┐
│  Session   #1:window1  #2:window2*                  ~/dev  @user  >>host  2025-01-26 14:32 │
└────────────────────────────────────────────────────────────────────┘
```

### Focus Mode
```
┌────────────────────────────────────────────────────────────────────┐
│  Session   #1:window1  #2:window2*                                                          │
└────────────────────────────────────────────────────────────────────┘
```

## Installation

### Method 1: TPM (Recommended)

1. Install [TPM](https://github.com/tmux-plugins/tpm) if you haven't already:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

2. Add the plugin to your `~/.tmux.conf`:

```bash
# Add to your plugin list
set -g @plugin 'abhilash26/mapledark.tmux'

# Initialize TPM (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

3. Install the plugin:
   - Press `prefix + I` (capital I) to fetch and install the plugin
   - Or run: `~/.tmux/plugins/tpm/bin/install_plugins`

### Method 2: Manual Installation

```bash
# Clone the repository
git clone https://github.com/abhilash26/mapledark.tmux.git ~/.tmux/plugins/mapledark.tmux

# Add to your ~/.tmux.conf
run-shell ~/.tmux/plugins/mapledark.tmux/mapledark.tmux
```

### Method 3: Standalone Configuration

For users who don't want to use plugins:

```bash
# Copy the standalone config
cp ~/.tmux/plugins/mapledark.tmux/mapledark.tmux.conf ~/.config/tmux/themes/

# Source it in your ~/.tmux.conf
source-file ~/.config/tmux/themes/mapledark.tmux.conf
```

## Configuration

### Available Options

Configure the theme by setting options in your `~/.tmux.conf` **before** loading the plugin:

```bash
# Icon mode: "nerd" (default) or "ascii"
set -g @mapledark-icon-mode "nerd"

# Focus mode: 0 (off, default) or 1 (on)
set -g @mapledark-focus-mode "0"

# Status bar position: "bottom" (default) or "top"
set -g @mapledark-status-position "bottom"

# Time format (strftime format)
set -g @mapledark-time-format "%Y-%m-%d %H:%M"

# Show/hide components: 1 (show, default) or 0 (hide)
set -g @mapledark-show-directory "1"
set -g @mapledark-show-user "1"
set -g @mapledark-show-host "1"
set -g @mapledark-show-time "1"

# Use military (24-hour) time: "true" (default) or "false"
set -g @mapledark-military-time "true"

# Window status separator
set -g @mapledark-window-status-separator ""
```

### Example Configuration

```bash
# ~/.tmux.conf

# Configure Maple Dark theme
set -g @mapledark-icon-mode "nerd"
set -g @mapledark-show-host "0"           # Hide hostname
set -g @mapledark-time-format "%H:%M"     # Show only time
set -g @mapledark-military-time "true"

# TPM plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'abhilash26/mapledark.tmux'

# Initialize TPM
run '~/.tmux/plugins/tpm/tpm'
```

## Optional Keybindings

The plugin includes toggle scripts but **does not bind any keys by default**. This gives you full control over your keybindings.

### Available Toggle Scripts

| Script | Function |
|--------|----------|
| `toggle-focus.sh` | Toggle focus mode (show/hide status components) |
| `toggle-icons.sh` | Switch between Nerd Fonts and ASCII icons |

### Adding Keybindings

Add these to your `~/.tmux.conf` to enable toggles:

```bash
# Toggle Focus Mode: prefix + F
bind-key F run-shell "bash ~/.tmux/plugins/mapledark.tmux/scripts/toggle-focus.sh"

# Toggle Icon Mode: prefix + I
bind-key I run-shell "bash ~/.tmux/plugins/mapledark.tmux/scripts/toggle-icons.sh"

# Or use different keys:
bind-key M run-shell "bash ~/.tmux/plugins/mapledark.tmux/scripts/toggle-focus.sh"
```

## Components

### Status Bar Left
- **Session name** - Current tmux session with icon
- **Window list** - All windows with numbers and names
- **Window flags** - Visual indicators:
  - `*` = current window
  - `-` = last window
  - `#` = activity detected
  - `!` = bell detected
  - `Z` = zoomed pane

### Status Bar Right (Customizable)
- **Current directory** - Basename of current path
- **Username** - Current user
- **Hostname** - System hostname
- **Date/Time** - Customizable format

### Additional Features
- **Active pane border** - Blue highlight
- **Inactive pane border** - Gray
- **Window activity** - Red highlight
- **Copy mode** - Blue selection
- **Messages** - Themed command line

## Color Palette

Based on the Maple Dark color scheme:

| Color | Hex | Usage |
|-------|-----|-------|
| Background | `#1e1e1f` | Status bar background |
| Foreground | `#cbd5e1` | Primary text |
| Blue | `#8fc7ff` | Session, borders, clock |
| Cyan | `#a1e8e5` | Hostname |
| Green | `#a4dfae` | Directory |
| Yellow | `#eecfa0` | Active window |
| Purple | `#d2ccff` | Username |
| Red | `#edabab` | Alerts, activity |

## Performance

This theme is optimized for minimal performance impact:

- ✅ **No external scripts** - Uses tmux built-in variables only
- ✅ **5 second refresh** - Balanced update interval
- ✅ **Static separators** - No dynamic generation
- ✅ **Basename paths** - Shows only directory name, not full path
- ✅ **Minimal format strings** - Reduced parsing overhead

For even better performance on older systems:
- Hide unused components (set to "0")
- Increase status-interval
- Use ASCII mode instead of Nerd Fonts

## Advanced Usage

### Programmatic Control

You can control the theme programmatically from scripts:

```bash
# Enable focus mode
tmux setenv -g TMUX_FOCUS_MODE 1
tmux set-option -g @mapledark-focus-mode 1

# Switch to ASCII icons
tmux setenv -g TMUX_ICON_MODE ascii
tmux set-option -g @mapledark-icon-mode ascii

# Reload theme
tmux run-shell ~/.tmux/plugins/mapledark.tmux/mapledark.tmux
```

### Integration with Other Plugins

Maple Dark works well with other tmux plugins:

```bash
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'abhilash26/mapledark.tmux'
```

### Custom Status Components

You can add custom components by modifying the status-right after loading the plugin:

```bash
# In your ~/.tmux.conf, after loading the plugin
set -ag status-right "#[fg=#8fc7ff] #(battery_percentage) "
```

## Troubleshooting

### Icons not displaying

**Problem:** Icons show as boxes or question marks

**Solutions:**
1. Install a [Nerd Font](https://www.nerdfonts.com/) (recommended: JetBrainsMono Nerd Font)
2. Configure your terminal to use the Nerd Font
3. Or switch to ASCII mode: `set -g @mapledark-icon-mode "ascii"`

### Colors look wrong

**Problem:** Colors don't match the preview

**Solutions:**
1. Ensure your terminal supports 256 colors and true color
2. Add to your shell config (~/.bashrc or ~/.zshrc):
```bash
export TERM=screen-256color
```
3. In tmux.conf:
```bash
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"
```

### Plugin not loading

**Problem:** Theme doesn't apply after installation

**Solutions:**
1. Ensure TPM is installed: `ls ~/.tmux/plugins/tpm`
2. Reload tmux config: `tmux source-file ~/.tmux.conf`
3. Install plugins: `prefix + I` (capital I)
4. Check for errors: `tmux show-messages`

### Status bar not updating

**Problem:** Changes don't appear

**Solutions:**
1. Reload configuration: `prefix + R`
2. Restart tmux: `tmux kill-server && tmux`
3. Check tmux version: `tmux -V` (requires 2.9+)

### Focus mode toggle not working

**Problem:** `prefix + F` doesn't toggle focus mode

**Solutions:**
1. Check if keybinding conflicts exist
2. Verify scripts are executable:
```bash
chmod +x ~/.tmux/plugins/mapledark.tmux/scripts/*.sh
```

## Requirements

- **Tmux** 2.9 or higher (for proper color support)
- **Bash** 4.0 or higher
- **(Optional)** [Nerd Font](https://www.nerdfonts.com/) for icon support
- **(Optional)** [TPM](https://github.com/tmux-plugins/tpm) for easy installation

## Contributing

Contributions are welcome! Feel free to:
- 🐛 Report bugs
- 💡 Suggest features
- 📝 Improve documentation
- 🔧 Submit pull requests

## License

MIT License - See [LICENSE](LICENSE) file for details

## Credits

- **Color scheme**: Maple Dark
- **Icons**: [Nerd Fonts](https://www.nerdfonts.com/)
- **Inspired by**: Various minimal tmux themes and performance-focused configurations

## Related Projects

- [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm) - Tmux Plugin Manager
- [catppuccin/tmux](https://github.com/catppuccin/tmux) - Catppuccin theme
- [dracula/tmux](https://github.com/dracula/tmux) - Dracula theme

## Changelog

### v1.0.0 (Current)
- Initial release as TPM plugin
- Dual icon support (Nerd Fonts + ASCII)
- Focus mode toggle
- Customizable components via user options
- Standalone configuration support
- Performance optimizations

## Support

- 📖 [Documentation](README.md)
- 🐛 [Issue Tracker](https://github.com/abhilash26/mapledark.tmux/issues)
- 💬 [Discussions](https://github.com/abhilash26/mapledark.tmux/discussions)

---

**Enjoy the Maple Dark theme!** ⭐ Star the repo if you find it useful!
