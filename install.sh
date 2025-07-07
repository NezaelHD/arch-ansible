#!/bin/bash
set -e

echo "🚀 Configuration automatique d'Arch Linux"

# Vérifier qu'on est sur Arch
if ! command -v pacman &> /dev/null; then
    echo "❌ Ce script est conçu pour Arch Linux"
    exit 1
fi

# Installer Ansible si pas présent
if ! command -v ansible &> /dev/null; then
    echo "📦 Installation d'Ansible..."
    sudo pacman -Sy --noconfirm ansible
fi

# Installer git si pas présent
if ! command -v git &> /dev/null; then
    echo "📦 Installation de Git..."
    sudo pacman -S --noconfirm git
fi

# Lancer le playbook
echo "🎯 Lancement de la configuration..."
ansible-playbook -i inventory.yml playbook.yml --ask-become-pass

echo "✅ Configuration terminée ! Redémarre ton système."