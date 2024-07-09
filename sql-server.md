### SQLPackage
https://learn.microsoft.com/en-us/azure/azure-sql/database/database-export?view=azuresql

```sh
SqlPackage /Action:Import /SourceFile:"<file_path>.bacpac" /TargetConnectionString:"<connection_string>"
SqlPackage /Action:Export /TargetFile:"<file_path>.bacpac" /SourceConnectionString:"<connection_string>"
```