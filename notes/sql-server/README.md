# SQL Server

## Concurrency
### 1. Pessimistic Concurrency Control
- By default, SQL Server uses pessimistic concurrency control, where it applies exclusive locks to rows being updated. This prevents other transactions from modifying the same row until the lock is released.
- Benefits: Ensures strong data consistency and integrity. Suitable for scenarios where conflicts are likely and you want to prevent any concurrent modifications.
### 2. Optimistic Concurrency Control
- Instead of locking rows, this approach assumes conflicts are rare and uses versioning (e.g., a timestamp or row version column) to detect conflicts only at the time of update, rather than locking resources during reads or writes.
- Benefits: Reduces contention and locking overhead, allowing higher concurrency.
Suitable for scenarios where updates are infrequent or where locking might lead to performance issues.

## Isolation
### 1. Read Uncommitted
- Behavior: Allows dirty reads. Transactions can read data modified by other transactions that haven’t been committed yet.
- Use Case: When you need the highest concurrency and can tolerate reading uncommitted changes.
- Example: Reporting queries that do not need to reflect the most up-to-date state of the data.

### 2. Read Committed
- Behavior: Prevents dirty reads. A transaction cannot read data that is being modified by another transaction until that transaction is committed.
- Use Case: Default isolation level, balancing data consistency and concurrency.
- Example: Standard transactional operations where you want to ensure that reads reflect committed changes but can tolerate some blocking.

### 3. Repeatable Read
- Behavior: Ensures that if a transaction reads a row, no other transactions can modify or delete that row until the transaction completes. Prevents non-repeatable reads.
- Use Case: Scenarios where consistency is crucial, and you need to ensure that data read multiple times during the transaction remains unchanged.
- Example: Financial transactions where the state of data needs to remain consistent throughout the transaction.

### 4. Serializable
- Behavior: Provides the strictest isolation by ensuring that no other transactions can access or modify the data being read or written by the current transaction until it completes. Prevents phantom reads.
- Use Case: When absolute data consistency is required, and you want to avoid any potential conflicts with other transactions.
- Example: Scenarios involving complex data retrieval and updates where consistency is critical, such as inventory management systems.

### 5. Snapshot
- Behavior: Provides a consistent view of the data as it was at the start of the transaction, using row versioning. Does not block other transactions and avoids locking conflicts.
- Use Case: When you need a consistent view of data without blocking other transactions and can handle some overhead from versioning.
- Example: Reporting or long-running queries that require a consistent view of the data without interfering with other operations.

## Summary
- Read Uncommitted: Allows dirty reads; lowest level of isolation.
- Read Committed: Prevents dirty reads; default level.
- Repeatable Read: Prevents non-repeatable reads; ensures consistent data throughout a transaction.
- Serializable: Provides strictest isolation; prevents all concurrency issues, including phantoms.
- Snapshot: Uses row versioning for consistency; avoids blocking.

## Locks
### Row-Level Locks
#### 1. Shared Locks (S)
- Purpose: Used for read operations. Allows multiple transactions to read a resource simultaneously but prevents any transaction from modifying it while it is being read.
- Example: When a SELECT statement reads data, a shared lock ensures that the data being read is not changed by other transactions until the read is complete.

#### 2. Exclusive Locks (X)
- Purpose: Used for write operations. Prevents other transactions from reading or modifying the resource until the transaction holding the exclusive lock completes.
- Example: When an UPDATE or DELETE statement modifies data, an exclusive lock is applied to ensure that no other transaction can read or modify the same data until the modification is complete.

#### 3. Update Locks (U)
- Purpose: Used to prevent a common form of deadlock in scenarios where a transaction intends to update data. An update lock is placed when a transaction reads a resource with the intention to update it later.
- Example: When a transaction reads a row with the intention of updating it, an update lock is acquired to ensure that no other transaction acquires an exclusive lock on that row before the update.

#### 4. Intent Locks (IX and IS)
##### Intent Shared Locks (IS)
- Purpose: Indicates a transaction's intention to acquire shared locks on individual resources.
- Example: When a transaction intends to acquire shared locks on rows within a page or table, it acquires an intent shared lock on the page or table level.

##### Intent Exclusive Locks (IX)
- Purpose: Indicates a transaction's intention to acquire exclusive locks on individual resources.
- Example: When a transaction intends to acquire exclusive locks on rows within a page or table, it acquires an intent exclusive lock on the page or table level.

### Table-Level Locks
#### 1. Schema Locks (Sch-S and Sch-M)
##### Schema Stability Locks (Sch-S)
- Purpose: Prevents modifications to the schema of a database object while allowing other transactions to read the object’s data.
- Example: When a transaction reads the schema of a table, a schema stability lock is applied to ensure the schema does not change during the read.

##### Schema Modification Locks (Sch-M)
- Purpose: Prevents any access to the schema of a database object while it is being modified.
- Example: When a transaction modifies the structure of a table (e.g., adding a column), a schema modification lock is acquired to prevent other transactions from accessing the schema until the modification is complete.

#### 2. Table Lock (Tab)
- Purpose: Acquired when operations need to lock the entire table, typically used during table scans or bulk operations.
- Example: SELECT * FROM <table_name> WITH (TABLOCK) or large data modifications.

#### 3. Bulk Update Lock (BU)
- Purpose: Used during bulk operations to prevent other transactions from accessing the table in a conflicting way.
- Example: Bulk inserts or updates using tools or commands that process large amounts of data.

#### 4. Table-Level Lock (TABLOCK)
- Purpose: Forces SQL Server to use a table-level lock for the duration of the operation.
- Example: SELECT ... WITH (TABLOCK)