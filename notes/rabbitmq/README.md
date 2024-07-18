# RabbitMQ

## Concepts
- **Messaging**: RabbitMQ facilitates message-oriented communication between applications or components within a distributed system
- **Producer**: An application or component that sends (produces) messages to RabbitMQ for delivery
- **Consumer**: An application or component that receives (consumes) messages from RabbitMQ to process them
- **Queue**: A buffer that stores messages sent by producers until consumers retrieve them. Queues decouple producers from consumers, allowing asynchronous communication
- **Exchange**: A routing component that receives messages from producers and routes them to queues based on routing rules defined by bindings
- **Binding**: A rule that links an exchange to one or more queues, specifying how messages should be routed
- **Routing Key**: A message attribute used by exchanges to determine which queues to deliver messages to, based on binding rules
- **Routing**: The process of directing messages from exchanges to queues based on routing keys and bindings
- **Consumer Acknowledgment**: The mechanism by which consumers inform RabbitMQ that they have successfully processed a message and it can be removed from the queue
- **Dead Letter Exchange (DLX)**: A mechanism that allows messages to be re-routed to a specific exchange when they cannot be processed (e.g., due to expiration or queue length)
- **Message Durability**: Ensuring that messages are not lost even if RabbitMQ or a consumer crashes. This is achieved by configuring queues and messages as durable (archive by storing messages on disk)
- **Virtual Host**: A logical grouping mechanism within RabbitMQ that allows segregation of resources (exchanges, queues, bindings, etc.) for different applications or environments
**Connection**: A TCP connection established between a client (producer or consumer) and RabbitMQ server, allowing communication and message exchange

## Routing
### Unicast (`direct`)
- The `direct` exchange type allows you to route messages directly to queues based on a **routing_key**

```json
{
    "queues": [
        {
            "name": "queue1",
            "durable": true,
            "exclusive": false,
            "autoDelete": false
        },
        {
            "name": "queue2",
            "durable": true,
            "exclusive": false,
            "autoDelete": false
        }
    ],
    "exchanges": [
        {
            "name": "direct_exchange",
            "type": "direct",
            "durable": true
        }
    ],
    "bindings": [
        {
            "exchange": "direct_exchange",
            "queue": "queue1",
            "routingKey": "critical"
        },
        {
            "exchange": "direct_exchange",
            "queue": "queue2",
            "routingKey": "general"
        }
    ]
}
```

```C#
// Send message to only queue1
channel.BasicPublish(exchange: "",
                    routingKey: "critical",
                    basicProperties: null,
                    body: body);
```

### Multicast (`topic`)
- The `topic` exchange type allows you to route messages to a group of queues based on a **routingKey**

```json
{
    "queues": [
        {
            "name": "queue1",
            "durable": true,
            "exclusive": false,
            "autoDelete": false
        },
        {
            "name": "queue2",
            "durable": true,
            "exclusive": false,
            "autoDelete": false
        },
        {
            "name": "queue3",
            "durable": true,
            "exclusive": false,
            "autoDelete": false
        }
    ],
    "exchanges": [
        {
            "name": "topic_exchange",
            "type": "topic",
            "durable": true
        }
    ],
    "bindings": [
        {
            "exchange": "topic_exchange",
            "queue": "queue1",
            "routingKey": "quick.orange.*"
        },
        {
            "exchange": "topic_exchange",
            "queue": "queue2",
            "routingKey": "*.orange.*"
        },
        {
            "exchange": "topic_exchange",
            "queue": "queue3",
            "routingKey": "lazy.#"
        }
    ]
}
```

```C#
// Send message to only queue1 & queue2
channel.BasicPublish(exchange: "topic_exchange", 
                    routingKey: "quick.orange.rabbit", 
                    basicProperties: null, body: body);
```

### Broadcast (`fanout`)
- The `fanout` exchange type allows you to route messages all queues bound the the exchange (no **routingKey** provided)

```json
{
    "queues": [
        {
            "name": "queue1",
            "durable": true,
            "exclusive": false,
            "autoDelete": false
        },
        {
            "name": "queue2",
            "durable": true,
            "exclusive": false,
            "autoDelete": false
        },
        {
            "name": "queue3",
            "durable": true,
            "exclusive": false,
            "autoDelete": false
        }
    ],
    "exchanges": [
        {
            "name": "fanout_exchange",
            "type": "fanout",
            "durable": true
        }
    ],
    "bindings": [
        {
            "exchange": "fanout_exchange",
            "queue": "queue1"
        },
        {
            "exchange": "fanout_exchange",
            "queue": "queue2"
        },
        {
            "exchange": "fanout_exchange",
            "queue": "queue3"
        }
    ]
}
```

