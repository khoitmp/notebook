```sh
redis-cli

auth {password}

selecct 1
scan 0 MATCH "*{key_name}*" COUNT 10000000

del {key_name1} {key_name2}
```