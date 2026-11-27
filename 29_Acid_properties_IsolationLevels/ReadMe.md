# MySQL Day 28 – ACID Properties: Isolation Levels

## 1. What is Isolation?

Isolation is the third property of ACID transactions.

It controls how concurrent transactions interact with each other and what changes they can observe.

Multiple users may access and modify the same database records simultaneously. Without proper isolation, concurrent transactions can produce incorrect or inconsistent results.

### Example: Bank Account

Initial balance: ₹10,000.

Two users attempt to withdraw money simultaneously:

- Transaction A attempts to withdraw ₹7,000.
- Transaction B attempts to withdraw ₹6,000.

Both transactions might read the original balance of ₹10,000.

Without appropriate concurrency control, both withdrawals could potentially succeed, resulting in an incorrect balance.

**Isolation helps the database manage concurrent transactions safely.**

Important: Isolation does not mean transactions must always execute sequentially. It means their combined behavior must satisfy the guarantees of the selected isolation level.

---

## 2. What are Isolation Levels?

Isolation levels determine how much one transaction is isolated from changes made by other concurrent transactions.

SQL defines four standard isolation levels:

1. READ UNCOMMITTED
2. READ COMMITTED
3. REPEATABLE READ
4. SERIALIZABLE

As we move towards SERIALIZABLE, isolation becomes stricter, and concurrency may become more restricted.

---

## 3. Three Major Read Anomalies

Before understanding each isolation level, understand the three anomalies they help prevent.

### A. Dirty Read

A dirty read occurs when one transaction reads data modified by another transaction that has not yet committed.

Example:

Initial balance = ₹10,000.

Transaction A:

```sql
START TRANSACTION;

UPDATE accounts
SET balance = 3000
WHERE account_id = 1;
```

Transaction A has not committed.

Transaction B reads:

```sql
SELECT balance
FROM accounts
WHERE account_id = 1;
```

Transaction B may read ₹3,000.

Now Transaction A executes:

```sql
ROLLBACK;
```

The balance returns to ₹10,000.

However, Transaction B already read ₹3,000, which was never committed.

**This is called a Dirty Read.**

READ UNCOMMITTED allows dirty reads. READ COMMITTED and higher levels prevent them.

### B. Non-Repeatable Read

A non-repeatable read occurs when the same transaction reads the same row twice but gets different values because another transaction committed a modification between the reads.

Initial balance = ₹10,000.

Transaction A:

```sql
START TRANSACTION;

SELECT balance
FROM accounts
WHERE account_id = 1;
```

Result: ₹10,000.

Transaction B:

```sql
START TRANSACTION;

UPDATE accounts
SET balance = 8000
WHERE account_id = 1;

COMMIT;
```

Transaction A reads again:

```sql
SELECT balance
FROM accounts
WHERE account_id = 1;
```

Result: ₹8,000.

The same row returned two different values within Transaction A.

**This is called a Non-Repeatable Read.**

READ COMMITTED allows this behavior.

REPEATABLE READ prevents it for ordinary consistent reads in MySQL InnoDB.

### C. Phantom Read

A phantom read occurs when the same query returns a different set of rows because another transaction inserts, deletes, or modifies rows that match the query condition.

Transaction A:

```sql
START TRANSACTION;

SELECT *
FROM orders
WHERE status = 'PENDING';
```

Initially, the query returns two rows:

| order_id | status |
|---|---|
| 101 | PENDING |
| 102 | PENDING |

Transaction B inserts another matching row:

```sql
INSERT INTO orders (order_id, status)
VALUES (103, 'PENDING');

COMMIT;
```

Transaction A executes the same query again.

Initially, it returned two rows. Now it returns three rows under an isolation behavior that permits this change.

**This is called a Phantom Read.**

Important distinction:

- Non-Repeatable Read: An existing row returns a different value.
- Phantom Read: The set of rows matching a query changes.

---

## 4. The Four Isolation Levels

### Level 1: READ UNCOMMITTED

This is the weakest standard isolation level.

A transaction may read changes made by another transaction even before those changes are committed.

Example:

```sql
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

START TRANSACTION;

SELECT balance
FROM accounts
WHERE account_id = 1;

COMMIT;
```

Possible problem:

- Transaction A updates a balance but does not commit.
- Transaction B reads the uncommitted balance.
- Transaction A rolls back.
- Transaction B has read data that never became committed.

Characteristics:

- Dirty reads: Possible.
- Non-repeatable reads: Possible.
- Phantom reads: Possible.

Use: Rarely appropriate for correctness-sensitive application operations.

### Level 2: READ COMMITTED

A transaction reads only committed data.

However, another transaction can commit changes between two reads.

Example:

```sql
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT balance
FROM accounts
WHERE account_id = 1;
```

Suppose the first result is ₹10,000.

Another transaction updates the balance to ₹8,000 and commits.

Transaction A executes the same SELECT again.

It may now read ₹8,000.

Why?

READ COMMITTED generally provides a fresh consistent snapshot for each ordinary SELECT statement.

Characteristics:

- Dirty reads: Prevented.
- Non-repeatable reads: Possible.
- Phantom reads: Possible.

### Level 3: REPEATABLE READ

A transaction repeatedly reading the same data through ordinary consistent reads sees the same snapshot.

Example:

```sql
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;

SELECT balance
FROM accounts
WHERE account_id = 1;
```

Suppose the result is ₹10,000.

Another transaction updates the balance to ₹8,000 and commits.

Transaction A executes the same SELECT again.

It still sees ₹10,000.

Why?

