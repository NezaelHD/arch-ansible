# 🚀 Quick Start Guide

Get your Arch Linux development workstation running in 10 minutes.

---

## ⚡ Prerequisites (2 minutes)

```bash
# Update system
sudo pacman -Syu

# Install Ansible
sudo pacman -S ansible git python
```

---

## 📦 Installation (5 minutes setup)

### 1. Clone Repository
```bash
cd ~/
git clone <your-repo-url> webdev-install-playbook
cd webdev-install-playbook
```

### 2. Install Ansible Collections
```bash
ansible-galaxy install -r requirements.yml
```

### 3. Optional Configuration

**All features are ENABLED by default.** Only edit if you want to change something.

```bash
nano config.yml
```

Common changes:
```yaml
# GPU Configuration
gpu_type: "amd"      # Options: "amd", "nvidia", "none"

# Change Docker user (automatic by default)
docker_users:
  - your_username

# Enable dotfiles (optional)
install_dotfiles: true
dotfiles_repo: "https://github.com/you/dotfiles.git"
```

### 4. Run Installation (80-90 minutes automated)
```bash
ansible-playbook -i inventory main.yml -K
# Enter your sudo password when prompted
```

### 5. Reboot
```bash
sudo reboot
```

---

## 🎮 First Steps with Niri

### Start Niri
After reboot, from a TTY (Ctrl+Alt+F2):
```bash
niri
```

Or select "Niri" in your display manager.

### Essential Shortcuts

| Shortcut | Action |
|----------|--------|
| `Mod+Return` | Terminal |
| `Mod+D` | Launcher |
| `Mod+Q` | Close window |

**Mod** = Super/Windows key

### Launch Your Tools

Press `Mod+D` and type:
- `jetbrains` → JetBrains Toolbox
- `brave` → Browser
- `slack` → Slack
- `teams` → Teams
- `yaak` → API client

---

## ⚙️ Post-Installation (5 minutes)

### 1. Install PhpStorm & DataGrip
```bash
# Launch Toolbox
jetbrains-toolbox

# Or from launcher: Mod+D → "jetbrains"
```

Then in Toolbox:
1. Sign in with JetBrains account
2. Click "Install" on PhpStorm
3. Click "Install" on DataGrip

### 2. Test Docker
```bash
docker ps
# Should work without sudo

# If permission error:
newgrp docker
# Or reboot
```

### 3. Customize Niri (Optional)
```bash
nano ~/.config/niri/config.kdl
# Change keyboard layout, gaps, shortcuts, etc.
```

---

## 🎯 Quick Reference

### Installation Options

```bash
# Full installation (everything)
ansible-playbook -i inventory main.yml -K

# Minimal (base + Niri only)
ansible-playbook -i inventory main.yml -K --tags "base,niri"

# Skip communication apps
ansible-playbook -i inventory main.yml -K --skip-tags "communication"
```

### Niri Config
- **Location**: `~/.config/niri/config.kdl`
- **Reload**: `Mod+Shift+R`

### Useful Commands
```bash
# Update all packages
yay -Syu

# Launch Toolbox
jetbrains-toolbox

# Check Docker
docker ps

# System monitor
btop
```

---

## 🆘 Quick Fixes

### Niri won't start
```bash
RUST_LOG=debug niri
```

### Docker permission denied
```bash
newgrp docker
```

### App missing in launcher
```bash
update-desktop-database ~/.local/share/applications/
```

---

## 📚 Next Steps

1. ✅ Read [SETUP.md](SETUP.md) for detailed configuration
2. ✅ Customize Niri shortcuts and appearance
3. ✅ Install PHP Storm extensions
4. ✅ Configure Brave browser
5. ✅ Set up your projects

---

**Total Time**: ~100 minutes (10 min setup + 90 min automated)

See [SETUP.md](SETUP.md) for detailed documentation.
