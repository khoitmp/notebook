# Redis

## Storage
- By default, Redis primarily uses RAM for data storage due to its speed and efficiency for handling frequently accessed data, but we can store data to disk

## Eviction Policy
- noeviction (default): Redis will not remove any keys and will return an error on write operations or null for read commands if memory is exhausted
- allkeys-lru: Evicts the least recently used (LRU) keys from all keys

## Databases
- By default, Redis supports 16 databases (numbered 0 to 15), each database operates independently, allowing for separate data sets to be stored and managed within the same Redis instance. Default database is database 0

## Scale (HA)
- In master-slaves model, we need to implement a load balancing approach
  - Could be implemented directly in the code
  - Could be using a middleware service

### Master Node
- Only one master, multiple master is not a best practice
- The primary node in the Redis cluster that handles both read and write operations

### Slave Nodes
- Secondary nodes in the Redis cluster that replicate data from the master node
- They handle read operations and can also be promoted to master status if the current master node fails (automatic failover)

---
**NOTE**** 
  - **Azure Cache for Redis** will automatically manage the scale and replication in the background, no need to config master-slaves and load balancing. It's a better choice
---