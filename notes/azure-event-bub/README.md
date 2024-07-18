# Azure Event Hub

## Out Order Messaging
- **Producer**
  - **Partition Key**: When sending messages to Azure Event Hubs, you can specify a partition key. Messages with the same partition key are guaranteed to be routed to the same partition
  - **Ordering within Partition**: Messages with the same partition key are processed in order within their respective partition

- **Consumer**
    - **EventHubTrigger**: When using EventHubTrigger in Azure Functions, messages are automatically distributed among all partitions and consumed in parallel by function instances
    - **Parallel Processing**: Azure Functions can process messages from all partitions simultaneously, which can potentially lead to out-of-order processing unless additional handling is implemented

## In Order Messaging
- **Producer**
  - Use a consistent partition key for messages that must be processed in order. Ensure messages related to a particular sequence or entity use the same partition key

- **Consumer**
  - If strict ordering is required, you can use a single instance (maxConcurrentCalls=1 in EventHubOptions) to process messages sequentially within the function instance

---
**NOTE**
- **Scalability vs Ordering**: Ensuring strict message order can impact scalability because it may limit parallelism in message processing
- **Partition Management**: Azure Event Hubs automatically manages partitions, so the number of partitions and their distribution can vary based on throughput and scaling needs
---