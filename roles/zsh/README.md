# Zsh Role

Ansible role to install and configure zsh with oh-my-zsh framework and powerlevel10k theme.

## Description

This role:
- Installs zsh shell
- Installs oh-my-zsh framework
- Installs powerlevel10k theme
- Sets zsh as the default shell for the user
- Handles idempotency (won't reinstall if already present)

## Requirements

- Arch Linux
- Internet connection (to download oh-my-zsh and powerlevel10k)
- `git` package installed (included in base_packages)
- `curl` available (typically installed by default)

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

```yaml
# Zsh package name
zsh_package_name: zsh

# Oh-My-Zsh installation
zsh_install_ohmyzsh: true
zsh_ohmyzsh_install_script: https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
zsh_ohmyzsh_dir: "{{ ansible_env.HOME }}/.oh-my-zsh"

# Powerlevel10k theme
zsh_install_powerlevel10k: true
zsh_powerlevel10k_repo: https://github.com/romkatv/powerlevel10k.git
zsh_powerlevel10k_dir: "{{ zsh_ohmyzsh_dir }}/custom/themes/powerlevel10k"

# Set zsh as default shell
zsh_set_default_shell: true

# User for whom to configure zsh
zsh_user: "{{ ansible_user_id }}"
```

## Dependencies

None.

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: zsh
      become: false
```

With custom variables:

```yaml
- hosts: all
  roles:
    - role: zsh
      become: false
      vars:
        zsh_set_default_shell: false
        zsh_install_powerlevel10k: false
```

## Configuration Files

This role installs zsh and oh-my-zsh but **does not manage configuration files** (.zshrc, .p10k.zsh).

Configuration files should be managed by the `dotfiles` role:

1. Add your `.zshrc` and `.p10k.zsh` to your dotfiles repository
2. Update `config.yml`:
   ```yaml
   dotfiles_files:
     - .zshrc
     - .p10k.zsh
   ```
3. Enable the dotfiles role: `install_dotfiles: true`

### Example .zshrc for powerlevel10k

```bash
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme to powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git docker sudo)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
```

## Idempotency

This role is fully idempotent:
- Oh-my-zsh won't be reinstalled if `~/.oh-my-zsh` exists
- Powerlevel10k won't be recloned if already present
- Default shell won't be changed if already set to zsh

## Post-Installation

After running this role:

1. **Log out and log back in** for the shell change to take effect
2. Run `p10k configure` to customize your powerlevel10k prompt (optional)
3. Install a Nerd Font for proper icon display (e.g., JetBrains Mono Nerd Font)
4. Configure your terminal emulator to use the Nerd Font

## Tags

- `zsh` - Run all zsh tasks
- `shell` - Shell-related tasks
- `terminal` - Terminal configuration tasks

## License

MIT

## Author Information

Created for Arch Linux development workstation setup.
