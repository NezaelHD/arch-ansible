# Ansible Role: JetBrains Toolbox

Installs JetBrains Toolbox for managing IDEs like PhpStorm and DataGrip.

## Requirements

None

## Role Variables

```yaml
# Enable/disable installation
jetbrains_enabled: true

# Toolbox version
jetbrains_toolbox_version: "2.1.3.18901"

# Installation directory
jetbrains_toolbox_install_dir: "~/.local/share/JetBrains/Toolbox"
```

## Dependencies

None

## Example Playbook

```yaml
- hosts: all
  become: false
  roles:
    - role: jetbrains
```

## Post-Installation

After installation:
1. Launch `jetbrains-toolbox`
2. Sign in with your JetBrains account
3. Install PhpStorm and DataGrip

## License

MIT
