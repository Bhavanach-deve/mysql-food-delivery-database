
# Day 28 – Transactions, ACID and TCL

## Overview

Day 28 focuses on database transactions, transaction control
language (TCL), ACID properties, SAVEPOINT, ROLLBACK,
COMMIT and AUTOCOMMIT.

Transactions help us execute multiple database operations
as a logical unit of work.

They are essential for maintaining database reliability
and consistency in real-world backend applications.

---

## 1. What is a Transaction?

A transaction is a group of database operations treated
as one logical unit of work.

For example, transferring money from Account A to Account B
requires two operations:

1. Deduct money from Account A.
2. Credit money to Account B.

If the deduction succeeds but the credit fails, the database
must not leave the transfer in an inconsistent state.

Transactions help us manage this situation.

---

## 2. TCL – Transaction Control Language

TCL contains SQL commands used to control transactions.

| Command | Purpose |
|---|---|
| START TRANSACTION | Begins a transaction |
| COMMIT | Commits the transaction's changes |
| ROLLBACK | Undoes uncommitted changes |
| SAVEPOINT | Creates a rollback boundary within a transaction |
| ROLLBACK TO SAVEPOINT | Undoes changes after a specified savepoint |

---

## 3. START TRANSACTION

```sql
START TRANSACTION;
```

START TRANSACTION begins an explicit transaction.

The following transactional operations can be managed
as part of this transaction.

---

## 4. COMMIT

```sql
COMMIT;
```

COMMIT confirms the transaction's changes.

Once committed, the changes are committed to the database
and cannot be undone through an ordinary transaction rollback.

---

## 5. ROLLBACK

```sql
ROLLBACK;
```

ROLLBACK undoes uncommitted changes made in the current
transaction.

It ends the transaction.

### Example

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE account_id = 2;

ROLLBACK;
```

Both uncommitted operations are undone.

ROLLBACK is executed as a separate SQL statement.
It is not written inside an UPDATE statement.

---

## 6. Real-world example – Bank transfer

Suppose:

| Account | Balance |
|---|---:|
| A | ₹5000 |
| B | ₹2000 |

We transfer ₹1000 from A to B.

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE account_id = 2;

COMMIT;
```

### Expected result

| Account | Balance |
|---|---:|
| A | ₹4000 |
| B | ₹3000 |

If the transfer fails before COMMIT:

```sql
ROLLBACK;
```

The uncommitted changes are undone.

### Why use a transaction?

Without proper transaction management, one operation
could succeed while the other fails.

Transactions help ensure that the transfer is managed
as a logical unit of work.

---

## 7. SAVEPOINT

SAVEPOINT establishes a rollback boundary inside a transaction.

It allows us to undo changes made after a specific point
without rolling back the entire transaction.

### Syntax

```sql
SAVEPOINT savepoint_name;
```

### Rollback to a savepoint

```sql
ROLLBACK TO SAVEPOINT savepoint_name;
```

This undoes changes made after the savepoint while
preserving earlier uncommitted changes.

It does not end the transaction.

---

## 8. Real-world SAVEPOINT scenario

### Scenario: Order placement and loyalty redemption

Suppose a customer places an order.

The application:

1. Creates the order.
2. Inserts the order items.
3. Attempts loyalty point redemption.
4. If redemption fails, undoes only the redemption-related
   transaction changes.
5. Continues without redemption, if business rules permit.

### SQL example

```sql
START TRANSACTION;

-- Create the order.
INSERT INTO orders (customer_id, restaurant_id, total_amount, status)
VALUES (105, 3, 800.00, 'PENDING');

-- Insert order items as appropriate.

-- Create a rollback boundary.
SAVEPOINT before_loyalty;

-- Attempt loyalty redemption.
INSERT INTO loyalty_redemptions (order_id, points_used)
VALUES (5001, 100);

-- If redemption-related changes must be undone:
ROLLBACK TO SAVEPOINT before_loyalty;

-- Continue without redemption if permitted.

COMMIT;
```

The rollback to the savepoint preserves the earlier
uncommitted order and order-item operations.

However, the order is not committed until COMMIT is executed.

This is an illustrative scenario; table names and business
rules depend on the actual application.

---

## 9. Full ROLLBACK vs partial ROLLBACK

| ROLLBACK | ROLLBACK TO SAVEPOINT |
|---|---|
| Undoes all uncommitted changes in the transaction | Undoes changes after the specified savepoint |
| Ends the transaction | Does not end the transaction |
| Entire transaction is discarded | Earlier changes remain uncommitted |
| Transaction is no longer active after rollback | Transaction remains active |

---

## 10. Multiple SAVEPOINTS

A transaction may contain multiple savepoints.

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 100
WHERE account_id = 1;

SAVEPOINT S1;

UPDATE accounts
SET balance = balance - 200
WHERE account_id = 1;

SAVEPOINT S2;