MySQL InnoDB uses Multi-Version Concurrency Control (MVCC) to provide consistent snapshots for ordinary reads.

The snapshot is generally established by the first consistent read in the transaction.

Characteristics in standard SQL:

- Dirty reads: Prevented.
- Non-repeatable reads: Prevented.
- Phantom reads: Not necessarily prevented by the standard guarantee.

**Important MySQL InnoDB distinction:**

REPEATABLE READ is the default isolation level in MySQL InnoDB.

InnoDB ordinary consistent reads use a transaction snapshot, so newly committed matching rows do not appear in repeated ordinary SELECT queries within that snapshot.

For locking reads and relevant range operations, InnoDB uses record locks, gap locks, and next-key locks to protect against concurrent changes.

Example of a locking read:

```sql
SELECT *
FROM orders
WHERE status = 'PENDING'
FOR UPDATE;
```

### Level 4: SERIALIZABLE

This is the strictest standard isolation level.

Concurrent transactions must behave as though they executed in some serial order.

Example:

Two users attempt to borrow the same last available book copy.

The database must ensure that the outcome is equivalent to a valid serial execution.

It may:

- Make one transaction wait.
- Apply locks.
- Abort a transaction when necessary.

Characteristics:

- Dirty reads: Prevented.
- Non-repeatable reads: Prevented.
- Phantom reads: Prevented.

Important: SERIALIZABLE does not mean all transactions must literally execute one after another from beginning to end. It means their resulting behavior must be equivalent to a serial execution.

---

## 5. Isolation Levels Comparison

| Isolation Level | Dirty Read | Non-Repeatable Read | Phantom Read |
|---|---|---|---|
| READ UNCOMMITTED | Possible | Possible | Possible |
| READ COMMITTED | Prevented | Possible | Possible |
| REPEATABLE READ | Prevented | Prevented | Possible under standard SQL guarantees |
| SERIALIZABLE | Prevented | Prevented | Prevented |

### MySQL InnoDB Note

MySQL InnoDB provides additional snapshot-based behavior at REPEATABLE READ.

Ordinary consistent reads use the same transaction snapshot, preventing newly committed matching rows from appearing in repeated reads.

Locking reads have different behavior and may use next-key locks to protect relevant index ranges.

---

## 6. Setting Isolation Levels in MySQL

### A. Set isolation for the next transaction

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT *
FROM accounts
WHERE account_id = 1;

COMMIT;
```

This applies to the next transaction in the current session.

### B. Set isolation for the current session

```sql
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

This changes the default isolation level for transactions started in the current session.

### C. Set the global default

```sql
SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

This changes the default for new sessions. Existing sessions are not automatically changed.

Appropriate privileges are required.

### D. Check the current isolation level

```sql
SELECT @@transaction_isolation;
```

The default MySQL InnoDB isolation level is generally:

```text
REPEATABLE-READ
```

---

## 7. Real-World Example: Library Management System

Imagine our Library Management System has one available copy of a book.

Two users attempt to borrow it simultaneously.

Without proper concurrency control:

1. User A checks availability.
2. User B checks availability.
3. Both see AVAILABLE.
4. Both attempt to borrow the same copy.

This could result in duplicate borrowing records or incorrect book status if the application is not designed safely.

We can use pessimistic locking with:

```sql
START TRANSACTION;

SELECT *
FROM book_copy
WHERE copy_id = 101
FOR UPDATE;

-- Verify that the copy is AVAILABLE.
-- Update its status to BORROWED.
-- Insert the borrowing record.

COMMIT;
```

`SELECT ... FOR UPDATE` acquires a locking read on the selected record, preventing conflicting transactions from modifying it until the transaction ends.

In Spring Boot:

```java
@Transactional
public Borrowing borrowBook(Long copyId, Long memberId) {

    // Retrieve and lock the BookCopy.
    // Verify AVAILABLE status.
    // Update status to BORROWED.
    // Create Borrowing record.
    // Commit when successful.
}
```

The complete operation should be performed within a transaction.

Additional safeguards such as appropriate database constraints and conditional updates should also be considered.

**Isolation + Transactions + Locking + Business Rules = Reliable Backend Operations.**

---

## 8. Interview Questions

1. What is Isolation in ACID?
2. Why do databases need isolation levels?
3. What are the four standard isolation levels?
4. What is a Dirty Read?
5. What is a Non-Repeatable Read?
6. What is a Phantom Read?
7. What is the difference between Non-Repeatable Read and Phantom Read?
8. Which isolation level permits Dirty Reads?
9. Which isolation level prevents Dirty Reads?
10. What is the default isolation level of MySQL InnoDB?
11. How does REPEATABLE READ work in MySQL?
12. What is MVCC?
13. What is the difference between a consistent read and a locking read?
14. What is SERIALIZABLE isolation?
15. How does SELECT FOR UPDATE help with concurrent borrowing operations?

---

## 9. Key Takeaways

- Isolation manages concurrent transactions.
- READ UNCOMMITTED may allow dirty reads.
- READ COMMITTED prevents dirty reads but permits non-repeatable reads.
- REPEATABLE READ provides repeatable snapshot-based reads in MySQL InnoDB.
- SERIALIZABLE provides the strictest standard isolation guarantee.
- MySQL InnoDB uses MVCC and locking mechanisms.
- Isolation levels involve a trade-off between concurrency and consistency guarantees.
- Isolation alone does not replace correct transaction design and locking.

### Quick Memory Trick

- Dirty Read = Reading uncommitted data.
- Non-Repeatable Read = Same row, different value.
- Phantom Read = Same query, different set of rows.
