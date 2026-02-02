# 📚 Setup Guide

Complete guide for configuring and using your Arch Linux development workstation.

---

## 📋 Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [GPU Configuration](#gpu-configuration)
4. [Niri Usage](#niri-usage)
5. [Applications](#applications)
6. [Customization](#customization)
7. [Troubleshooting](#troubleshooting)

---

## 🔧 Installation

### Prerequisites

```bash
sudo pacman -Syu
sudo pacman -S ansible git python
```

### Steps

```bash
# 1. Clone
git clone <your-repo-url> webdev-install-playbook
cd webdev-install-playbook

# 2. Install collections
ansible-galaxy install -r requirements.yml

# 3. Edit config (optional - everything enabled by default)
nano config.yml

# 4. Run
ansible-playbook -i inventory main.yml -K

# 5. Reboot
sudo reboot
```

### Installation Options

```bash
# Full (everything)
ansible-playbook -i inventory main.yml -K

# Test without applying
ansible-playbook -i inventory main.yml -K --check --diff

# Selective installation
ansible-playbook -i inventory main.yml -K --tags "base,niri,dev"

# Skip specific components
ansible-playbook -i inventory main.yml -K --skip-tags "communication"
```

### Available Tags

| Tag | Components |
|-----|-----------|
| `base` | Base system packages |
| `niri` | Niri Wayland compositor + apps |
| `dev` | Development tools (Python, Node, Rust, Go) |
| `docker` | Docker + Docker Compose |
| `jetbrains` | JetBrains Toolbox |
| `browser` | Brave + Firefox |
| `communication` | Slack + Teams |
| `apps` | Other applications |
| `fonts` | All fonts |
| `gpu` | GPU drivers (auto-detected from config) |
| `amd` | AMD GPU drivers specifically |
| `nvidia` | NVIDIA GPU drivers specifically |

---

## ⚙️ Configuration

### config.yml Structure

```yaml
# ============================================
# GPU Configuration
# ============================================
gpu_type: "amd"              # Options: "amd", "nvidia", "none"

# ============================================
# Enable/Disable Components
# ============================================
install_niri: true           # Niri compositor
install_docker: true         # Docker
install_jetbrains: true      # JetBrains Toolbox
install_dotfiles: false      # Dotfiles (optional)

# ============================================
# Docker
# ============================================
docker_users:
  - "{{ ansible_user_id }}"  # Auto-detected user

docker_daemon_options:
  storage-driver: "overlay2"
  log-opts:
    max-size: "10m"

# ============================================
# Niri
# ============================================
niri_keyboard_layout: "fr"   # Keyboard layout
niri_gaps: 8                 # Window gaps in pixels

# ============================================
# Dotfiles (Optional)
# ============================================
dotfiles_repo: "https://github.com/you/dotfiles.git"
dotfiles_files:
  - .bashrc
  - .zshrc
  - .gitconfig
```

### Disabling Components

```yaml
# Example: Minimal dev environment (no desktop)
install_niri: false
install_gnome: false
install_xorg: false
install_jetbrains: false
communication_apps: []  # Empty list
```

---

## 🎮 GPU Configuration

### Quick Setup

Edit `config.yml`:
```yaml
gpu_type: "amd"     # For AMD Radeon
# OR
gpu_type: "nvidia"  # For NVIDIA GeForce/Quadro
# OR
gpu_type: "none"    # For Intel integrated or no GPU
```

### GPU-Specific Installation

```bash
# Install AMD drivers only
ansible-playbook -i inventory main.yml -K --tags amd

# Install NVIDIA drivers only
ansible-playbook -i inventory main.yml -K --tags nvidia

# Skip GPU drivers entirely
ansible-playbook -i inventory main.yml -K --skip-tags gpu
```

### What Gets Installed

**AMD (Open Source):**
- Mesa drivers
- AMDGPU kernel driver
- Vulkan support
- VA-API & VDPAU acceleration

**NVIDIA (Proprietary):**
- NVIDIA proprietary drivers
- CUDA support
- Vulkan support
- Wayland EGL support
- nvidia-drm modeset enabled

### Verification

```bash
# AMD
lspci -k | grep -A 3 VGA
radeontop

# NVIDIA
nvidia-smi
```

### Detailed Guide

See **[docs/GPU_SETUP.md](docs/GPU_SETUP.md)** for:
- Detailed driver information
- Performance tuning
- Troubleshooting
- Gaming setup
- Dual GPU configuration
- Monitoring tools

---

## 🎮 Niri Usage

### Starting Niri

**From TTY:**
```bash
niri
```

**From Display Manager:**
Select "Niri" in the session menu.

### Keyboard Shortcuts

#### Essential

| Shortcut | Action |
|----------|--------|
| `Mod+Return` | Open terminal (Alacritty) |
| `Mod+D` | Application launcher (Fuzzel) |
| `Mod+Q` | Close window |
| `Mod+Shift+E` | Exit Niri |

#### Navigation

| Shortcut | Action |
|----------|--------|
| `Mod+H` | Focus left column |
| `Mod+L` | Focus right column |
| `Mod+J` | Focus down |
| `Mod+K` | Focus up |

#### Window Management

| Shortcut | Action |
|----------|--------|
| `Mod+Shift+H/L` | Move column |
| `Mod+Shift+J/K` | Move window |
| `Mod+F` | Maximize column |
| `Mod+Shift+F` | Fullscreen |

#### Screenshots

| Shortcut | Action |
|----------|--------|
| `Print` | Screenshot (select area) |

**Mod** = Super/Windows key

### Configuration

**Location:** `~/.config/niri/config.kdl`

**Reload:** `Mod+Shift+R` or restart Niri

#### Common Customizations

```kdl
// Change gaps
layout {
    gaps 16
}

// Add custom shortcuts
binds {
    Mod+B { spawn "brave"; }
    Mod+P { spawn "phpstorm"; }
}

// Change wallpaper
spawn-at-startup "sway-bg" "-i" "/path/to/image.jpg" "-m" "fill"

// Keyboard layout
input {
    keyboard {
        xkb {
            layout "us"  // or "fr", "de", etc.
        }
    }
}
```

---

## 📱 Applications

### Development

#### JetBrains Toolbox

```bash
# Launch
jetbrains-toolbox
# Or: Mod+D → "jetbrains"
```

**First time:**
1. Sign in with JetBrains account
2. Install PhpStorm
3. Install DataGrip

**IDEs location:** `~/.local/share/JetBrains/Toolbox/apps/`

#### Docker

```bash
# Test
docker ps

# If permission error
newgrp docker
# Or reboot

# Docker Compose
docker-compose up -d
```

#### Yaak (API Client)

```bash
yaak
# Or: Mod+D → "yaak"
```

Alternative to Postman/Insomnia.

#### Code Screenshots (Freeze)

```bash
freeze myfile.php -o screenshot.png
```

Creates beautiful code screenshots with syntax highlighting.

### Browsers

#### Brave (Default)

```bash
brave
# Or: Mod+D → "brave"
```

Already set as default browser for all HTTP/HTTPS links.

**Verify:**
```bash
xdg-settings get default-web-browser
# Should show: brave-browser.desktop
```

#### Firefox

```bash
firefox
# Or: Mod+D → "firefox"
```

### Communication

#### Slack

```bash
slack
# Or: Mod+D → "slack"
```

#### Teams for Linux

```bash
teams-for-linux
# Or: Mod+D → "teams"
```

Non-official but functional Microsoft Teams client.

### System Tools

#### Monitoring

```bash
# Modern system monitor
btop

# Classic
htop
```

#### File Manager

```bash
nautilus
# Or: Mod+D → "nautilus"
```

---

## 🎨 Customization

### Waybar (Status Bar)

**Config:** `~/.config/waybar/config`
**Style:** `~/.config/waybar/style.css`

```json
{
    "modules-left": ["clock"],
    "modules-right": ["network", "battery", "pulseaudio"],
    "clock": {
        "format": "{:%H:%M - %d/%m/%Y}"
    }
}
```

### Fuzzel (Launcher)

**Config:** `~/.config/fuzzel/fuzzel.ini`

```ini
[main]
terminal=alacritty
font=JetBrains Mono:size=12

[colors]
background=1e1e2eff
text=cdd6f4ff
```

### Alacritty (Terminal)

**Config:** `~/.config/alacritty/alacritty.yml`

```yaml
font:
  normal:
    family: JetBrains Mono
  size: 12

colors:
  primary:
    background: '#1e1e2e'
    foreground: '#cdd6f4'
```

### Mako (Notifications)

**Config:** `~/.config/mako/config`

```ini
background-color=#1e1e2e
text-color=#cdd6f4
border-color=#b4befe
default-timeout=5000
```

---

## 🔧 Troubleshooting

### Niri Issues

#### Niri won't start

```bash
# Check logs
RUST_LOG=debug niri

# Validate config
niri validate

# Check system logs
journalctl -xe
```

#### Waybar not showing

```bash
# Restart Waybar
killall waybar
waybar &

# Check for errors
waybar -l debug
```

#### Fuzzel not working

```bash
# Rebuild database
update-desktop-database ~/.local/share/applications/

# Test manually
fuzzel
```

### Docker Issues

#### Permission denied

```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Apply changes
newgrp docker

# Or reboot
sudo reboot

# Verify
groups
# Should include 'docker'
```

#### Docker service not running

```bash
# Start Docker
sudo systemctl start docker

# Enable at boot
sudo systemctl enable docker

# Check status
sudo systemctl status docker
```

### JetBrains Issues

#### Toolbox won't launch

```bash
# Check installation
ls -la ~/.local/share/JetBrains/Toolbox/bin/

# Reinstall
ansible-playbook -i inventory main.yml -K --tags jetbrains
```

#### IDEs not appearing in launcher

```bash
# Update desktop database
update-desktop-database ~/.local/share/applications/
update-desktop-database ~/.local/share/JetBrains/Toolbox/apps/
```

### Browser Issues

#### Brave not default

```bash
# Set manually
xdg-settings set default-web-browser brave-browser.desktop

# Verify
xdg-settings get default-web-browser
```

### Package Issues

#### AUR package fails

```bash
# Update yay
yay -Syu yay

# Clear cache
yay -Sc

# Retry installation
yay -S package-name
```

#### Missing dependencies

```bash
# Update system
sudo pacman -Syu

# Reinstall base-devel
sudo pacman -S base-devel
```

### General Issues

#### Keyboard layout wrong

Edit `~/.config/niri/config.kdl`:
```kdl
input {
    keyboard {
        xkb {
            layout "us"  // Change to your layout
        }
    }
}
```

#### High DPI scaling

Edit `~/.config/niri/config.kdl`:
```kdl
output {
    scale 1.5  // or 2.0
}
```

---

## 🔄 Maintenance

### Update System

```bash
# Update all packages
yay -Syu

# Or via Ansible
ansible-playbook -i inventory main.yml -K --tags upgrade
```

### Update Collections

```bash
ansible-galaxy collection install -r requirements.yml --force --upgrade
```

### Backup Configuration

```bash
# Backup Niri config
cp -r ~/.config/niri ~/backup/

# Backup Waybar config
cp -r ~/.config/waybar ~/backup/

# Backup full config
tar -czf config-backup.tar.gz ~/.config/{niri,waybar,alacritty,fuzzel,mako}
```

---

## 📊 Performance Tips

### Niri Performance

```kdl
// Reduce animations
layout {
    animations {
        off
    }
}
```

### Docker Performance

```yaml
# In config.yml
docker_daemon_options:
  storage-driver: "overlay2"
  log-opts:
    max-size: "10m"
    max-file: "3"
```

### System Monitoring

```bash
# Check resource usage
btop

# Check specific process
htop

# Check GPU usage (AMD)
radeontop
```

---

## 🔗 Additional Resources

- [Niri Wiki](https://github.com/YaLTeR/niri/wiki)
- [Arch Wiki](https://wiki.archlinux.org/)
- [Waybar Documentation](https://github.com/Alexays/Waybar/wiki)
- [Alacritty Config](https://github.com/alacritty/alacritty/blob/master/alacritty.yml)

---

## 🆘 Getting Help

1. Check this guide
2. Check Ansible logs: last playbook run output
3. Check system logs: `journalctl -xe`
4. Check Niri logs: `RUST_LOG=debug niri`
5. Arch Wiki for package-specific issues

---

**Last Updated:** 2026-02-02
**Version:** 1.0
