## Add your user into sudoer group
```
su -
nano /etc/sudoers
```

## Add the line below into the file
```
# Replace <username> with target user
<username>  ALL=(ALL:ALL) ALL
```

## Run command
```
usermod -aG sudo <username>
exit
```

## Run installation
```
sudo chmod +x *.sh
```

### 1. Debian client
```
./debian12-setup.sh
./debian12-post-setup.sh
```

### 2. Debian server
```
debian12-server-setup.sh
```