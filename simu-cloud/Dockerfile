FROM ubuntu:22.04

# Désactiver les interactions lors de l'installation des paquets
ENV DEBIAN_FRONTEND=noninteractive

# Installation d'SSH, Python 3 (exigé par Cloud-1) et sudo
RUN apt-get update && apt-get install -y \
    openssh-server \
    python3 \
    python3-pip \
    sudo \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Configuration du serveur SSH
RUN mkdir /var/run/sshd

# Création d'un utilisateur "deploy" sans mot de passe avec privilèges Sudo (simule un utilisateur VPS)
RUN useradd -m -s /bin/bash deploy && \
    echo "deploy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Configuration de la clé SSH publique pour se connecter sans mot de passe
RUN mkdir -p /home/deploy/.ssh && chmod 700 /home/deploy/.ssh

# Copie de ta clé SSH publique locale dans le container
COPY ed25519.pub /home/deploy/.ssh/authorized_keys

RUN chown -R deploy:deploy /home/deploy/.ssh && \
    chmod 600 /home/deploy/.ssh/authorized_keys

# Exposition du port SSH
EXPOSE 22

# Démarrage du daemon SSH
CMD ["/usr/sbin/sshd", "-D"]