```C#
// Send message to all queues
channel.BasicPublish(exchange: "fanout_exchange", 
                    routingKey: "",
                    basicProperties: null, 
                    body: body);
```

## Message Consumtion
- In messaging systems like RabbitMQ, once a message is consumed (i.e., received and acknowledged) by a consumer, it is typically removed from the queue by default. This behavior ensures that messages are processed exactly once, as long as the consumer successfully acknowledges receipt of the message
    - Manual Acknowledgment: In many scenarios, the consumer explicitly acknowledges the message back to RabbitMQ after it has successfully processed the message. This acknowledgment (ack) informs RabbitMQ that the message can be safely removed from the queue
    - Automatic Acknowledgment: Alternatively, messages can be acknowledged automatically by RabbitMQ immediately after delivery to the consumer. This mode is simpler but can lead to message loss if the consumer crashes before processing completes

## Auzre Function 
### RabbitMQTriger
- By default, when using Azure Functions with RabbitMQ trigger, messages are automatically acknowledged (ack'd) as soon as they are successfully delivered to the function. This means that Azure Functions will acknowledge the message to RabbitMQ immediately upon receiving it and before executing your function logic. If you need to control when the message is acknowledged, you can opt for manual acknowledgment (setting the **autoAck** parameter to false in the function's host.json or in the RabbitMQ trigger binding configuration)

### Retries policy
- In Azure Functions, the number of retries and the retry behavior for function executions can be configured through the host settings. By default, Azure Functions retries a failed function execution up to 5 times (in case RabbitMQTriger 5 retries with the same RabbitMQ message, no getting from the queue again)

### Process messages in order (from a queue)
- By default settings, mutiple instances of Azure Function will consum messages from the queue concurently, which means the messages might be processed not in order, to archive in order process we need to config the Azure Function only run one instance

```json
// host.json
{
  "version": "2.0",
  "extensions": {
    "queues": {
      "maxDequeueCount": 5, // Number of retries
      "visibilityTimeout": "00:00:30", // Time duration for each retry attempt
      "maxPollingInterval": "00:01:00", // Maximum interval between polling for messages
      "batchSize": 16,
      "newBatchThreshold": 8,
      "maxConcurrentCalls": 10 // Number of instances concurently consum messages from a queue
    }
  }
}
```

### Dead-letter
- When using Azure Functions with RabbitMQ triggers and configuring a dead-letter queue (DLQ) for messages that cannot be processed successfully, you typically need to configure both RabbitMQ and Azure Functions appropriately
  - **RabbitMQ Configuration**: Configure a dead-letter exchange (DLX) and dead-letter queue (DLQ) within RabbitMQ
  - **Azure Function**: Handle message processing and ensure that messages are acknowledged (acknowledgment) or rejected (nack) based on processing outcomes

## Scale (HA)
### Mirrored Queues
- RabbitMQ uses `mirrored queues` to replicate data across multiple nodes (typically referred to as nodes in a cluster). Each queue can have one active master and one or more replica nodes
- Messages published to a queue are replicated to all nodes hosting the queue, ensuring data redundancy and availability
- When the active master node for a queue becomes unavailable (e.g., due to a crash), RabbitMQ promotes one of the replica nodes to become the new active master
- In RabbitMQ clusters, when you send a message to a specific queue (`queue1`, for example), you don't directly send it to a particular node within the cluster. Instead, you send the message to the RabbitMQ cluster itself, and RabbitMQ internally routes the message to the correct node that hosts the active master for `queue1` (no load balancing needed)

---------------------------------------
|               CLUSTER               |
---------------------------------------
------------------   ------------------
|     Node 1     |   |     Node 2     |
------------------   ------------------
| queue1 (active)|   | queue2 (active)|
| queue2 (rep)   |   | queue2 (rep)   |
|                |   |                |
|                |   |                |
|                |   |                |
|                |   |                |
|                |   |                |

*NOTE: The more nodes, the more active master nodes (for queues), the more replication queues

## Connection
### Best Practices for Managing Connections
- **Singleton Connection**: Use a singleton pattern or dependency injection to manage a single RabbitMQ connection instance across your application
- **Channel Multiplexing**: Create multiple channels within the single connection to perform different tasks (publishing, consuming, administrative operations)
### Best Practices for Channel Management
- **Reuse Channels**: Create channels once during initialization and reuse them throughout the application’s lifecycle
- **Thread Safety**: Channels are not thread-safe, so ensure that each thread uses its own channel when performing RabbitMQ operations concurrently