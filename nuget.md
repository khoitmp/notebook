- Sample Nuget.Config for public Nuget
```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" />
  </packageSources>
</configuration>
```

- Sample Nuget.Config for private Nuget
```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" protocolVersion="3" />
    <add key="lib" value="https://pkgs.dev.azure.com/khoitmp/Sandbox/_packaging/lib/nuget/v3/index.json" />
  </packageSources>
  <packageSourceCredentials>
    <lib>
      <!-- Create PAT -->
      <add key="Username" value="azuredevops" />
      <add key="ClearTextPassword" value="<token>" />
    </lib>
  </packageSourceCredentials>
</configuration>
```

- Pack & Push
```sh
dotnet build
dotnet pack
dotnet nuget push --source <source_name> --api-key <key> <path>/<file_name>.nupkg # Public
dotnet nuget push --source <source_name> --api-key az <path>/<file_name>.nupkg # Private
```