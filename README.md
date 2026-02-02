# 🎨 Arch Linux Development Workstation

Automated setup for Arch Linux with Niri Wayland compositor and complete development environment.

[![Ansible](https://img.shields.io/badge/Ansible-2.17+-blue.svg)](https://www.ansible.com/)
[![Arch Linux](https://img.shields.io/badge/Arch%20Linux-rolling-blue.svg)](https://archlinux.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 🎯 What This Installs

**Everything is ENABLED by default.** You can disable components in `config.yml`.

### 🎨 Desktop Environment (Niri + Wayland)
- **Niri** - Modern Wayland compositor with tiling layout
- **Alacritty** - GPU-accelerated terminal
- **Waybar** - Customizable status bar
- **Fuzzel** - Fast application launcher
- **Mako** - Notification daemon
- **Nautilus** - File manager

### 🛠️ Development Tools
- **JetBrains Toolbox** - Manage PhpStorm & DataGrip
- **Docker + Docker Compose** - Containerization
- **Yaak** - Modern API client (Postman alternative)
- **Freeze** - Beautiful code screenshots
- **Languages**: Python, Node.js, Rust, Go, Java
- **VSCode** - Code editor

### 🌐 Browsers
- **Brave** - Privacy-focused (set as default)
- **Firefox** - Alternative browser

### 💬 Communication
- **Slack Desktop** - Team communication
- **Teams for Linux** - Microsoft Teams client

### 📊 System Tools
- **htop/btop** - System monitoring
- **Git** - Version control
- **Docker** - Containerization
- **Various CLI tools** - See full list in `config.yml`

---

## 🚀 Quick Start

See [QUICKSTART.md](QUICKSTART.md) for 5-minute setup guide.

### Installation (10 minutes of your time, 90 minutes automated)

```bash
# 1. Prerequisites
sudo pacman -Syu
sudo pacman -S ansible git python

# 2. Clone and install
git clone <your-repo-url>
cd webdev-install-playbook
ansible-galaxy install -r requirements.yml

# 3. Optional: Edit config.yml (or use defaults)
nano config.yml

# 4. Run installation
ansible-playbook -i inventory main.yml -K

# 5. Reboot and launch Niri
sudo reboot
# Then: niri
```

---

## ⚙️ Configuration

All settings are in `config.yml` with **everything enabled by default**.

### Quick Customization

```yaml
# GPU Configuration
gpu_type: "amd"              # Options: "amd", "nvidia", "none"

# Disable components you don't want
install_niri: false          # Use GNOME instead
install_jetbrains: false     # Skip JetBrains Toolbox
install_docker: false        # Skip Docker

# Change Docker user
docker_users:
  - your_username            # ⚠️ Change this

# Enable dotfiles (optional)
install_dotfiles: true
dotfiles_repo: "https://github.com/you/dotfiles.git"
```

---

## 📋 Installation Options

### Full Installation (Everything)
```bash
ansible-playbook -i inventory main.yml -K
```

### Selective Installation
```bash
# Base system + Niri only
ansible-playbook -i inventory main.yml -K --tags "base,niri"

# Dev environment without desktop
ansible-playbook -i inventory main.yml -K --tags "base,dev,docker,jetbrains"

# Skip communication apps
ansible-playbook -i inventory main.yml -K --skip-tags "communication"
```

### Available Tags

| Tag | Components |
|-----|-----------|
| `base` | System base packages |
| `niri` | Niri Wayland environment |
| `gpu` | GPU drivers (AMD or NVIDIA based on config) |
| `amd` | AMD GPU drivers only |
| `nvidia` | NVIDIA GPU drivers only |
| `dev` | Development tools |
| `docker` | Docker + Compose |
| `jetbrains` | JetBrains Toolbox |
| `browser` | Brave + Firefox |
| `communication` | Slack + Teams |
| `apps` | Other applications |

---

## 🎮 Using Niri

### Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Mod+Return` | Open terminal |
| `Mod+D` | Launch apps |
| `Mod+Q` | Close window |
| `Mod+H/L` | Switch columns |
| `Mod+J/K` | Switch windows |
| `Print` | Screenshot |

**Mod** = Super/Windows key

### Launch Applications

Press `Mod+D` then type:
- `jetbrains` - JetBrains Toolbox
- `phpstorm` - PhpStorm (after Toolbox install)
- `datagrip` - DataGrip (after Toolbox install)
- `brave` - Brave browser
- `yaak` - API client
- `slack` - Slack
- `teams` - Teams

---

## 📚 Documentation

- **[QUICKSTART.md](QUICKSTART.md)** - 5-minute setup guide
- **[SETUP.md](SETUP.md)** - Detailed configuration and troubleshooting
- **[docs/GPU_SETUP.md](docs/GPU_SETUP.md)** - AMD & NVIDIA GPU configuration guide
- **config.yml** - All configuration options with comments

---

## 🛠️ Post-Installation

### 1. JetBrains Toolbox
```bash
jetbrains-toolbox  # Launch and install PhpStorm/DataGrip
```

### 2. Docker
```bash
docker ps  # Test - should work without sudo
```

### 3. Customize Niri
```bash
nano ~/.config/niri/config.kdl  # Edit configuration
# Reload: Mod+Shift+R
```

---

## 🔧 Troubleshooting

### Niri won't start
```bash
RUST_LOG=debug niri  # Check errors
```

### Docker permission denied
```bash
newgrp docker  # Or reboot
```

### Missing applications in launcher
```bash
update-desktop-database ~/.local/share/applications/
```

See [SETUP.md](SETUP.md) for complete troubleshooting guide.

---

## 📊 Project Structure

```
webdev-install-playbook/
├── main.yml              # Main playbook (use this)
├── config.yml            # Configuration (edit this)
├── inventory             # Target hosts
├── requirements.yml      # Ansible collections
│
├── roles/                # Ansible roles
│   ├── niri/            # Niri Wayland environment
│   ├── jetbrains/       # JetBrains Toolbox
│   ├── docker/          # Docker setup
│   ├── dotfiles/        # Dotfiles management
│   └── git/             # Git from source (optional)
│
├── tasks/                # Task files
│   ├── swap.yml
│   ├── chaotic-aur.yml
│   ├── brave-browser.yml
│   └── ...
│
└── docs/
    ├── README.md         # This file
    ├── QUICKSTART.md     # Quick setup
    └── SETUP.md          # Detailed guide
```

---

## 🎯 Why This Setup?

### Niri Benefits
✅ **Lightweight** - ~100MB RAM vs 1-2GB for GNOME
✅ **Fast** - Pure Wayland, GPU-accelerated
✅ **Productive** - Keyboard-driven workflow
✅ **Modern** - Written in Rust, simple config
✅ **Secure** - Wayland app isolation

### Professional Tools
✅ **PhpStorm** - Best PHP/Laravel IDE
✅ **DataGrip** - Best database tool
✅ **Yaak** - Fast, modern API client
✅ **Brave** - Privacy by default
✅ **Docker** - Industry standard

---

## 🤝 Contributing

1. Fork the project
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

---

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

---

## 🙏 Credits

- [YaLTeR](https://github.com/YaLTeR) - Niri compositor
- [Jeff Geerling](https://github.com/geerlingguy) - Ansible roles
- [kewlfft](https://github.com/kewlfft) - AUR Ansible collection
- Arch Linux community

---

## 🔗 Resources

- [Niri Documentation](https://github.com/YaLTeR/niri/wiki)
- [Arch Linux Wiki](https://wiki.archlinux.org/)
- [Ansible Documentation](https://docs.ansible.com/)

---

<div align="center">
  <strong>🎨 Modern Development Environment for Arch Linux</strong>
  <br>
  <em>Productive · Elegant · Fast</em>
</div>
