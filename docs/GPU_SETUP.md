# GPU Configuration Guide

This guide covers GPU driver installation for both AMD and NVIDIA graphics cards.

---

## 🎮 GPU Type Selection

Edit `config.yml`:

```yaml
# Options: "amd", "nvidia", "none"
gpu_type: "amd"  # Change to "nvidia" for NVIDIA cards
```

### Options

| Value | Use Case |
|-------|----------|
| `"amd"` | AMD Radeon graphics cards |
| `"nvidia"` | NVIDIA GeForce/Quadro cards |
| `"none"` | Intel integrated graphics or no dedicated GPU |

---

## 🔴 AMD Configuration

### Drivers Installed

```
- mesa                      # Open-source AMD drivers
- lib32-mesa               # 32-bit support
- xf86-video-amdgpu        # Xorg driver
- vulkan-radeon            # Vulkan support
- lib32-vulkan-radeon      # 32-bit Vulkan
- amdvlk                   # AMD Vulkan driver
- lib32-amdvlk             # 32-bit AMDVLK
- libva-mesa-driver        # VA-API acceleration
- lib32-libva-mesa-driver  # 32-bit VA-API
- mesa-vdpau               # VDPAU acceleration
- lib32-mesa-vdpau         # 32-bit VDPAU
```

### Configuration

```yaml
gpu_type: "amd"
```

### Verification

```bash
# Check driver
lspci -k | grep -A 3 VGA

# Check Vulkan
vulkaninfo | grep "deviceName"

# Monitor GPU
radeontop
```

### Performance Tuning

```bash
# Check current power profile
cat /sys/class/drm/card0/device/power_dpm_force_performance_level

# Set to high performance (temporary)
echo "high" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
```

---

## 🟢 NVIDIA Configuration

### Drivers Installed

```
- nvidia                    # Proprietary NVIDIA drivers
- nvidia-utils             # NVIDIA utilities
- lib32-nvidia-utils       # 32-bit support
- nvidia-settings          # Control panel
- opencl-nvidia            # OpenCL support
- libvdpau                 # Video acceleration
- libva-nvidia-driver      # VA-API support
- vulkan-icd-loader        # Vulkan support
- lib32-vulkan-icd-loader  # 32-bit Vulkan
- egl-wayland              # Wayland EGL support
```

### Configuration

```yaml
gpu_type: "nvidia"
```

### Additional Setup

The playbook automatically:
1. Enables `nvidia-drm modeset=1` for Wayland
2. Adds NVIDIA modules to initramfs
3. Configures Xorg (if enabled)

### Wayland/Niri Setup

For NVIDIA with Niri, environment variables are automatically set:

```bash
# Already configured by the playbook
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export GBM_BACKEND=nvidia-drm
```

### Verification

```bash
# Check NVIDIA driver
nvidia-smi

# Check loaded modules
lsmod | grep nvidia

# Monitor GPU
nvidia-smi -l 1  # Update every second
```

### NVIDIA Control Panel

```bash
# Launch (requires X11)
nvidia-settings
```

### Performance Modes

```bash
# Check current mode
nvidia-smi -q -d PERFORMANCE

# Set power limit (example: 200W)
sudo nvidia-smi -pl 200
```

---

## 🔧 Troubleshooting

### AMD Issues

#### Black screen after installation

```bash
# Boot with nomodeset
# Add to kernel parameters: nomodeset

# Then reinstall drivers
sudo pacman -S mesa xf86-video-amdgpu
```

#### Poor performance

```bash
# Check if correct driver is loaded
lspci -k | grep -A 3 VGA

# Should show: Kernel driver in use: amdgpu
```

#### Tearing issues

Edit `/etc/X11/xorg.conf.d/20-amdgpu.conf`:
```
Section "Device"
    Identifier "AMD"
    Driver "amdgpu"
    Option "TearFree" "true"
EndSection
```

### NVIDIA Issues

#### Black screen after installation

```bash
# Boot to TTY (Ctrl+Alt+F2)
# Remove nvidia-drm modeset
sudo nano /etc/modprobe.d/nvidia.conf
# Comment out: options nvidia-drm modeset=1

# Regenerate initramfs
sudo mkinitcpio -P

# Reboot
sudo reboot
```

#### Wayland/Niri not working

```bash
# Check if nvidia-drm modeset is enabled
cat /sys/module/nvidia_drm/parameters/modeset
# Should show: Y

# If not, add to kernel parameters:
# nvidia-drm.modeset=1
```

#### Screen flickering

Add to `/etc/modprobe.d/nvidia.conf`:
```
options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1;PerfLevelSrc=0x2222"
```

#### NVIDIA + Wayland performance issues

Ensure these environment variables are set (automatic in playbook):
```bash
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export GBM_BACKEND=nvidia-drm
export __GL_GSYNC_ALLOWED=1
export __GL_VRR_ALLOWED=1
```

---

## 🎮 Gaming Setup

### AMD Gaming

```bash
# Install gaming packages
yay -S gamemode lib32-gamemode

# For Vulkan games
yay -S mangohud lib32-mangohud
```

### NVIDIA Gaming

```bash
# Install gaming packages
yay -S gamemode lib32-gamemode

# NVIDIA-specific
yay -S nvidia-prime  # For laptops with dual GPU
```

---

## 🔄 Switching GPUs

### Change GPU Type

Edit `config.yml`:
```yaml
gpu_type: "nvidia"  # Was "amd"
```

Run playbook:
```bash
ansible-playbook -i inventory main.yml -K --tags gpu
```

### Dual GPU Systems (Laptops)

For laptops with both Intel + NVIDIA:

```yaml
gpu_type: "nvidia"  # Install NVIDIA drivers
```

Then configure prime:
```bash
# Install optimus-manager
yay -S optimus-manager optimus-manager-qt

# Switch to NVIDIA
optimus-manager --switch nvidia

# Switch to Intel
optimus-manager --switch intel
```

---

## 📊 Monitoring

### AMD Monitoring

```bash
# GPU usage
radeontop

# Detailed info
sudo watch -n 1 'cat /sys/class/drm/card0/device/gpu_busy_percent'

# Temperature
sensors
```

### NVIDIA Monitoring

```bash
# GPU usage
nvidia-smi

# Continuous monitoring
nvidia-smi -l 1

# Detailed info
nvidia-smi -q

# Temperature
nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader
```

---

## 🔗 Resources

### AMD
- [Arch Wiki - AMD](https://wiki.archlinux.org/title/AMDGPU)
- [Arch Wiki - Vulkan](https://wiki.archlinux.org/title/Vulkan)

### NVIDIA
- [Arch Wiki - NVIDIA](https://wiki.archlinux.org/title/NVIDIA)
- [NVIDIA Driver Documentation](https://us.download.nvidia.com/XFree86/Linux-x86_64/latest/README/)
- [NVIDIA Wayland](https://wiki.archlinux.org/title/Wayland#NVIDIA)

---

**Note**: After GPU driver installation, **reboot is required** for changes to take effect.
