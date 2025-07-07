# Arch Automation - Configuration complète et automatisée d’un environnement Arch Linux

Ce projet Ansible permet d’installer et configurer automatiquement un environnement Arch Linux moderne, minimaliste et prêt pour le développement, le gaming, et la personnalisation avancée.

## 📦 Fonctionnalités

- Installation des paquets de base et de yay (AUR)
- Shell zsh + oh-my-zsh
- Environnement graphique Wayland (niri, waybar, alacritty, rofi)
- Drivers propriétaires Nvidia et configuration pour Wayland
- Gaming (Steam, Lutris, MangoHud, ProtonUp-Qt, Heroic, etc.)
- Outils de développement (PhpStorm, Beekeeper Studio, Docker, Brave)
- Prise en charge future des dotfiles personnalisés

## 🚀 Utilisation

### 1. Pré-requis

- Arch Linux fraîchement installé (avec accès root/sudo)
- Connexion internet active

### 2. Cloner ce dépôt

```bash
git clone https://github.com/ton-utilisateur/arch-automation.git
cd arch-automation
```

### 3. Lancer le script d’installation

```bash
chmod +x install.sh
./install.sh
```

Le script va :

- Installer Ansible et git si besoin
- Lancer le playbook principal

### 4. Redémarrer

Une fois le playbook terminé, redémarre la machine pour que tous les services et drivers soient bien pris en compte.

## 🛠️ Structure du projet

arch-automation/
├── install.sh
├── ansible.cfg
├── inventory.yml
├── playbook.yml
├── roles/
│   ├── base/
│   ├── shell/
│   ├── desktop/
│   ├── nvidia/
│   ├── gaming/
│   ├── development/
│   └── dotfiles/
└── dotfiles/ (à venir)

## ⚡Personnalisation

- Pour déployer tes dotfiles, adapte le rôle dotfiles et décommente les tâches correspondantes.
- Pour ajouter des paquets ou des outils, modifie les rôles concernés.

