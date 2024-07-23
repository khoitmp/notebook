#!/bin/bash

# Disable unnecessary services (review)
# sudo systemctl disable systemd-resolved
# sudo systemctl stop systemd-resolved

# Install general tools
sudo apt install sudo -y
sudo apt install curl -sy
sudo apt install lsof -y
sudo apt install htop -y
sudo apt install nmap -y
sudo apt install dnsutils -y
sudo apt install net-tools -y
sudo apt install traceroute -y
sudo apt install iputils-ping -y

# Install Firewall
# sudo apt install ufw -y
# sudo ufw default deny incoming
# sudo ufw default allow outgoing
# sudo ufw allow 22
# sudo ufw enable

# Install SSH Server
sudo apt install openssh-server -y
sudo systemctl enable ssh
sudo systemctl start ssh

# Install Docker
## Add Docker's official GPG key
sudo apt update
sudo apt install ca-certificates gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

## Add the repository to APT sources
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

sudo reboot