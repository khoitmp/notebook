### Quick
```sh
ctrl+l # Clear terminal
ctrl+w # Remove one word
ctrl+u # Cut to the begin of the line (from the pointer)
ctrl+k # Cut to the end of the line (from the pointer)
ctrl+y # Redo previous action (cut action - to the pointer)
ctrl+a # Begin of the line
ctrl+e # End of the line
ctrl+x+e # Open default editor (with the text in the terminal)
```

### Help
```sh
man <command> # Description
<command> --help # What to to next
apropos <what_you_want_to_do> # Related commands
```

### Info
```sh
which <command> # Where used (bin, sbin,...)
tree # Directory tree
sudo !! # Run the command just run with sudo
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
pstree # Processes in a tree
arp -n # ARP Cache
less # Get top records in a file
tail -f # Get last records in a file (-f: follow the file)
```

### Process
```sh
ps # Shell
ps -aux # Processes
ps -u <username> # User's processes
pgrep <app_name> # Combination of ps and grep (returns process_id)
kill <pid> # Kill a process
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
sudo groupdel <group_name>
```

### Action
```sh
touch <file1> <file2> # Create files
mkdir <directory1> <directory2> # Create directories
mkdir -p <directory1>/<directory2> # Create directory with children

# Create a file and put a line text inside (*)
cat > <file> [Enter] Putting some text inside

# Create a file and put lines of text inside
cat << END > <file> [Enter]
Putting some text inside 1
Putting some text inside 2
Putting some text inside 3
END

# Same (*)
echo "Putting some text inside" > <file>

cd / # Root
cd ~ # Workspace
cp <file_name> <new_file_name>
rm <file_name>
rm -rf <directory_name>
scp <username>@<ip>:<source_file_path> <destination_file_path> # Copy file from remote
```

### Datetime
```sh
timedatectl set-ntp true # Sync the clock
timedatectl status
```

### Service/Daemon
```sh
systemctl start/stop/status/restart <service_name> # Do actions on the service
journalctl -f -u <service_name> # View logs
systemctl list-units --all --type=service --state=running # Daemons (memory)
systemctl list-unit-files # Daemons (disk)
```

### Networking
```sh
arp -n # ARP table
route -n # Routing table
cat /etc/resolv.conf # DNS

ifconfig <interface> # promisc (enable promiscuous mode to create vitual network interfaces)
ip add show <interface>
ip link show <interface>
ip route show <interface>
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

### CURL
```sh
curl https://<domain>/<file>.txt # View file content
curl -O https://<domain>/<file>.txt # Download the file
curl -I https://<domain>/<file>.txt # View response headers
```

### SSHPass
```sh
sshpass -p <password> ssh <username>@<hostname>
```