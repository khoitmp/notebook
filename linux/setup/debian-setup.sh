#!/bin/bash

# Remove all games
sudo apt purge iagno lightsoff four-in-a-row gnome-robots pegsolitaire gnome-2048 hitori gnome-klotski gnome-mines gnome-mahjongg gnome-sudoku quadrapassel swell-foop gnome-tetravex gnome-taquin aisleriot gnome-chess five-or-more gnome-nibbles tali -y
sudo apt autoremove -y

# Remove LibreOffice
sudo apt remove --purge "libreoffice*" -y
sudo apt clean -y
sudo apt autoremove -y

# Stop unnecessary services
sudo systemctl stop cups
sudo systemctl disable cups

# Install Flatpak
sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install general tools
## Flathub
flatpak install flathub io.dbeaver.DBeaverCommunity -y
flatpak install flathub com.jgraph.drawio.desktop -y
flatpak install flathub com.mattjakeman.ExtensionManager -y
flatpak install flathub io.github.seadve.Kooha -y
## APT
sudo apt install htop -y
sudo apt install snapd -y
sudo apt install kitty -y
sudo apt install curl -y
sudo apt install nmap -y
sudo apt install net-tools -y
sudo apt install lsof -y
sudo apt install traceroute -y
sudo apt install nodejs -y
sudo apt install npm -y
sudo apt install cpu-checker -y
sudo apt install gnome-tweaks -y
sudo apt install wireguard -y
sudo apt install dnsutils -y
sudo apt install network-manager-openvpn-gnome -y
sudo apt install ../deb/google-chrome-stable_current_amd64.deb -y
sudo apt install ../deb/code_1.92.1-1723066302_amd64.deb -y
sudo apt install ../deb/azuredatastudio-linux-1.48.0.deb -y
sudo apt install ../deb/WireframeSketcher-7.1.1_amd64.deb -y
## Snap
sudo snap install vlc
sudo snap install postman
sudo snap install remmina
sudo snap install auto-cpufreq
## NPM
sudo npm install @angular/cli -g

# Install & Sync system time
sudo apt install systemd-timesyncd -y
sudo timedatectl set-ntp true

# Install Unikey (https://software.opensuse.org//download.html?project=home%3Alamlng&package=ibus-bamboo)
echo 'deb http://download.opensuse.org/repositories/home:/lamlng/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/home:lamlng.list
curl -fsSL https://download.opensuse.org/repositories/home:lamlng/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_lamlng.gpg > /dev/null
sudo apt update
sudo apt install ibus-bamboo -y

# Install Azure CLI
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release -y

sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources

sudo apt update
sudo apt install azure-cli -y

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

## Install docker-compose standalone
curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 -o docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install K8s
sudo curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/bin/kubectl
sudo chmod +x /usr/bin/kubectl

# Install Helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update
sudo apt install helm -y

# Install Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update
sudo apt install terraform -y

# Install .NET Core SDK
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo apt install ./packages-microsoft-prod.deb -y
rm packages-microsoft-prod.deb
sudo apt update
sudo apt install -y dotnet-sdk-8.0

# Install Docfx
dotnet tool install docfx -g

# Install ZShell
sudo apt install zsh -y
chsh -s $(which zsh)

# Install plugin for ZShell
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete

# Install Firewall
sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

sudo reboot