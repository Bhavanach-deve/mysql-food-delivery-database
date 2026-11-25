
# Day 27 – Indexes and Query Optimization

## Overview

Day 27 focuses on MySQL indexes, how they improve data retrieval,
and how to inspect query execution plans using EXPLAIN.

An index is a data structure that helps MySQL locate records
more efficiently instead of scanning the entire table in many cases.

**Main conclusion: Indexes are primarily used to improve data
retrieval performance.**

However, indexes do not guarantee that every query will become
faster. MySQL's query optimizer decides whether using an index
is beneficial.

---

## 1. What is an Index?

An index is a data structure maintained by the database to help
locate rows efficiently.

Imagine a book:

- Without an index, we may need to scan page after page.
- With an index, we can locate the topic and jump to its page.

A database index works in a similar way.

Example:

```sql
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);
```

This creates an index on the `customer_id` column.

A query such as:

```sql
SELECT *
FROM orders
WHERE customer_id = 105;
```

may use this index to find the matching orders efficiently.

---

## 2. Types of Indexes

### Primary Key Index

A primary key uniquely identifies every row.

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);
```

In InnoDB, the primary key is the clustered index.

### Unique Index

A unique index prevents duplicate indexed values.

```sql
CREATE UNIQUE INDEX idx_customers_email
ON customers(email);
```

MySQL permits multiple NULL values in a UNIQUE index.

### Normal Index

A normal index helps speed up searches but does not enforce
uniqueness.

```sql
CREATE INDEX idx_orders_status
ON orders(status);
```

### Composite Index

A composite index is created using multiple columns.

```sql
CREATE INDEX idx_orders_customer_status
ON orders(customer_id, status);
```

The order of columns matters.

---

## 3. Clustered Index in InnoDB

A clustered index is the index that organizes the actual
table records in its leaf pages.

In InnoDB, the primary key is the clustered index.

Consider:

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);
```

The primary-key B+ tree contains the actual customer records
in its leaf pages, organized by primary-key value.

Conceptually:

```text
          Primary Key B+ Tree
                  |
             Internal Nodes
                  |
              Leaf Pages
                  |
       Complete Customer Records
```

For example:

| customer_id | customer_name | city |
|---|---|---|
| 101 | Asha | Hyderabad |
| 102 | Ravi | Chennai |
| 103 | Meera | Bengaluru |

The clustered index leaf pages contain the complete rows,
not just the customer_id values.

Important:
The rows are logically organized by primary key. This does not
mean every row must occupy a physically adjacent disk location.

### Why only one clustered index?

A table's actual records can be organized by only one clustered
index at a time.

In InnoDB:

1. If a primary key exists, it becomes the clustered index.
2. If no primary key exists, InnoDB chooses the first suitable
   UNIQUE NOT NULL index.
3. If neither exists, InnoDB creates a hidden row ID.

---

## 4. Secondary Index

A secondary index is an index other than the clustered index.

Example:

```sql
CREATE INDEX idx_customers_city
ON customers(city);
```

In InnoDB, a secondary index's leaf entries contain:

- The indexed column value.
- The corresponding primary-key value.

Conceptually:

```text
       Secondary Index: city
                 |
              Leaf Pages
                 |
        city + customer_id
                 |
          Primary Key Value
                 |
                 v
       Clustered Primary Key Index
                 |
          Complete Customer Row
```

### Example

```sql
SELECT *
FROM customers
WHERE city = 'Hyderabad';
```

How does it work?

1. MySQL may search the secondary index on city.
2. It finds matching city entries and their customer_id values.
3. It uses those primary-key values to find the complete records
   in the clustered index.
4. It returns the requested rows.

This additional lookup is needed because the secondary index
does not contain every column of the customer record.

### Why store the primary key in a secondary index?

The primary key identifies the complete table row.

It allows InnoDB to navigate from the secondary index to the
clustered index without relying on a fixed physical row pointer.

---

## 5. Covering Index

A covering index is an index that contains all columns required
by a particular query.

Example:

```sql
SELECT customer_id, city
FROM customers
WHERE city = 'Hyderabad';
```

The secondary index on city contains:

- city
- customer_id

Both requested columns are available in the index.

Therefore, MySQL may retrieve the result directly from the
secondary index without looking up the complete row in the
clustered index.

This can avoid an additional lookup.

But consider:

```sql
SELECT *
FROM customers
WHERE city = 'Hyderabad';
```

The query also needs customer_name, which is not in the
secondary index. MySQL generally needs a clustered-index lookup.

---

## 6. Composite Index and Leftmost-Prefix Rule

Example:

```sql
CREATE INDEX idx_orders_customer_status
ON orders(customer_id, status);
```

The index is organized using customer_id first and status second.

| Query condition | Can use this composite index? |
|---|---|
| customer_id = 105 | Yes |
| customer_id = 105 AND status = 'COMPLETED' | Yes |
| status = 'COMPLETED' | Generally not for a direct lookup |

Why?

MySQL can use the leftmost column or a leftmost sequence
of columns in the composite index.

It cannot generally use the index for an efficient direct lookup
on the second column alone while skipping the first column.

**Remember:** Column order matters when designing composite indexes.

---

## 7. Selectivity

Selectivity describes how effectively a column distinguishes
one row from another.

A column with many distinct values generally has higher
selectivity than a column with only a few distinct values.

Example:

- customer_id: thousands of distinct values.
- status: only PENDING, COMPLETED and CANCELLED.

customer_id usually has higher selectivity.

A highly selective index can narrow down the matching rows
more effectively.

However, a low-selectivity index is not automatically useless.
Its usefulness depends on the query, data distribution,
and execution plan.

---

## 8. Query Optimization with EXPLAIN

EXPLAIN helps us understand how MySQL plans to execute a query.

```sql
EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 105
AND status = 'COMPLETED';
```

Important columns:

| Column | Meaning |
|---|---|
| possible_keys | Indexes MySQL considers possible candidates |
| key | Index MySQL actually chooses |
| rows | Estimated number of rows examined |
| type | Access method |
| Extra | Additional execution information |

If `key` is NULL, MySQL has not chosen an index for that table
access in the execution plan.

### EXPLAIN ANALYZE

```sql
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 105;
```

EXPLAIN ANALYZE executes the query and provides actual execution
information, including actual timing and row counts.

Use it thoughtfully because it really executes the query.

---

## 9. Why Not Index Every Column?

Indexes improve retrieval, but they also have costs.

1. **Storage:** Every index consumes additional disk space.
2. **Write overhead:** INSERT, UPDATE and DELETE operations
   may need to update multiple indexes.
3. **Maintenance:** Too many indexes increase maintenance work
   and can make query optimization more complicated.

Create indexes based on actual query patterns and performance needs.

---

## 10. Important Commands

Create an index:

```sql
CREATE INDEX idx_name
ON table_name(column_name);
```

Create a composite index:

```sql
CREATE INDEX idx_name
ON table_name(column1, column2);
```

Create a unique index:

```sql
CREATE UNIQUE INDEX idx_name
ON table_name(column_name);
```

Inspect a query plan:

```sql
EXPLAIN
SELECT *
FROM table_name
WHERE column_name = 'value';
```

Drop an index:

```sql
DROP INDEX idx_name
ON table_name;
```

---
## Final Conclusion

**Indexes are primarily used to improve data retrieval performance
by helping MySQL locate rows efficiently.**

They are not free: they consume storage and require maintenance
during data modifications.

The goal is not to create as many indexes as possible.
The goal is to create the right indexes for the queries
the application actually executes.
