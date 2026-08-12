#! /bin/bash

# apt-get update && apt-get install -y \
#    openssh-server \
#    python3 \
#    python3-pip \
#    sudo \
#    curl \
#    && rm -rf /var/lib/apt/lists/*

# Configuration du serveur SSH
#mkdir /var/run/sshd

# Création d'un utilisateur "deploy" sans mot de passe avec privilèges Sudo (simule un utilisateur VPS)
useradd -m -s /bin/bash deploy && \
    echo "deploy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Configuration de la clé SSH publique pour se connecter sans mot de passe
mkdir -p /home/deploy/.ssh && chmod 700 /home/deploy/.ssh

# Copie de ta clé SSH publique locale dans le container
cp /vagrant/ed25519.pub /home/deploy/.ssh/authorized_keys

chown -R deploy:deploy /home/deploy/.ssh && \
    chmod 600 /home/deploy/.ssh/authorized_keys

#systemctl enable --now ssh
