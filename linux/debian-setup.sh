#!/bin/bash

# Remove all games
sudo apt purge iagno lightsoff four-in-a-row gnome-robots pegsolitaire gnome-2048 hitori gnome-klotski gnome-mines gnome-mahjongg gnome-sudoku quadrapassel swell-foop gnome-tetravex gnome-taquin aisleriot gnome-chess five-or-more gnome-nibbles tali -y ; sudo apt autoremove -y

# Remove LibreOffice
sudo apt-get remove --purge "libreoffice*" -y
sudo apt-get clean -y
sudo apt-get autoremove -y

# Stop unnecessary services
sudo systemctl stop cups
sudo systemctl disable cups
sudo systemctl stop apache2
sudo systemctl disable apache2

# Install Flatpak
sudo cp sources.list /etc/apt/sources.list
sudo apt update
sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install general tools
## Flathub
flatpak install flathub io.dbeaver.DBeaverCommunity -y
flatpak install flathub com.jgraph.drawio.desktop -y
flatpak install flathub com.mattjakeman.ExtensionManager -y
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
sudo apt install resolvconf -y
sudo apt install dnsutils -y
sudo apt install sshpass -y
sudo apt install ./deb/google-chrome-stable_current_amd64.deb -y
sudo apt install ./deb/code_1.88.1-1712771838_amd64.deb -y
sudo apt install ./deb/azuredatastudio-linux-1.48.0.deb -y
## Snap
sudo snap install postman
sudo snap install remmina
sudo snap install auto-cpufreq
## NPM
npm install @angular/cli -g

# Install & Sync system time
sudo apt install systemd-timesyncd -y
sudo timedatectl set-ntp true

# Install KVM
# sudo apt install qemu-system libvirt-daemon-system -y
# sudo adduser $USER libvirt
# virsh --connect=qemu:///system net-autostart default
# sudo apt install virt-manager -y

# Install Firewall
# sudo apt install ufw -y
# sudo ufw default deny incoming
# sudo ufw default allow outgoing
# sudo ufw enable

# Install Unikey (https://software.opensuse.org//download.html?project=home%3Alamlng&package=ibus-bamboo)
echo 'deb http://download.opensuse.org/repositories/home:/lamlng/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/home:lamlng.list
curl -fsSL https://download.opensuse.org/repositories/home:lamlng/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_lamlng.gpg > /dev/null
sudo apt update
sudo apt install ibus-bamboo -y

# Install Azure CLI
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y

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

sudo apt-get update
sudo apt-get install azure-cli -y

# Install Docker
## Add Docker's official GPG key
sudo apt-get update
sudo apt-get install ca-certificates gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

## Add the repository to APT sources
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Install K8s
curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o ~/.local/bin/kubectl
sudo chmod +x ~/.local/bin/kubectl

# Install .NET Core SDK
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo apt install ./packages-microsoft-prod.deb -y
rm packages-microsoft-prod.deb
sudo apt update && sudo apt install -y dotnet-sdk-8.0

# Install Docfx
dotnet tool install docfx -g

# Install ZShell
sudo apt install zsh -y
sudo chsh -s $(which zsh)

# Install plugin for ZShell
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

sudo reboot