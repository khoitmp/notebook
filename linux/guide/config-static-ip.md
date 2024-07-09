## Update /etc/network/interfaces
```bash
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
#allow-hotplug wlp4s0
#iface wlp4s0 inet dhcp
#    wpa-ssid home
#    wpa-psk Home@123

# Doesn't work on power up
#auto wlp4s0
#iface wlp4s0 inet static
#    address 192.168.1.100
#    netmask 255.255.255.0
#    gateway 192.168.1.1
#    dns-nameservers 1.1.1.1
#    wpa-ssid home
#    wpa-psk Home@123
```

## Create bash /usr/local/bin/configure-wireless.sh
```bash
#!/bin/bash

# Wait for network interface to become available
sleep 30

# Check if interface exists
if [[ -d /sys/class/net/wlp4s0 ]]; then
    # Bring down the interface before configuring
    ip link set wlp4s0 down

    # Configure wireless settings
    wpa_passphrase "your_wifi_ssid" "your_wifi_password" | sudo tee /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null

    # Configure static IP address
    ip addr add 192.168.1.100/24 dev wlp4s0
    ip link set wlp4s0 up
    ip route add default via 192.168.1.1

    # Set DNS servers
    # echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
    # echo "nameserver 8.8.4.4" | sudo tee -a /etc/resolv.conf > /dev/null

    # Connect to wireless network
    wpa_supplicant -B -i wlp4s0 -c /etc/wpa_supplicant/wpa_supplicant.conf
    dhclient wlp4s0
else
    echo "Interface wlp4s0 not found."
fi
```

### Make the bash executable
```bash
sudo chmod +x /usr/local/bin/configure-wireless.sh
```

### Create a systemd /etc/systemd/system/configure-wireless.service
```bash
[Unit]
Description=Configure wlp4s0 Wireless Interface
After=network.target

[Service]
ExecStart=/usr/local/bin/configure-wireless.sh
Type=oneshot
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

### Enable systemd
```bash
sudo systemctl daemon-reload
sudo systemctl enable configure-wireless.service
```