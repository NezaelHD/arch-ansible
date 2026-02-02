# Ansible Role: Niri

Installs and configures Niri Wayland compositor with a complete desktop environment.

## Requirements

- Arch Linux
- Yay AUR helper (installed via chaotic-aur)

## Role Variables

```yaml
# Enable/disable Niri installation
niri_enabled: true

# Keyboard layout
niri_keyboard_layout: "fr"

# Window gaps
niri_gaps: 8

# Create default configs
niri_create_default_config: true
niri_create_waybar_config: true
niri_create_fuzzel_config: true
niri_create_mako_config: true
```

## Dependencies

None

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: niri
      niri_keyboard_layout: "us"
      niri_gaps: 12
```

## License

MIT
