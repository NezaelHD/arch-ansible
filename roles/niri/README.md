# Ansible Role: Niri

Installs and configures Niri Wayland compositor with a complete desktop environment including Waybar, Fuzzel, Mako, and other essential Wayland tools.

## Requirements

- Arch Linux
- Yay AUR helper (installed via chaotic-aur)

## Role Variables

Available variables with their default values (see `defaults/main.yml`):

```yaml
# Niri and Wayland packages to install
niri_packages:
  - niri
  - wayland
  - wayland-protocols
  - xorg-xwayland
  - alacritty
  - waybar
  - fuzzel
  - mako
  - swaylock
  - sway-bg
  - swayidle
  - swaync
  - plasma-polkit-agent
  - nautilus
  - xdg-desktop-portal-gtk
  - xdg-desktop-portal-gnome
  - gnome-keyring
  - grim
  - slurp
  - wl-clipboard

# Control creation of default configuration files
# Set to false to skip creating specific configs
niri_create_default_config: true
niri_create_waybar_config: true
niri_create_fuzzel_config: true
niri_create_mako_config: true

# Niri configuration options
niri_keyboard_layout: "fr"  # XKB keyboard layout
niri_gaps: 8                 # Window gaps in pixels
niri_mod_key: "Mod"          # Modifier key (Super/Windows key)

# Applications to start automatically with Niri
niri_autostart:
  - waybar
  - mako
  - "sway-bg -i ~/.config/niri/wallpaper.jpg -m fill"
  - swayidle
  - swaync
```

## Features

This role will:

1. Install Niri compositor and all required Wayland packages
2. Create a complete Niri configuration file based on the official default config
3. Configure Waybar (status bar) with a default configuration
4. Configure Fuzzel (application launcher) with Catppuccin-inspired colors
5. Configure Mako (notification daemon) with matching colors
6. Set up all necessary XDG desktop portals for screen sharing and file dialogs

All configuration files are only created if they don't already exist, preserving any manual customizations.

## Configuration Template

The Niri configuration is generated from a Jinja2 template (`templates/config.kdl.j2`) based on the official Niri default config. It includes:

- Full keybinding set with customizable mod key
- Media keys support (volume, brightness, playback)
- Screenshot capabilities
- Workspace management
- Window tiling and floating modes
- All default Niri features

## Dependencies

None. This role can be used standalone.

## Example Playbook

Basic usage:

```yaml
- hosts: all
  roles:
    - role: niri
```

Custom configuration:

```yaml
- hosts: all
  roles:
    - role: niri
      niri_keyboard_layout: "us"
      niri_gaps: 12
      niri_autostart:
        - waybar
        - mako
        - "nm-applet --indicator"
```

Skip creating certain configs:

```yaml
- hosts: all
  roles:
    - role: niri
      niri_create_waybar_config: false  # Use your own Waybar config
      niri_create_mako_config: false    # Use your own Mako config
```

## Post-Installation

After running this role:

1. Reboot your system
2. Start Niri from TTY by typing `niri` or select it from your display manager
3. Use these default keybindings:
   - `Mod+Return` or `Mod+T` - Open terminal (Alacritty)
   - `Mod+D` - Application launcher (Fuzzel)
   - `Mod+Q` - Close window
   - `Print` - Take screenshot
   - `Mod+Shift+E` - Quit Niri

Configuration files are located at:
- `~/.config/niri/config.kdl` - Main Niri configuration
- `~/.config/waybar/config` - Waybar configuration
- `~/.config/fuzzel/fuzzel.ini` - Fuzzel configuration
- `~/.config/mako/config` - Mako configuration

## License

MIT
