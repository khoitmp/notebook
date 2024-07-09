### Quick
```sh
ctrl+l # Clear terminal
```

### Help
```sh
man <command> # Description
<command> --help # What to to next
apropos <what_you_want_to_do> # Related commands
```

### Info
```sh
hostnamectl # Overall
uname -a # Kernel
lscpu # CPU
cat /proc/cpuinfo
free -h # RAM
cat /proc/meminfo
df -h # Disk
lsblk
top # Processes & comsumption
htop
nproc # Number of processors
pwd # Current directory
du -sh *<directory_name> # Directory
ps # Shell
arp -n # ARP Cache
```

### Management
```sh
who # Who else login into the system
whoami # User
groups # Groups you're in
cat /etc/group # Groups
cat /etc/passwd # Users
su - <user_name> # Switch user
sudo adduser <user_name> # Add
sudo userdel <user_name> # Delete
sudo passwd <user_name> # Set password
sudo usermod -aG sudo <user_name> # Add to group
sudo visudo # Edit sudoers file
sudo groupadd <group_name>
```

### Action
```sh
which <command> # Where used
cd / # Root
cd ~ # Workspace
cp <file_name> <new_file_name>
rm <file_name>
rm -rf <directory_name>
```

### Datetime
```sh
timedatectl set-ntp true # Sync the clock
timedatectl status
```

### Service/Daemon
```sh
systemctl start/stop/status <service_name> # Do actions on the service
journalctl -f -u <service_name> # View logs
systemctl list-units --type=service --state=running # Identify running services
```

### Networking
```sh
ifconfig <interface> # promisc (enable promiscuous mode to create vitual network interfaces)
ip add show <interface>
ip link show <interface>
ip route show <interface>
cat /etc/resolv.conf # DNS
```

### Port
```sh
# -t: Display TCP connections
# -u: Display UDP connections
# -l: Show only listening sockets (sockets that are waiting for incoming connections)
# -n: Show numerical addresses instead of resolving hostnames
# -p: Show the PID (process identifier) and name of the program that owns the socket
# -i: Displays a table of all network interfaces along with their statistics
netstat -tulnp

lsof -i :<port> # Identify which service comsuming the port
```

### Nmap
```sh
nmap -sn <network>/<mask> # Basic network scan to discover live hosts
nmap -A <network>/<mask> # Full scan with port and service information
nmap -p <port> <ip> # Scan a specified port on a host   
```

# Copy file from remote
```sh
scp <username>@<ip>:<source_file_path> <destination_file_path>
```