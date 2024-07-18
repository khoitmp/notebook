# TimescaleDB

## Concepts
- Optimize for handling timeseries data, such as IoT data, sensor data,...

### Hypertable (chunks and partitions are interchangable)
- hyber_table with interval partition, data inserted will be seperate to chunks (based on day, week, month,...). For instance, if the partition is `1 day` then each day will have one chunk, easier data retention policies
- By partitioning data based on time intervals, TimescaleDB can quickly identify and access relevant partitions when querying data within specific time ranges. This reduces the amount of data scanned and improves query response times. For instance, if the partition is `1 day` and then query in timespan 2 days would getting data from 2 chunks
- Partitioning facilitates horizontal scalability by distributing data across multiple physical storage locations or nodes, enhancing overall system scalability as data volume grows

### time_bucket
- The time_bucket function in TimescaleDB is used to bucketize timestamps into discrete time intervals. It's particularly useful for aggregating time-series data into fixed time intervals, such as hourly, daily, or monthly buckets

### time_bucket_gapfill
- The time_bucket_gapfill function extends the functionality of time_bucket by filling in missing time intervals with NULL values. This is particularly useful when you want to ensure that every bucket interval within a specified time range is represented, even if no data points exist for that interval

### interpolate
- Can combine with time_bucket_gapfill to interpolate missing values

## Scale (HA)
- If config, TimescaleDB's distributed hypertable architecture ensures that chunks of time-series data are distributed across multiple nodes for improved performance, scalability, and fault tolerance (horizontally partitioned)

### Single Node Deployment
- In a single-node deployment of TimescaleDB (where all data resides on a single database server), TimescaleDB itself manages query execution internally, there's no need for an external load balancer because the database server handles all queries and data operations within its own resources

### Multiple Nodes Deployment
- If you have multiple TimescaleDB instances or nodes serving queries, you might deploy a load balancer (e.g., at the application or network layer) to distribute incoming query traffic across these nodes