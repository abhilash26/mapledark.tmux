# Maple Dark Tmux Theme - Installation Guide

Quick installation instructions for different scenarios.

**Important:** This plugin is purely a theme. It only sets colors and status bar styling. You'll need to configure your own:
- Keybindings
- Mouse support
- Window/pane numbering
- Terminal settings
- History limits
- Other tmux behavior preferences

## Prerequisites

- **Tmux** 2.9 or higher
- **Bash** 4.0 or higher
- **(Optional)** [Nerd Fonts](https://www.nerdfonts.com/) for icon support

Check your tmux version:
```bash
tmux -V
```

## Method 1: TPM (Recommended)

Best for most users. Automatic updates and easy management.

### Step 1: Install TPM

If you don't have TPM installed:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Step 2: Configure

Add to your `~/.tmux.conf`:

```bash
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'yourusername/mapledark.tmux'

# Initialize TPM (keep this at the very bottom)
run '~/.tmux/plugins/tpm/tpm'
```

### Step 3: Install

Inside tmux, press:
```
prefix + I
```
(That's prefix followed by capital I)

Or run manually:
```bash
~/.tmux/plugins/tpm/bin/install_plugins
```

### Step 4: Reload

```bash
tmux source-file ~/.tmux.conf
```

Or press: `prefix + R`

**Done!** 🎉

---

## Method 2: Manual Installation

For users who prefer not to use TPM.

### Step 1: Clone Repository

```bash
git clone https://github.com/yourusername/mapledark.tmux.git ~/.tmux/plugins/mapledark.tmux
```

### Step 2: Make Scripts Executable

```bash
chmod +x ~/.tmux/plugins/mapledark.tmux/mapledark.tmux
chmod +x ~/.tmux/plugins/mapledark.tmux/scripts/*.sh
```

### Step 3: Source in tmux.conf

Add to your `~/.tmux.conf`:

```bash
run-shell ~/.tmux/plugins/mapledark.tmux/mapledark.tmux
```

### Step 4: Reload

```bash
tmux source-file ~/.tmux.conf
```

**Done!** 🎉

---

## Method 3: Standalone Configuration

For users who want direct configuration without plugin structure.

### Step 1: Copy Configuration

```bash
# Create themes directory
mkdir -p ~/.config/tmux/themes

# Copy the standalone config
cp ~/.tmux/plugins/mapledark.tmux/mapledark.tmux.conf ~/.config/tmux/themes/
```

### Step 2: Source in tmux.conf

Add to your `~/.tmux.conf`:

```bash
source-file ~/.config/tmux/themes/mapledark.tmux.conf
```

### Step 3: Reload

```bash
tmux source-file ~/.tmux.conf
```

**Done!** 🎉

**Note:** With this method, keybindings `prefix + I` (icon toggle) and `prefix + F` (focus toggle) work, but you can't use TPM user options (@mapledark-*).

---

## Verification

After installation, you should see:

- Status bar with Maple Dark colors
- Session name on the left
- Window list with numbers
- Directory, user, host, and time on the right (if enabled)

### Test Keybindings

- `prefix + F` - Toggle focus mode (should hide/show components)
- `prefix + I` - Toggle icon mode (should switch between Nerd Fonts and ASCII)
- `prefix + R` - Reload configuration

If you see "unknown command" errors, check that scripts are executable.

---

## First-Time Setup

### 1. Install Nerd Font (Optional)

For the best experience with icon support:

```bash
# Download a Nerd Font (example: JetBrainsMono)
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip

# Refresh font cache
fc-cache -fv
```

Configure your terminal to use the font:
- **GNOME Terminal**: Preferences → Profile → Font
- **Alacritty**: Edit `~/.config/alacritty/alacritty.yml`
- **iTerm2**: Preferences → Profiles → Text → Font
- **Kitty**: Edit `~/.config/kitty/kitty.conf`

### 2. Enable True Color Support

Add to your shell config (`~/.bashrc` or `~/.zshrc`):

```bash
# For 256 color support
export TERM=screen-256color

# Test true color
alias tmux='tmux -2'
```

### 3. Basic tmux.conf Template

If you're new to tmux, use this minimal config:

```bash
# ~/.tmux.conf

# Enable mouse
set -g mouse on

# Start numbering at 1
set -g base-index 1

# Reduce escape time
set -sg escape-time 0

# Load Maple Dark theme
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'yourusername/mapledark.tmux'

run '~/.tmux/plugins/tpm/tpm'
```

---

## Customization

After installation, customize the theme:

```bash
# ~/.tmux.conf

# Before loading the plugin, add options:
set -g @mapledark-icon-mode "ascii"         # Use ASCII icons
set -g @mapledark-show-host "0"             # Hide hostname
set -g @mapledark-time-format "%H:%M"       # Time only

# Load plugin
set -g @plugin 'yourusername/mapledark.tmux'
run '~/.tmux/plugins/tpm/tpm'
```

See [OPTIONS.md](OPTIONS.md) for all available options.

---

## Troubleshooting

### Icons Show as Boxes

**Problem:** Icons display as □ or �

**Solution:**
1. Install a Nerd Font (see above)
2. Configure terminal to use it
3. Or switch to ASCII mode: `set -g @mapledark-icon-mode "ascii"`

### Colors Look Wrong

**Problem:** Colors don't match preview

**Solution:**
1. Check terminal color support:
```bash
echo $TERM  # Should show *256color
```

2. Add to `~/.tmux.conf`:
```bash
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"
```

3. Test true color:
```bash
awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'
```

### Plugin Not Loading

**Problem:** Theme doesn't apply

**Solution:**
1. Check TPM is installed:
```bash
ls ~/.tmux/plugins/tpm
```

2. Install plugins: `prefix + I`

3. Check for errors:
```bash
tmux show-messages
```

4. Verify plugin path in tmux.conf:
```bash
set -g @plugin 'yourusername/mapledark.tmux'
```

### Keybindings Don't Work

**Problem:** `prefix + F` or `prefix + I` show "unknown command"

**Solution:**
1. Check scripts are executable:
```bash
ls -la ~/.tmux/plugins/mapledark.tmux/scripts/
```

2. Make them executable:
```bash
chmod +x ~/.tmux/plugins/mapledark.tmux/scripts/*.sh
```

3. Reload config: `prefix + R`

---

## Updating

### With TPM

```bash
# Inside tmux, press:
prefix + U

# Or manually:
cd ~/.tmux/plugins/mapledark.tmux
git pull origin main
```

### Manual Installation

```bash
cd ~/.tmux/plugins/mapledark.tmux
git pull origin main
chmod +x mapledark.tmux scripts/*.sh
tmux source-file ~/.tmux.conf
```

---

## Uninstalling

### With TPM

1. Remove from `~/.tmux.conf`:
```bash
# Delete this line:
set -g @plugin 'yourusername/mapledark.tmux'
```

2. Inside tmux: `prefix + alt + u`

3. Or manually:
```bash
rm -rf ~/.tmux/plugins/mapledark.tmux
```

### Manual Installation

```bash
# Remove from ~/.tmux.conf:
# Delete: run-shell ~/.tmux/plugins/mapledark.tmux/mapledark.tmux

# Remove files
rm -rf ~/.tmux/plugins/mapledark.tmux

# Reload config
tmux source-file ~/.tmux.conf
```

---

## Next Steps

- Read [OPTIONS.md](OPTIONS.md) for customization options
- See [example.tmux.conf](example.tmux.conf) for configuration examples
- Check [README.md](README.md) for full documentation

---

## Quick Command Reference

| Command | Description |
|---------|-------------|
| `prefix + I` | Install plugins (TPM) |
| `prefix + U` | Update plugins (TPM) |
| `prefix + alt + u` | Uninstall plugins (TPM) |

**Optional Toggle Scripts (if you bind them):**
- `toggle-focus.sh` - Toggle focus mode
- `toggle-icons.sh` - Toggle icon mode

**Default prefix:** `Ctrl + b`

**Add keybindings to your ~/.tmux.conf:**
```bash
# Example keybindings (not included by default)
bind-key F run-shell "bash ~/.tmux/plugins/mapledark.tmux/scripts/toggle-focus.sh"
bind-key I run-shell "bash ~/.tmux/plugins/mapledark.tmux/scripts/toggle-icons.sh"
```

---

## Support

- 📖 [Full Documentation](README.md)
- 🔧 [Options Reference](OPTIONS.md)
- 💡 [Configuration Examples](example.tmux.conf)
- 🐛 [Report Issues](https://github.com/yourusername/mapledark.tmux/issues)