UPDATE accounts
SET balance = balance - 300
WHERE account_id = 1;

ROLLBACK TO SAVEPOINT S2;

COMMIT;
```

The ₹300 deduction is undone.

The ₹100 and ₹200 deductions remain uncommitted
and are committed by COMMIT.

---

## 11. ACID properties

ACID represents four fundamental properties of reliable
database transaction processing.

### A – Atomicity

All or nothing.

A transaction's operations are managed as a logical unit.

If the transaction fails before commit, its uncommitted
changes can be rolled back.

Example:

A bank transfer must not leave money deducted from A
without being credited to B.

### C – Consistency

A transaction must preserve the database's defined
integrity rules.

The database must move from a valid state to another
valid state when the transaction successfully completes.

Consistency is supported through constraints, appropriate
business logic and transactional design.

Example:

A CHECK constraint can prevent a negative balance.

```sql
CHECK (balance >= 0)
```

Consistency does not mean that MySQL automatically knows
every business rule. Developers must enforce them.

### I – Isolation

Isolation controls how concurrent transactions interact.

It helps prevent harmful interference between transactions.

Example:

Two customers attempt to buy the last available book.

If both transactions see inventory = 1, the system must
use appropriate concurrency control so that the inventory
is not incorrectly sold twice.

Isolation levels and locking strategies affect how
transactions interact.

### D – Durability

Committed changes should survive failures according to
the database's durability guarantees.

After a successful COMMIT, the database is expected to
preserve the committed transaction even after a crash.

InnoDB uses redo logging and recovery mechanisms to
support durability.

---

## 12. AUTOCOMMIT

MySQL commonly has AUTOCOMMIT enabled by default.

Check it:

```sql
SELECT @@autocommit;
```

When autocommit is enabled, individual successful statements
outside an explicit transaction are generally committed
automatically.

Example:

```sql
UPDATE accounts
SET balance = balance + 100
WHERE account_id = 2;
```

Outside an explicit transaction, this statement is generally
committed automatically when it succeeds and autocommit
is enabled.

### Explicit transaction with AUTOCOMMIT enabled

Even when autocommit is enabled, we can explicitly begin
and control a transaction.

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 100
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE account_id = 2;

COMMIT;
```

The explicit transaction controls when the changes are committed.

---

## 13. InnoDB and transactions

InnoDB is MySQL's transactional storage engine.

It supports:

- ACID transactions
- Foreign keys
- Row-level locking
- Crash recovery
- Clustered indexes
- Transactional rollback

Transactional operations require a transactional storage engine
such as InnoDB.

---

## 14. Important transaction caveats

### Transactional storage engines

Transactions rely on storage engines that support transactional
behavior, such as InnoDB.

### DDL and implicit commits

Many DDL statements such as:

- CREATE TABLE
- ALTER TABLE
- DROP TABLE

cause implicit commits in MySQL.

They are not ordinary rollbackable transaction operations.

### Errors do not always automatically roll back everything

A failed SQL statement does not always automatically roll
back the entire transaction.

Depending on the error and execution context, the transaction
may remain active.

The developer or transaction handler must determine
whether to continue, roll back to a savepoint, or roll back
the entire transaction.

### SAVEPOINT is not COMMIT

A savepoint does not commit data.

Changes before and after savepoints remain uncommitted
until the transaction is committed or rolled back.

---

## 15. Important SQL commands

### Begin

```sql
START TRANSACTION;
```

### Commit

```sql
COMMIT;
```

### Full rollback

```sql
ROLLBACK;
```

### Savepoint

```sql
SAVEPOINT S1;
```

### Partial rollback

```sql
ROLLBACK TO SAVEPOINT S1;
```

### Check autocommit

```sql
SELECT @@autocommit;
```

---

## 16. Key takeaways

- A transaction groups database operations into a logical unit.
- START TRANSACTION begins a transaction.
- COMMIT confirms transaction changes.
- ROLLBACK undoes uncommitted changes.
- SAVEPOINT establishes a partial rollback boundary.
- ROLLBACK TO SAVEPOINT undoes changes after the savepoint.
- ACID describes the reliability properties of transaction
  processing.
- Atomicity means all or nothing.
- Consistency preserves defined integrity rules.
- Isolation controls concurrent transaction interactions.
- Durability protects committed changes.
- AUTOCOMMIT is commonly enabled by default in MySQL.
- InnoDB supports transactions and ACID.
- Many DDL statements cause implicit commits.

---

## Final conclusion

Transactions are essential for reliable backend systems.

They allow multiple database operations to be managed
as a logical unit of work.

ACID provides the reliability principles behind
transaction processing.

COMMIT confirms changes, ROLLBACK undoes uncommitted
changes, and SAVEPOINT allows partial rollback within
a transaction.

These concepts are fundamental to backend development,
especially in applications involving payments, orders,
inventory, accounts and concurrent users.
