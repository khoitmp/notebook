### Create RSA key

```sh
ssh-keygen -t rsa -b 4096 -f ~/.ssh/<key_name> -C <email>

# Test SSH connection
ssh -vT git@<hostname>
```

- Config multiple SSH keys
```
# Github
Host github
    HostName github.com
    IdentityFile ~/.ssh/github_rsa
    User git

# Azure
Host azure
    HostName ssh.dev.azure.com
    IdentityFile ~/.ssh/azure_rsa
    User git
```

- Restart the agent
```sh
pkill ssh-agent
eval $(ssh-agent)
```

### Remove .gitignore cache 
```sh
git rm --cached <file_name>
```